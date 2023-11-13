//
//  EventController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-11-12.
//

import Foundation

class EventController {

    init() {}
    
    enum NetworkError: Error {
        case emptyResponse
        case invalidResponse
        case serverError(String)
    }
    
    // create a new event
    func createEvent(title: String, description: String, startDate: Date, endDate: Date, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/event/events")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                
        let body: [String: Any] = [
            "title": title,
            "description": description,
            "startDate": startDate,
            "endDate": endDate
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
                print("Could not create event")
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
    
    // get an event by its id
    func getEventById(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/event/events/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not retrieve event")
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
    
    // update an event
    func updateEvent(id: String, title: String, description: String, startDate: Date, endDate: Date, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/event/events/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "title": title,
            "description": description,
            "startDate": startDate,
            "endDate": endDate
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
                print("Could not update event")
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
    
    // delete an event
    func deleteEvent(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/event/events/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not delete event")
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
