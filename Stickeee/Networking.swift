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

class Networking
{
    static func SendToServer(endPoint: String, sendrequest: String)
    {
        let url = URL(string: "https://stickplace.appspot.com/" + endPoint)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = sendrequest
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let _ = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "Unknown error")
                    return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        
        task.resume()
    }
    
    static func UploadToServer(sticker: Sticker?)
    {
        let url = URL(string: "https://stickplace.appspot.com/app")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Double] = [
            //"posx": sticker?.position.columns.3.x ?? -1,
            //"posy": sticker?.position.columns.3.y ?? -1,
            //"posz": sticker?.position.columns.3.z ?? -1,
            "lat": sticker?.lat ?? 0,
            "lon": sticker?.lon ?? 0
        ]
        
        do
        {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {}
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            
            /*guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }*/
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        
        task.resume()
    }
}
