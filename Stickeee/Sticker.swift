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
import Darwin

class Sticker
{
    let anchor: ARAnchor
    let lat: Double
    let lon: Double
    
    init(transform: simd_float4x4, sceneView: ARSKView, latitude: Double, longitude: Double, lab: String)
    {
        lat = latitude
        lon = longitude
        
        anchor = ARAnchor(name: lab, transform: transform)
        sceneView.session.add(anchor: anchor)
        
    }
    
    static func LatLonToMetres(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double
    {
        let R = 6378.137 // Radius of earth in KM
        let dLat = lat2 * Double.pi / 180 - lat1 * Double.pi / 180;
        let dLon = lon2 * Double.pi / 180 - lon1 * Double.pi / 180;
        let a = sin(dLat/2) * sin(dLat/2) +
            cos(lat1 * Double.pi / 180) * cos(lat2 * Double.pi / 180) *
            sin(dLon/2) * sin(dLon/2);
        let c = 2 * atan2(sqrt(a), sqrt(1-a));
        let d = R * c;
        return d * 1000; // meters
    }
    
    static func GetXY(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Dictionary<String, Double>
    {
        // unit vector
        let y = lat2 - lat1
        let x = lon2 - lon1
        
        let normalizedY = y/sqrt(pow(x,2) + pow(y, 2))
        let normalizedX = x/sqrt(pow(x,2) + pow(y, 2))
        let dist = LatLonToMetres(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2)
        return ["x": normalizedX * dist, "y": normalizedY * dist]
    }
}
