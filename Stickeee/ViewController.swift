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

class ViewController: UIViewController, ARSKViewDelegate, UITextFieldDelegate {
    
    //scene view for AR
    @IBOutlet var sceneView: ARSKView!
    
    //text box
    @IBOutlet weak var textBox: UITextField!
    
    
    //after pressing done on text box
    @IBAction func pressedEnd(_ sender: Any) {
        textBox.isHidden = true //hides text box
        button.isHidden = false //shows button
        textBox.resignFirstResponder()
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
    
    var userInput = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client()
        
        Networking.SendToServer(endPoint: "addUser", sendrequest: "PUT")
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
        
        print(self.userInput)
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
        return SKSpriteNode(imageNamed: SpawnManager.selectedSticker)
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
