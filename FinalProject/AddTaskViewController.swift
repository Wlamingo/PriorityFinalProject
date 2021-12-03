//
//  AddTaskViewController.swift
//  FinalProject
//
//  Created by 이승우 on 2021/12/03.
//

import Foundation
import UIKit
import Alamofire
import SnapKit

class AddTaskViewController: UIViewController {

    let nameTextField = UITextField()
    let descriptionTextField = UITextField()
    let addButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 255/255, green: 175/255, blue: 175/255, alpha: 1)

        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 10
        nameTextField.placeholder = "Task Title"
//        nameTextField.font = 20
        view.addSubview(nameTextField)
        
        descriptionTextField.backgroundColor = .white
        descriptionTextField.layer.cornerRadius = 10
        descriptionTextField.placeholder = "Task Description"
//        descriptionTextField.font?.pointSize = 15
        view.addSubview(descriptionTextField)

        addButton.setTitle("Add Task", for: .normal)
        addButton.backgroundColor = UIColor(red: 255/255, green: 175/255, blue: 175/255, alpha: 1)
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(touchAddButton), for: .touchUpInside)
        view.addSubview(addButton)

        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(20)
        }

        descriptionTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
        }

        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    @objc func touchAddButton() {
        if let name = nameTextField.text, let description = descriptionTextField.text, name != "" && description != "" {
            NetworkManager.addTask(name: name, description: description) { course in
                print(course)
            }
            dismiss(animated: true, completion: nil)
        }
    }

}
