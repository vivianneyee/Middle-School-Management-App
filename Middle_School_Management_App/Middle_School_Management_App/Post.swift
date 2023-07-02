//
//  Post.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-21.
//

import Foundation
import RealmSwift

class Post: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var desc: String
    @Persisted var date: Date
    @Persisted var postType: String
}

class Event: Post {
    @Persisted var files: List<String>
    @Persisted var startDate: Date
    @Persisted var endDate: Date
}

class Assignment: Post {
    @Persisted var files: List<String>
    @Persisted var dueDate: Date
}

class Alert: Post {
    @Persisted var priority: String
}

class StudentInput: Post {
    @Persisted var inputType: String
    @Persisted var responses: List<String>
}
