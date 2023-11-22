//
//  AssignmentController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-11-12.
//

import Foundation

class AssignmentController {

    init() {}
    
    enum NetworkError: Error {
        case emptyResponse
        case invalidResponse
        case serverError(String)
    }
    
    // create a new assignment
    func createAssignment(title: String, description: String, dueDate: Date, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/assignment/assignments")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                
        let body: [String: Any] = [
            "title": title,
            "description": description,
            "dueDate": dueDate
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not create assignment")
                return
            }
            
            // check for successful response status
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            // check that response data is not empty
            guard let responseData = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            
            completion(.success(responseData))
        }.resume()
    }
    
    // get an assignment by its id
    func getAssignmentById(id: String, completion: @escaping (Result<Assignment, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/assignment/assignments/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not retrieve assignment")
                return
            }
            
            // check for successful response status
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            // check that response data is not empty
            guard let responseData = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let assignmentObject = try decoder.decode(Assignment.self, from: responseData)
                completion(.success(assignmentObject))
            } catch {
                completion(.failure(error))
            }
                        
        }.resume()
    }
    
    // update an assignment
    func updateAssignment(id: String, title: String, description: String, dueDate: Date, completion: @escaping (Result<Assignment, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/assignment/assignments/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "title": title,
            "description": description,
            "dueDate": dueDate
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not update assignment")
                return
            }
            
            // check for successful response status
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            // check that response data is not empty
            guard let responseData = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let assignmentObject = try decoder.decode(Assignment.self, from: responseData)
                completion(.success(assignmentObject))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // delete an assignment
    func deleteAssignment(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/assignment/assignments/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not delete assignment")
                return
            }
            
            // check for successful response status
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            // check that response data is not empty
            guard let responseData = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            
            completion(.success(responseData))
            
        }.resume()
    }
}
