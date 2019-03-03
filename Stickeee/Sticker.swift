//
//  Sticker.swift
//  Stickeee
//
//  Created by Michael Ganzorig on 3/2/19.
//  Copyright © 2019 Michael Ganzorig. All rights reserved.
//

import Foundation
import ARKit
import SpriteKit

class Sticker
{
    let anchor: ARAnchor
    let image: String?
    let lat: Double
    let lon: Double
    
    init(transform: simd_float4x4, sceneView: ARSKView, latitude: Double, longitude: Double)
    {
        lat = latitude
        lon = longitude
        
        anchor = ARAnchor(transform: transform)
        image = SpawnManager.selectedSticker
        sceneView.session.add(anchor: anchor)
        
        SpawnManager.spawnedStickers += [self]
    }
}
