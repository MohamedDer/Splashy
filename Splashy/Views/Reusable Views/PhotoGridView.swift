import SwiftUI
import Kingfisher

struct PhotoGridView: View {
    let photos: [Photo]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(photos, id: \.self) { photo in
                    
                    KFImage.url(URL(string: photo.urls.regular))
                        .placeholder {
                            Image(uiImage: UIImage(blurHash:  photo.blurHash,
                                                   size: .init(width: 30, height: 20))!) // fall back on photo.color instead of !
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 180, height: 180)
                            .clipped()
                        }
                        .cacheOriginalImage()
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .cornerRadius(10)
                }
            }
        }
    }
}
