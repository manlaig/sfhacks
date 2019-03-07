import Foundation
import ARKit
import SpriteKit
import FirebaseDatabase
import Firebase

class Networking
{
    init() {}
    
    static func UploadToServer(lat: Double, lon: Double, name: String)
    {
        let ref = Database.database().reference()
        ref.childByAutoId().setValue(["lat": lat, "lon": lon, "string": name])
    }
}
