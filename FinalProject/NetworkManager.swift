//
//  NetworkManager.swift
//  FinalProject
//
//  Created by 이승우 on 2021/12/02.
//

import Alamofire
import Foundation

class NetworkManager {
    
    static let endpoint = "http://anneshghoshdastidarpriority.herokuapp.com"
    
    static func getTasks (completion: @escaping ([Task]) -> Void ){
        AF.request("\(endpoint)/api/category/1", method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let tasksResponse = try? jsonDecoder.decode(TasksResponse.self, from: data) {
                    let tasks = tasksResponse.tasks
                    completion(tasks)
                }
            case .failure(let error):
                print(error)
            }
        }
            
    }
    
//    static func getTaskById(id: Int, completion: @escaping (Task) -> Void) {
//        AF.request("\(endpoint)/api/categories/\(id)/", method: .get).validate().responseData { response in
//            switch response.result {
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let taskResponse = try? jsonDecoder.decode(TaskResponse.self, from: data) {
//                    let task = taskResponse.tasks
//                    print(task)
//                    completion(task)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    static func addTask(name: String, description: String, completion: @escaping (Task) -> Void) {
        let parameters: [String: Any] = [
            "name": name,
            "description": description,
            "priority": true
        ]
        
        AF.request("\(endpoint)/api/1/tasks/", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            print("add task")
            debugPrint(response)
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let taskResponse = try? jsonDecoder.decode(Task.self, from:data) {
                    completion(taskResponse)
                }
            case .failure(let error):
                print(error)
            }
    
        }
    }

}
