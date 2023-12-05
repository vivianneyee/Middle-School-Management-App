//
//  Class.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-21.
//

import Foundation

struct CreateClassResponse: Decodable {
    let message: String
    let newClass: Class
}

struct AddUserToClassResponse: Decodable {
    let message: String
    let `class`: Class
}


struct Class: Decodable {
    let _id: String
    let className: String
    let color: String
    let code: String
    let events: [String]
    let assignments: [String]
    let alerts: [String]
    let users: [String]
    
    enum CodingKeys: String, CodingKey {
        case _id
        case className
        case color
        case code
        case events
        case assignments
        case alerts
        case users
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.className = try container.decode(String.self, forKey: .className)
        self.color = try container.decode(String.self, forKey: .color)
        self.code = try container.decode(String.self, forKey: .code)
        self.events = try container.decode([String].self, forKey: .events)
        self.assignments = try container.decode([String].self, forKey: .assignments)
        self.alerts = try container.decode([String].self, forKey: .alerts)
        self.users = try container.decode([String].self, forKey: .users)
    }
}
