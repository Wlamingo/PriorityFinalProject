//
//  TaskTableViewCell.swift
//  FinalProject
//
//  Created by 이승우 on 2021/12/03.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    var nameLabel = UILabel()
    var descriptionLabel = UILabel()

    let padding: CGFloat = 8
    let nameLabelHeight: CGFloat = 16

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel = UILabel()
        descriptionLabel.textColor = .gray
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
        ])
    }

    func configure(for task: Task) {
        nameLabel.text = task.name
        descriptionLabel.text = task.description
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
