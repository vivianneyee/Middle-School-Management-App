//
//  Post.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-21.
//

import Foundation

struct GetEventResponse: Decodable {
    let message: String
    let event: Event
}

struct Event: Decodable {
    let _id: String
    let title: String
    let description: String
    let datePosted: String
    let startDate: String
    let endDate: String
    
    enum CodingKeys: String, CodingKey {
        case _id
        case title
        case description
        case datePosted
        case startDate
        case endDate
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.datePosted = try container.decode(String.self, forKey: .datePosted)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.endDate = try container.decode(String.self, forKey: .endDate)
    }
}

struct GetAlertResponse: Decodable {
    let message: String
    let alert: Alert
}

struct Alert: Decodable {
    let _id: String
    let title: String
    let description: String
    let datePosted: String
    let priority: String
    
    enum CodingKeys: String, CodingKey {
        case _id
        case title
        case description
        case datePosted
        case priority
    }
//    // Default initializer without 'from' parameter
//    init(_id: String, title: String, description: String, datePosted: Date, priority: String) {
//        self._id = _id
//        self.title = title
//        self.description = description
//        self.datePosted = datePosted
//        self.priority = priority
//    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.datePosted = try container.decode(String.self, forKey: .datePosted)
        self.priority = try container.decode(String.self, forKey: .priority)

    }
}

struct GetAssignmentResponse: Decodable {
    let message: String
    let assignment: Assignment
}

struct Assignment: Decodable {
    let _id: String
    let title: String
    let description: String
    let datePosted: String
    let dueDate: String
    
    enum CodingKeys: String, CodingKey {
        case _id
        case title
        case description
        case datePosted
        case dueDate
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.datePosted = try container.decode(String.self, forKey: .datePosted)
        self.dueDate = try container.decode(String.self, forKey: .dueDate)
    }
}






