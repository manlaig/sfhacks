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

class Networking
{
    init() {}
    
    static func UploadToServer(sticker: Sticker?)
    {
        let ref = Database.database().reference()
        ref.childByAutoId().setValue(["lat": sticker?.lat, "lon": sticker?.lon, "string": sticker?.anchor.name])
    }
}
