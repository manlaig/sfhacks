//
//  ViewController.swift
//  Stickeee
//
//  Created by Michael Ganzorig on 3/2/19.
//  Copyright © 2019 Michael Ganzorig. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit
import FirebaseDatabase
import Firebase

class ViewController: UIViewController, ARSKViewDelegate, UITextFieldDelegate
{
    static var userInput = ""

    //scene view for AR
    @IBOutlet var sceneView: ARSKView!
    
    //text box
    @IBOutlet weak var textBox: UITextField!
    
    
    //after pressing done on text box
    @IBAction func pressedEnd(_ sender: Any) {
        textBox.isHidden = true //hides text box
        button.isHidden = false //shows button
        textBox.resignFirstResponder()
        ViewController.userInput = textBox.text!
    }
    
    
    //button to show textbox
    @IBOutlet weak var button: UIButton!
    
    //action from pressing button
    @IBAction func showButton(_ sender: Any)
    {
        textBox.isHidden = false //shows text box
        button.isHidden = true //hides button
        textBox.becomeFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addListenerToDatabase()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }

    }
    
    func drawPreviousStickers()
    {
        let ref = Database.database().reference()
    }
    
    func addListenerToDatabase()
    {
        let ref = Database.database().reference()
        
        ref.observe(.childAdded, with: { (snapshot) -> Void in
            // just for max value
            var lat: Double = 10000
            var lon: Double = 10000
            var string: String?
            
            print((UIApplication.shared.delegate as? AppDelegate)?.getMagneticHeading())
            
            for child in snapshot.children.allObjects as? [DataSnapshot] ?? []
            {
                // later on prevent double spawn of stickers
                //Networking.newStickerFromDatabase()
                if let val = child.value as? Double
                {
                    if lat == 10000
                    {
                        lat = val
                    }
                    else
                    {
                        lon = val
                    }
                    print("Key: " + (child.key as? String ?? "none") + " Value: " + String(val))
                } else
                {
                    string = child.value as? String ?? "none"
                    print("Key: " + String(child.key as? String ?? "none") + " Value: " + string!)
                }
            }
            
            self.newStickerFromDatabase(newLat: lat, newLon: lon, label: string!)
        })
    }
    
    func newStickerFromDatabase(newLat: Double, newLon: Double, label: String)
    {
        // Add a new sticker
        let currLocation = (UIApplication.shared.delegate as! AppDelegate).getLocation()
        if currLocation != nil
        {
            guard let sceneView = self.view as? ARSKView else {
                return
            }
            
            
            if let currentFrame = sceneView.session.currentFrame
            {
                var translation = matrix_identity_float4x4
                
                let xy = Sticker.GetXY(lat1: currLocation.coordinate.latitude, lon1: currLocation.coordinate.longitude, lat2: newLat, lon2: newLon)
                
                
                translation.columns.3.x = Float(xy["x"]!)
                translation.columns.3.z = Float(xy["y"]!)
                let transform = simd_mul(currentFrame.camera.transform, translation)
                Sticker(transform: transform, sceneView: sceneView, latitude: xy["x"]!, longitude: xy["y"]!, lab: label)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        let labelNode = SKLabelNode(text: anchor.name)
        labelNode.fontName = "Arial"
        labelNode.fontSize = 11
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode;
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
}
