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
    @Persisted var password: String
    @Persisted var userType: String
}

class Teacher: User {
    @Persisted var name: String
    @Persisted var classes: List<Class>
}

class Student: User {
    @Persisted var classes: List<Class>
}
