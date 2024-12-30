//
//  FeedViewController.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.
//

import UIKit

class FeedViewController: UIViewController {
    var photos: [Photo] = [] {
        didSet {
            updateViewModels(with: photos)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var viewModels: [PhotoCardTableViewCell.ViewModel] = []
    
    private let unsplashService = UnsplashService.shared
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(SearchBarTableViewCell.self,
                           forCellReuseIdentifier: SearchBarTableViewCell.reuseIdentifier)
        tableView.register(HeaderTableViewCell.self,
                           forCellReuseIdentifier: HeaderTableViewCell.reuseIdentifier)
        tableView.register(PhotoCardTableViewCell.self,
                           forCellReuseIdentifier: PhotoCardTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        transitioningDelegate = self
        view.addSubview(tableView)
        setupConstraints()
        
        Task {
            await fetchPhotos()
        }
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateViewModels(with photos: [Photo]) {
        viewModels = photos.map { photo in
            PhotoCardTableViewCell.ViewModel(unsplashPhoto: photo)
        }
        tableView.reloadData()
    }
    
    private func fetchPhotos() async {
        do {
            photos = try await unsplashService.fetchPhotos()
        } catch {
            await MainActor.run {
                showError(error)
            }
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
