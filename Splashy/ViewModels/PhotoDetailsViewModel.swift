//
//  PhotoDetailsViewModel.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.
//

import Foundation

class PhotoDetailsViewModel: ObservableObject {
    
    @Published var userPhotos: [Photo] = []
    @Published var errorMessage: String?
    
    @Published var photoDetail: PhotoDetail?
    @Published var photo: Photo
        
    var views: String {
        photoDetail?.views.total.description ?? "-"
    }
    
    var downloads: String {
        photoDetail?.downloads.total.description ?? "-"
    }
    
    var likes: String {
        photoDetail?.likes.total.description ?? "-"
    }
    

    
    private let unsplashService = UnsplashService.shared
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    func fetchPhotoDetail() async {
        do {
            let detail = try await unsplashService.fetchPhotoStats(photoID: photo.id)
            DispatchQueue.main.async {
                self.photoDetail = detail
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func loadUserPhotos() async {
        do {
            let photos = try await unsplashService.fetchUserPhotos(username: photo.user.username)
            DispatchQueue.main.async {
                self.userPhotos = photos
            }
        } catch {
            self.errorMessage = error.localizedDescription
            
        }
    }
    
}

