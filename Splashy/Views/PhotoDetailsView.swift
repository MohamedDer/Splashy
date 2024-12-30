//
//  PhotoDetailsView.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.
//

import SwiftUI
import Kingfisher

struct PhotoDetailsView: View {
    
    @ObservedObject var viewModel: PhotoDetailsViewModel    
    @Environment(\.openURL) var openURL
    @State var isLoading: Bool = true

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Stats")
                    .font(.system(size: 32, weight: .bold))
                
                HStack(alignment: .center, spacing: 15) {
                    HStack(spacing: 5) {
                        Image(systemName: "chart.line.uptrend.xyaxis.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        Text(viewModel.views)
                            .transition(.opacity)
                            .id("views" + viewModel.views)

                    }
                    
                    HStack(spacing: 5) {
                        Image(systemName: "arrow.down.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        Text(viewModel.downloads)
                            .transition(.opacity)
                            .id("downloads" + viewModel.downloads)


                    }
                    
                    HStack(spacing: 5) {
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        Text(viewModel.likes)
                            .transition(.opacity)
                            .id("likes" + viewModel.likes)


                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Photograph")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.bottom, 5)
                
                HStack(spacing: 10) {
                    KFImage.url(URL(string: viewModel.photo.user.profileImage.medium))
                        .cacheOriginalImage()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(
                            withAnimation(.linear) {
                                Circle().stroke(.black, lineWidth: 3)
                            }
                        )
                        .shadow(radius: 5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 5) {
                            Text(viewModel.photo.user.name)
                                .font(.title2)
                            
                            Image(systemName: "link")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.gray)
                                .opacity(viewModel.photo.user.portfolioUrl != nil ? 1 : 0)
                                .onTapGesture {
                                    if let redirectionUrl = viewModel.photo.user.portfolioUrl {
                                        openURL(URL(string: redirectionUrl)!)
                                    }
                                }
                        }
                        Text(viewModel.photo.user.username)
                            .font(.title3)
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVStack {
                    PhotoGridView(photos: viewModel.userPhotos)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)

            }
            .padding(3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(isLoading ? 0 : 1)
            .onAppear {
                withAnimation(.easeOut(duration: 1), {
                    isLoading.toggle()
                })
                Task {
                    await viewModel.fetchPhotoDetail()
                    await viewModel.loadUserPhotos()

                }
            }
        }
    }
}
