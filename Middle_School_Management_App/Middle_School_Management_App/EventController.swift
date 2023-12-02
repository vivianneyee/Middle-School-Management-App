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
    func createEvent(title: String, description: String, startDate: Date, endDate: Date, completion: @escaping (Result<GetEventResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/event/events")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Use the appropriate date format
        
        let body: [String: Any] = [
            "title": title,
            "description": description,
            "startDate": formatter.string(from: startDate),
            "endDate": formatter.string(from: endDate)
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
            
            do {
                let decoder = JSONDecoder()
                let eventObject = try decoder.decode(GetEventResponse.self, from: responseData)
                completion(.success(eventObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // get an event by its id
    func getEventById(id: String, completion: @escaping (Result<GetEventResponse, Error>) -> Void) {
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
            
            do {
                let decoder = JSONDecoder()
                let eventObject = try decoder.decode(GetEventResponse.self, from: responseData)
                completion(.success(eventObject))
            } catch {
                completion(.failure(error))
            }
                        
        }.resume()
    }
    
    // update an event
    func updateEvent(id: String, title: String, description: String, startDate: Date, endDate: Date, completion: @escaping (Result<GetEventResponse, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/event/events/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Use the appropriate date format
        
        let body: [String: Any] = [
            "title": title,
            "description": description,
            "startDate": formatter.string(from: startDate),
            "endDate": formatter.string(from: endDate)
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
            
            do {
                let decoder = JSONDecoder()
                let eventObject = try decoder.decode(GetEventResponse.self, from: responseData)
                completion(.success(eventObject))
            } catch {
                completion(.failure(error))
            }
            
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
