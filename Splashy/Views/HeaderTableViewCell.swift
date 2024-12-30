//
//  HeaderTableViewCell.swift
//  Splashy
//
//  Created by Mohamed Derkaoui on 08/09/2024.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    static let preferredHeight: CGFloat = 100
    private let defaultPadding: CGFloat = 16
    static let reuseIdentifier = "HeaderTableViewCell"

    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMMM"
        label.text = dateFormatter.string(from: Date())
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(todayLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultPadding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultPadding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultPadding),
            
            todayLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            todayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultPadding),
            todayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultPadding),
            todayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultPadding)
        ])
        
    }
}
