//
//  Post.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-21.
//

import Foundation

struct Event: Decodable {
    let _id: String
    let title: String
    let description: String
    let datePosted: Date
    let startDate: Date
    let endDate: Date
    
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
        self.datePosted = try container.decode(Date.self, forKey: .datePosted)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
    }
}

struct Alert: Decodable {
    let _id: String
    let title: String
    let description: String
    let datePosted: Date
    let priority: String
    
    enum CodingKeys: String, CodingKey {
        case _id
        case title
        case description
        case datePosted
        case priority
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.datePosted = try container.decode(Date.self, forKey: .datePosted)
        self.priority = try container.decode(String.self, forKey: .priority)

    }
}

struct Assignment: Decodable {
    let _id: String
    let title: String
    let description: String
    let datePosted: Date
    let dueDate: Date
    
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
        self.datePosted = try container.decode(Date.self, forKey: .datePosted)
        self.dueDate = try container.decode(Date.self, forKey: .dueDate)
    }
}






