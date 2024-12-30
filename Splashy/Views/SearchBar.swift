//
//  SearchBar.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 16/09/2024.
//

import SwiftUI

struct SearchBar: View {
    
    @ObservedObject private var viewModel: SearchBarViewModel
    
    init(viewModel: SearchBarViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        HStack {
            if !viewModel.isSearchState {
                Image("unsplash")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .scaledToFit()
                    .padding(.leading, 10)
                
            }
            
            TextField("Let's explore...", text: $viewModel.searchText)
                .searchable(text: $viewModel.searchText)
                .fontWidth(.standard)
                .font(.title2)
            
            
            Spacer()
            
            if viewModel.isSearchState {
                Image(systemName: "xmark.circle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .resizable()
                    .frame(width: 35)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.3)) {
                            viewModel.resetState()
                        }
                    }
            }
            
            Button(action: {
                viewModel.submitSearch()
            }) {
                Image(systemName: "magnifyingglass.circle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .tint(Color.black)
            }
        }
        .padding(8)
        .frame(height: 50)
        .background(Color.gray.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.gray.opacity(0.1), lineWidth: 2)
        )
        .animation(.easeInOut(duration: 0.2), value: viewModel.isSearchState)
    }
}

#Preview {
    SearchBar(viewModel: .mockViewModel)
}
