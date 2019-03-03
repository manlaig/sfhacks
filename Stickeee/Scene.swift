//
//  Scene.swift
//  Stickeee
//
//  Created by Michael Ganzorig on 3/2/19.
//  Copyright © 2019 Michael Ganzorig. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.2
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new sticker
            let currLocation = (UIApplication.shared.delegate as! AppDelegate).getLocation()
            
            if currLocation != nil && ViewController.userInput != ""
            {
                let sticker = Sticker(transform: transform, sceneView: sceneView, latitude: currLocation.coordinate.latitude, longitude: currLocation.coordinate.longitude, lab: ViewController.userInput)
                Networking.UploadToServer(sticker: sticker)
            } else
            {
                print("The sticker is null")
            }
        }
    }
}
