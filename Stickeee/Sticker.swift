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
import CoreLocation

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
        let co1 = CLLocation(latitude: lat1, longitude: lon1)
        let co2 = CLLocation(latitude: lat2, longitude: lon2)
        
        return co1.distance(from: co2)
    }
    
    static func GetXY(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Dictionary<String, Double>
    {
        if(lon1 == lon2 && lat1 == lat2)
        {
            return ["x": 0, "y": 0]
        }
        
        let y = lat2 - lat1
        let x = lon2 - lon1
        
        y / sqrt(y*y + x*x)
        x / sqrt(y*y + x*x)
        print("x: " + String(x) + " y: " + String(y))
        
        /*let heading = (UIApplication.shared.delegate as! AppDelegate).getMagneticHeading()
        
        var t: Double = 1.0
        if x != 0
        {
            t = atan(y/x)
        }
        print("t: " + String(t))*/
        let dist = LatLonToMetres(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2)
        print("Dist: " + String(dist))
        return ["x": dist * y, "y": dist * x]
    }
}
