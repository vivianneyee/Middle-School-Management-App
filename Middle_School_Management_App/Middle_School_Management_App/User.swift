//
//  User.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-27.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var email: String
    @Persisted var role: String
    @Persisted var schedule: Schedule
    
    convenience init(_id: ObjectId, email: String, role: String) {
        self.init()
        self._id = _id
        self.email = email
        self.role = role
    }
}
