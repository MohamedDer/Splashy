//
//  DetailsViewController.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
    
    let unsplashPhoto: Photo
    
    let scaleTransitionAnimator = ScaleTransitionAnimator()
    let slideDismissalAnimator = SlideDismissalAnimator()

    init(unsplashPhoto: Photo) {
        self.unsplashPhoto = unsplashPhoto
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .gray.withAlphaComponent(0.7)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var photoDetailsView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        setupViews()
        configureContent()
        setupPhotoDetailsView()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(mainImageView)
        containerView.addSubview(closeButton)
    }
    
    private func configureContent() {
        mainImageView.kf.setImage(
            with: URL(string: unsplashPhoto.urls.regular),
            placeholder: UIImage(blurHash: unsplashPhoto.blurHash, size: .init(width: 30, height: 20)),
            options: [
                .cacheOriginalImage,
                .transition(.fade(0.3))
            ],
            completionHandler: { _ in }
        )
    }
    
    private func setupPhotoDetailsView() {
        let hostingController = UIHostingController(rootView: PhotoDetailsView(viewModel: .init(photo: unsplashPhoto)))
        let view = hostingController.view
        view?.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        containerView.addSubview(view!)
        hostingController.didMove(toParent: self)
        photoDetailsView = view
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
            mainImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            mainImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            mainImageView.heightAnchor.constraint(equalToConstant: 393),
            
            closeButton.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            
            photoDetailsView!.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 16),
            photoDetailsView!.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            photoDetailsView!.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            photoDetailsView!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - UIViewControllerTransitioningDelegate
extension DetailsViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return scaleTransitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slideDismissalAnimator
    }
}
