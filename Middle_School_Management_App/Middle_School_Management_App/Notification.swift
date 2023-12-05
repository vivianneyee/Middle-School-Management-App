//
//  Notification.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-11-21.
//

import Foundation

struct CreateNotificationResponse: Decodable {
    let message: String
    let notification: Notification
//    let className: String
//    let title: String
//    let datePosted: Date
}

//struct Notification {
//    let _id: String
//    let className: String
//    let title: String
//    let datePosted: Date
//
//    // Default initializer without 'from' parameter
//    init(_id: String, className: String, title: String, datePosted: Date) {
//        self._id = _id
//        self.className = className
//        self.title = title
//        self.datePosted = datePosted
//    }
//}


struct Notification: Decodable {
    let _id: String
    let className: String
    let title: String
    let datePosted: String
    
    enum CodingKeys: String, CodingKey {
        case _id
        case className
        case title
        case datePosted
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.className = try container.decode(String.self, forKey: .className)
        self.title = try container.decode(String.self, forKey: .title)
        self.datePosted = try container.decode(String.self, forKey: .datePosted)
    }
}
