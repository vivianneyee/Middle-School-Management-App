//
//  DatabaseManager.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-09-30.
//

import Foundation
import RealmSwift

class AuthManager {
    
    init() {}
    
    enum NetworkError: Error {
        case emptyResponse
        case invalidResponse
        case serverError(String)
    }
    
    func registerUser(email: String, password: String, confirmPassword: String, role: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://127.0.0.1:3000/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let body: [String: Any] = [
            "email": email.lowercased(),
            "password": password,
            "confirmPassword": confirmPassword,
            "role": role
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
                print("Could not register user")
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
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "email": email,
            "password": password
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
                return
            }
            
            // Check for successful response status (e.g., 200 OK)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            // Check if there is response data
            guard let responseData = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }

            completion(.success(responseData))
            
        }.resume()
    }
    
    // delete user from db
    func deleteUser(user: User) {
        // TODO
    }
}
