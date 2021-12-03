//
//  ViewController.swift
//  FinalProject
//
//  Created by 이승우 on 2021/12/02.
//

import SnapKit
import UIKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    
    let searchController = UISearchController()

    let taskTableView = UITableView()
    let refreshControl = UIRefreshControl()

    var tasks = [Task]()
    var filteredTasks = [Task]()
    
    let reuseIdentifier = "ClassTableViewCellReuse"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        
        initSearchController()
        
        view.backgroundColor = .white

        navigationItem.setRightBarButton(UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped)), animated: false)

        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        taskTableView.addSubview(refreshControl)
        view.addSubview(taskTableView)

        setupConstraints()
        getTasks()
    }
    
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
 
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All", "Priority", "Non-Priority"]
        searchController.searchBar.delegate = self
    }

    func setupConstraints() {
        taskTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc func addTapped() {
        present(AddTaskViewController(), animated: true, completion: nil)
    }


    func getTasks() {
        NetworkManager.getTasks { tasks in
            self.tasks = tasks
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
        }
    }

    @objc func refresh() {
        getTasks()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton: String = "All") {
        filteredTasks = tasks.filter
        {
            task in
            var isPriority: String
            if (task.priority) {
                isPriority = "Priority"
            } else {
                isPriority = "Non-Priority"
            }
            let scopeMatch = (scopeButton == "All" || isPriority == scopeButton)
            if(searchController.searchBar.text != "") {
                let searchTextMatch = task.name.lowercased().contains(searchText.lowercased())
                return scopeMatch && searchTextMatch
            } else {
                return scopeMatch
                
            }
            
        }
        taskTableView.reloadData()
    }
                                      
    

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive) {
            return filteredTasks.count
        }
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TaskTableViewCell
        let thisTask: Task!
        
        if (searchController.isActive) {
            thisTask = filteredTasks[indexPath.row]
        } else {
            thisTask = tasks[indexPath.row]
        }
        cell.nameLabel.text = thisTask.name
        cell.descriptionLabel.text = thisTask.description
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = tasks[indexPath.row]
//        NetworkManager.getTaskById(id: selectedTask.id) { task in
            self.navigationController?.pushViewController(TaskDetailViewController(task: selectedTask), animated: true)
//        }
    }
}

