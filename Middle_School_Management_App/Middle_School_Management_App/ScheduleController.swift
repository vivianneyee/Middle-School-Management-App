//
//  ScheduleController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-11-11.
//

import Foundation
import RealmSwift

class ScheduleController {

    init() {}
    
    enum NetworkError: Error {
        case emptyResponse
        case invalidResponse
        case serverError(String)
    }
    
    // create a new schedule
    func createSchedule(day1: [String], day2: [String], day3: [String], day4: [String], day5: [String], day6: [String], day7: [String], day8: [String], day9: [String], day10: [String], completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/schedule/schedules")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                
        let body: [String: Any] = [
            "day1": day1,
            "day2": day2,
            "day3": day3,
            "day4": day4,
            "day5": day5,
            "day6": day6,
            "day7": day7,
            "day8": day8,
            "day9": day9,
            "day10": day10
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
                print("Could not create schedule")
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
    
    // get a schedule by its id
    func getScheduleById(id: String, completion: @escaping (Result<Schedule, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/schedule/schedules/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not find schedule")
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
                let scheduleObject = try decoder.decode(Schedule.self, from: responseData)
                completion(.success(scheduleObject))
            } catch {
                completion(.failure(error))
            }
                        
        }.resume()
    }
    
    // update a schedule
    func updateSchedule(id: String, day1: [String], day2: [String], day3: [String], day4: [String], day5: [String], day6: [String], day7: [String], day8: [String], day9: [String], day10: [String], completion: @escaping (Result<Schedule, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/schedule/schedules/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "day1": day1,
            "day2": day2,
            "day3": day3,
            "day4": day4,
            "day5": day5,
            "day6": day6,
            "day7": day7,
            "day8": day8,
            "day9": day9,
            "day10": day10
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
                print("Could not update schedule")
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
                let scheduleObject = try decoder.decode(Schedule.self, from: responseData)
                completion(.success(scheduleObject))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // delete a schedule
    func deleteSchedule(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3000/schedule/schedules/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Could not delete schedule")
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
