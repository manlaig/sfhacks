//
//  Networking.swift
//  Stickeee
//
//  Created by Michael Ganzorig on 3/2/19.
//  Copyright © 2019 Michael Ganzorig. All rights reserved.
//

import Foundation
import ARKit
import SpriteKit
import FirebaseDatabase
import Firebase

class Networking: NSObject
{
    static func UploadToServer(sticker: Sticker?)
    {
        let ref = Database.database().reference()
        
        ref.childByAutoId().setValue(["lat": sticker?.lat, "lon": sticker?.lon, "string": ViewController.userInput])
    }
    
    /*static func newStickerFromDatabase(newLat: Double, newLon: Double)
    {
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.2
        let transform = simd_mul(currentFrame.camera.transform, translation)
        
        // Add a new sticker
        let currLocation = (UIApplication.shared.delegate as! AppDelegate).getLocation()
        
        if currLocation != nil
        {
            let sticker = Sticker(transform: transform, sceneView: sceneView, latitude: currLocation.coordinate.latitude, longitude: currLocation.coordinate.longitude)
            SpawnManager.spawnedStickers += [sticker]
        } else
        {
            print("Location null")
        }
    }*/
}
