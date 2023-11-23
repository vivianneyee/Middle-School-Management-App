//
//  Notification.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-11-21.
//

import Foundation

struct Notification: Decodable {
    let _id: String
    let className: String
    let title: String
    let datePosted: Date
    
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
        self.datePosted = try container.decode(Date.self, forKey: .datePosted)
    }
}
