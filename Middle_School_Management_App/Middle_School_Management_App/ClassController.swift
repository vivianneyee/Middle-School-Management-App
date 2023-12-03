//
//  ClassController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-04-11.
//

import Foundation
import RealmSwift

class ClassController {

    init() {}
    
    enum NetworkError: Error {
        case emptyResponse
        case invalidResponse
        case serverError(String)
    }
    
    // create a new class
    func createClass(className: String, color: String, completion: @escaping (Result<CreateClassResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/class/classes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                
        let body: [String: Any] = [
            "className": className,
            "color": color
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
                print("Could not create class")
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
            
            do {
                let decoder = JSONDecoder()
                let obj = try decoder.decode(CreateClassResponse.self, from: responseData)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
            
//            completion(.success(responseData))
        }.resume()
    }
    
    // get a class by its id
    func getClassById(id: String, completion: @escaping (Result<AddUserToClassResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/class/classes/id/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not find class")
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
                let classObject = try decoder.decode(AddUserToClassResponse.self, from: responseData)
                completion(.success(classObject))
            } catch {
                completion(.failure(error))
            }
            
                        
        }.resume()
    }
    
    // get a class by its code
    func getClassByCode(code: String, completion: @escaping (Result<AddUserToClassResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/class/classes/code/\(code)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not find class")
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
                let classObject = try decoder.decode(AddUserToClassResponse.self, from: responseData)
                completion(.success(classObject))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // get a class by its code
    func getClassByName(className: String, completion: @escaping (Result<AddUserToClassResponse, Error>) -> Void) {
        print("className", className)
//        print("url", URL(string: "http://localhost:3000/class/classes/name/\(className)")!)
        let trimmedClassName = className.trimmingCharacters(in: .whitespaces)
        print("trimmedClassName", trimmedClassName)
        // Encode the class name to ensure it's URL-safe

        guard let encodedClassName = trimmedClassName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "http://localhost:3000/class/classes/name/\(encodedClassName)") else {
            // Handle the invalid URL or className here
            print("url failed")
            return
        }
//        print("url", url)
//        let url = URL(string: "http://localhost:3000/class/classes/name/\(className)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not find class")
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
                let classObject = try decoder.decode(AddUserToClassResponse.self, from: responseData)
                completion(.success(classObject))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // update a class
    func updateClass(id: String, className: String, color: String, completion: @escaping (Result<AddUserToClassResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/class/classes/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "className": className,
            "color": color
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
                print("Could not find class")
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
                let classObject = try decoder.decode(AddUserToClassResponse.self, from: responseData)
                completion(.success(classObject))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // add event to class
    func addEvent(id: String, eventId: String, completion: @escaping (Result<AddUserToClassResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/class/classes/events/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "eventId": eventId        ]
        
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
                print("Could not add event to class")
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
                let classObject = try decoder.decode(AddUserToClassResponse.self, from: responseData)
                completion(.success(classObject))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    // add assignment to class
    func addAssignment(id: String, assignmentId: String, completion: @escaping (Result<AddUserToClassResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/class/classes/assignments/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "assignmentId": assignmentId        ]
        
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
                print("Could not add assignment to class")
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
                let classObject = try decoder.decode(AddUserToClassResponse.self, from: responseData)
                completion(.success(classObject))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // add alert to class
    func addAlert(id: String, alertId: String, completion: @escaping (Result<AddUserToClassResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/class/classes/alerts/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "alertId": alertId        ]
        
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
                print("Could not add alert to class")
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
                let classObject = try decoder.decode(AddUserToClassResponse.self, from: responseData)
                completion(.success(classObject))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // add user to class
    func addUser(id: String, userId: String, completion: @escaping (Result<AddUserToClassResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/class/classes/user/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "userId": userId
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
                print("Could not add user to class")
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
                let classObject = try decoder.decode(AddUserToClassResponse.self, from: responseData)
                completion(.success(classObject))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // delete a class
    func deleteClass(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/class/classes/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not find class")
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
