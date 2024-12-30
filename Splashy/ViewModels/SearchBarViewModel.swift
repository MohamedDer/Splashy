//
//  SearchBarViewModel.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 16/09/2024.
//

import SwiftUI

class SearchBarViewModel: ObservableObject {
    
    @Published var searchText: String
    var isSearchState: Bool {
        !searchText.isEmpty
    }
    
    static var mockViewModel = SearchBarViewModel(searchText: "")
    
    init(searchText: String) {
        self.searchText = searchText
    }
    
    func resetState() {
        print(" ViewModel ---- State cleared")

        searchText = ""
    }
    
    func submitSearch() {
        if !searchText.isEmpty {
            print(" ViewModel ---- Search triggered for \(searchText)")
        }
    }
    
    
}
