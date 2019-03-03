//
//  Client.swift
//  Stickeee
//
//  Created by Michael Ganzorig on 3/2/19.
//  Copyright © 2019 Michael Ganzorig. All rights reserved.
//

import Foundation

class Client
{
    init()
    {
        DispatchQueue.global(qos: .background).async
        {
            print("This is run on the background queue")
        }
    }
}
