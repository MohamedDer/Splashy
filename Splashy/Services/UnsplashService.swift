//
//  UnsplashService.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.
//

import Foundation

enum UnsplashError: Error {
    case invalidURL
    case noData
    case decodingError
}

class UnsplashService {
    static let shared = UnsplashService()
    
    private let baseURL = "https://api.unsplash.com"
    private let accessKey = "xxxx" // To store on XCConfig..
    private let urlCache = URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
    
    private init() {}
    
    func fetchPhotos(count: Int = 10) async throws -> [Photo] {
        let endpoint = "/photos?per_page=\(count)"
        return try await fetchData(endpoint: endpoint)
    }
    
    func fetchPhotoStats(photoID: String) async throws -> PhotoDetail {
        let endpoint = "/photos/\(photoID)/statistics"
        return try await fetchData(endpoint: endpoint)
    }
    
    func fetchUserPhotos(username: String) async throws -> [Photo] {
        let endpoint = "/users/\(username)/photos"
        return try await fetchData(endpoint: endpoint)
    }
    
    private func fetchData<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw UnsplashError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        
        if let cachedResponse = urlCache.cachedResponse(for: request) {
            do {
                return try JSONDecoder().decode(T.self, from: cachedResponse.data)
            } catch {
                print("Cache decoding error: \(error)")
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw UnsplashError.noData
        }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedResponse, for: request)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw UnsplashError.decodingError
        }
    }
}
