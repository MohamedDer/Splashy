//
//  FeedViewController+TableViewDelegate.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.
//

import UIKit

enum HomeCellType: Int, CaseIterable {
    case search
    case header
    case card
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellType = HomeCellType(rawValue: section) else { return 0 }
        switch cellType {
        case .search:
            return 1
        case .header:
            return 1
        case .card:
            return viewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = HomeCellType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .search:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarTableViewCell.reuseIdentifier, for: indexPath) as? SearchBarTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.reuseIdentifier, for: indexPath) as? HeaderTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .card:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCardTableViewCell.reuseIdentifier, for: indexPath) as? PhotoCardTableViewCell else {
                return UITableViewCell()
            }
            
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = HomeCellType(rawValue: indexPath.section) else {
            return UITableViewCell.layoutFittingCompressedSize.height
        }
        
        switch cellType {
        case .search:
            return HeaderTableViewCell.preferredHeight
        case .header:
            return HeaderTableViewCell.preferredHeight
        case .card:
            return PhotoCardTableViewCell.preferredHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellType = HomeCellType(rawValue: indexPath.section) else {
            return
        }
        
        switch cellType {
            
        case .card:
            if let cell = tableView.cellForRow(at: indexPath) as? PhotoCardTableViewCell {
                let cellFrame = tableView.convert(cell.frame, to: tableView.superview)
                let selectedPhoto = photos[indexPath.row]

                showDetailsViewController(from: cellFrame, for: selectedPhoto)
            }
        case .header, .search:
            break
        }
    }
    
}

// MARK: - Navigation
extension FeedViewController {
    func showDetailsViewController(from originFrame: CGRect,for photo: Photo) {
        
        let detailsViewController = DetailsViewController(unsplashPhoto: photo)
        
        detailsViewController.scaleTransitionAnimator.originFrame = originFrame
        detailsViewController.scaleTransitionAnimator.destinationFrame = detailsViewController.view.bounds
        
        detailsViewController.modalPresentationStyle = .fullScreen
        
        present(detailsViewController, animated: true)
    }
}
