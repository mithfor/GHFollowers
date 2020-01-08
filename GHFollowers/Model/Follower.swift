//
//  Follower.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 08.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import Foundation

struct Follower: Codable {
    var lo1gin: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case lo1gin
        case avatarUrl = "avatar_url"
    }
}
