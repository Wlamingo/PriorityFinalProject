//
//  Priority.swift
//  FinalProject
//
//  Created by 이승우 on 2021/12/02.
//

import Foundation
struct TasksResponse: Codable {
    var id: Int
    var category: String
    var tasks: [Task]
}

struct TaskResponse: Codable {
    var id: Int
    var category: String
    var tasks: Task
}

struct Task: Codable {
    var id: Int
    var name: String
    var description: String
    var priority: Bool
    var categoryId: Int
}
