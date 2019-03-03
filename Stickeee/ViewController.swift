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

class ViewController: UIViewController, ARSKViewDelegate, UITextFieldDelegate {
<<<<<<< HEAD
    static var userInput = ""
=======
    
    
    var userInput = ""
>>>>>>> 10217d3b1e633186e61be20ff6b923bf19633949
    
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
        
        //Client()
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
    
    func addListenerToDatabase()
    {
        let ref = Database.database().reference()
        
        ref.observe(.childAdded, with: { (snapshot) -> Void in
            for child in snapshot.children.allObjects as? [DataSnapshot] ?? []
            {
                // later on prevent double spawn of stickers
                //Networking.newStickerFromDatabase()
                print("Key: " + String(child.key as? String ?? "none") + "Value: " + String(child.value as? Double ?? -1))
            }
        })
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
<<<<<<< HEAD
        let labelNode = SKLabelNode(text: ViewController.userInput)
=======
        let labelNode = SKLabelNode(text: userInput)
        labelNode.fontName = "Arial"
        labelNode.fontSize = 11
>>>>>>> 10217d3b1e633186e61be20ff6b923bf19633949
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
