//
//  NotificationController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-11-13.
//

import Foundation

class NotificationController {

    init() {}
    
    enum NetworkError: Error {
        case emptyResponse
        case invalidResponse
        case serverError(String)
    }
    
    // create a new notification
    func createNotification(className: String, title: String, completion: @escaping (Result<Notification, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/notification/notifications")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                
        let body: [String: Any] = [
            "className": className,
            "title": title
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
                print("Could not create notification")
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
                let notificationObject = try decoder.decode(Notification.self, from: responseData)
                completion(.success(notificationObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // get a notification by its id
    func getNotificationById(id: String, completion: @escaping (Result<Notification, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/notification/notifications/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not retrieve notification")
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
                let notificationObject = try decoder.decode(Notification.self, from: responseData)
                completion(.success(notificationObject))
            } catch {
                completion(.failure(error))
            }
                        
        }.resume()
    }
    
    // delete a notification
    func deleteNotification(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/notification/notifications/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not delete notification")
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
