//
//  User.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.
//

import Foundation

struct User: Codable {
    let id: String
    let username: String
    let name: String
    let portfolioUrl: String?
    let bio: String?
    let location: String?
    let totalLikes: Int
    let totalPhotos: Int
    let totalCollections: Int
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case id, username, name, bio, location
        case portfolioUrl = "portfolio_url"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case profileImage = "profile_image"
    }
}
