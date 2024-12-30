//
//  PhotoCardTableViewCell.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.
//

import UIKit
import Kingfisher

class PhotoCardTableViewCell: UITableViewCell {
    
    struct ViewModel {
        let unsplashPhoto: Photo
    }
    
    static let preferredHeight: CGFloat = 400
    static let reuseIdentifier = "PhotoCardTableViewCell"
        
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.LayoutMetrics.smallImage.rawValue / 2
        imageView.backgroundColor = .lightGray
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let likesCounLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private var viewModel: ViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cardImageView.kf.cancelDownloadTask()
        cardImageView.image = nil
        userImageView.kf.cancelDownloadTask()
        userImageView.image = nil
        
        titleLabel.text = nil
        usernameLabel.text = nil
        likesCounLabel.text = nil
    }
    
    private func setupCell() {
        contentView.addSubview(cardImageView)
        cardImageView.addSubview(titleLabel)
        cardImageView.addSubview(userImageView)
        cardImageView.addSubview(bottomStackView)
        
        bottomStackView.addArrangedSubview(usernameLabel)
        bottomStackView.addArrangedSubview(likesCounLabel)

        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: Constants.LayoutMetrics.verticalPadding.rawValue),
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Constants.LayoutMetrics.horizontalPadding.rawValue),
            cardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Constants.LayoutMetrics.horizontalPadding.rawValue),
            cardImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -Constants.LayoutMetrics.verticalPadding.rawValue),
            
            titleLabel.topAnchor.constraint(equalTo: cardImageView.topAnchor,
                                            constant: Constants.LayoutMetrics.verticalPadding.rawValue),
            titleLabel.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor,
                                                constant: Constants.LayoutMetrics.horizontalPadding.rawValue),
            titleLabel.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor,
                                                 constant: -Constants.LayoutMetrics.horizontalPadding.rawValue),
            
            userImageView.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor,
                                                  constant: -Constants.LayoutMetrics.horizontalPadding.rawValue),
            userImageView.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor,
                                                   constant: Constants.LayoutMetrics.horizontalPadding.rawValue),
            userImageView.widthAnchor.constraint(equalToConstant: Constants.LayoutMetrics.smallImage.rawValue),
            userImageView.heightAnchor.constraint(equalToConstant: Constants.LayoutMetrics.smallImage.rawValue),
            
            bottomStackView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            bottomStackView.trailingAnchor.constraint(lessThanOrEqualTo: cardImageView.trailingAnchor, constant: -16)
        ])
        selectionStyle = .none
    }
    
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.unsplashPhoto.description
        usernameLabel.text = viewModel.unsplashPhoto.user.username
        likesCounLabel.text = "\(viewModel.unsplashPhoto.likes) likes"
        
        cardImageView.kf.setImage(
            with: URL(string: viewModel.unsplashPhoto.urls.regular),
            placeholder: UIImage(blurHash: viewModel.unsplashPhoto.blurHash,
                                 size: .init(width: 30, height: 20)),
            options: [
                .cacheOriginalImage,
                .transition(.fade(0.3))
            ],
            completionHandler: { _ in }
        )
        
        userImageView.kf.setImage(
            with: URL(string: viewModel.unsplashPhoto.user.profileImage.medium),
            options: [
                .cacheOriginalImage,
                .transition(.fade(0.3))
            ],
            completionHandler: { _ in }
        )
    }
}


extension PhotoCardTableViewCell {
    struct Constants {
        enum LayoutMetrics: CGFloat {
            case verticalPadding = 10
            case horizontalPadding = 16
            case smallImage = 40
        }
    }
}
