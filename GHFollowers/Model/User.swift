//
//  User.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 08.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case name
        case location
        case bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case htmlUrl = "html_url"
        case following
        case followers
        case createdAt = "created_at"
    }
}

