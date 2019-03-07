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
    
    init(_ transform: simd_float4x4, _ sceneView: ARSKView, _ latitude: Double, _ longitude: Double, _ lab: String)
    {
        lat = latitude
        lon = longitude
        
        anchor = ARAnchor(name: lab, transform: transform)
        sceneView.session.add(anchor: anchor)
        
    }
    
    static func LatLonToMetres(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double
    {
        print("From lat: " + String(lat1))
        print("From lon: " + String(lon1))
        let co1 = CLLocation(latitude: lat1, longitude: lon1)
        let co2 = CLLocation(latitude: lat2, longitude: lon2)
        
        return co1.distance(from: co2)
        
        /*let R = 6378.137 // Radius of earth in KM
        let dLat = lat2 * Double.pi / 180 - lat1 * Double.pi / 180;
        let dLon = lon2 * Double.pi / 180 - lon1 * Double.pi / 180;
        let a = sin(dLat/2) * sin(dLat/2) + cos(lat1 * Double.pi / 180) * cos(lat2 * Double.pi / 180) * sin(dLon/2) * sin(dLon/2);
        let c = 2 * atan2(sqrt(a), sqrt(1-a));
        let d = R * c;
        return d * 1000; // meters*/
    }
    
    static func GetXY(lat2: Double, lon2: Double) -> Dictionary<String, Double>
    {
        let currLocation = (UIApplication.shared.delegate as! AppDelegate).getLocation()
        let lat1 = currLocation.coordinate.latitude
        let lon1 = currLocation.coordinate.longitude
        
        if lon1 == lon2 && lat1 == lat2
        {
            return ["x": 0, "y": 0]
        }
        var y = lat2 - lat1
        var x = lon2 - lon1
        
        y = y / sqrt(y*y + x*x)
        x = x / sqrt(y*y + x*x)
        print("x: " + String(x) + " y: " + String(y))
        
        let dist = LatLonToMetres(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2)
        print("Dist: " + String(dist))
        return ["x": dist * x, "y": dist * y]
    }
}
