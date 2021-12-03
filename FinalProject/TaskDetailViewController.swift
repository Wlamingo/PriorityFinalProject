//
//  TaskDetailViewController.swift
//  FinalProject
//
//  Created by 이승우 on 2021/12/03.
//

import UIKit
import Foundation

class TaskDetailViewController: UIViewController {

    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var priorityButton = UIButton()
    var task: Task

    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = task.name
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = task.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .black
        view.addSubview(descriptionLabel)
        
        
        priorityButton.translatesAutoresizingMaskIntoConstraints = false
        priorityButton.setTitle("Mark as Priority", for: .normal)
        priorityButton.setTitleColor(.black, for: .normal)
        priorityButton.backgroundColor = UIColor(red: 255/255, green: 175/255, blue: 175/255, alpha: 1)
        priorityButton.layer.cornerRadius = 5
        priorityButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(priorityButton)
        
        

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        ])

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        ])

        NSLayoutConstraint.activate([
            priorityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priorityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            priorityButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            priorityButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}


