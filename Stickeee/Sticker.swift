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
    let position : simd_float4x4
    let image: String?
    
    init(transform: simd_float4x4, sceneView: ARSKView)
    {
        position = transform
        anchor = ARAnchor(transform: transform)
        image = SpawnManager.selectedSticker
        sceneView.session.add(anchor: anchor)
        
        SpawnManager.spawnedStickers += [self]
    }
}
