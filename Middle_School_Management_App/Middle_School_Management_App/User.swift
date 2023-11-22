//
//  User.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-11-21.
//

import Foundation

struct User: Decodable {
    let _id: String
    let email: String
    let hashedPassword: String
    let role: String
    let classes: [Class]
    let schedule: Schedule
    // let notifications: [Notification]
    
    enum CodingKeys: String, CodingKey {
        case _id
        case email
        case hashedPassword
        case role
        case classes
        case schedule
        // case notifications
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.email = try container.decode(String.self, forKey: .email)
        self.hashedPassword = try container.decode(String.self, forKey: .hashedPassword)
        self.role = try container.decode(String.self, forKey: .role)
        self.classes = try container.decode([Class].self, forKey: .classes)
        self.schedule = try container.decode(Schedule.self, forKey: .schedule)
        // self.notifications = try container.decode([Notificaiton].self, forKey: .notifications)
    }
}
