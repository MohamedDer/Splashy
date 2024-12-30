//
//  SearchBarTableViewCell.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 16/09/2024.
//

import UIKit
import SwiftUI

class SearchBarTableViewCell: UITableViewCell {
    
    static let preferredHeight: CGFloat = 40
    static let reuseIdentifier = "SearchBarTableViewCell"
    
    private var hostingController: UIHostingController<SearchBar>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupHostingController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHostingController() {
        let dummyVM = SearchBarViewModel.mockViewModel
        let searchBarView = SearchBar(viewModel: dummyVM)
        
        hostingController = UIHostingController(rootView: searchBarView)
        
        if let hostingView = hostingController?.view {
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(hostingView)
            
            NSLayoutConstraint.activate([
                hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

