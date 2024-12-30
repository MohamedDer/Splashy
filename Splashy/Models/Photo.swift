//
//  Photo.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.

import Foundation

struct Photo: Codable, Hashable {

    let id: String
    let createdAt: String
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let likes: Int
    let description: String?
    let user: User
    let urls: PhotoURL
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, color, likes, description, user, urls
        case createdAt = "created_at"
        case blurHash = "blur_hash"
    }
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
