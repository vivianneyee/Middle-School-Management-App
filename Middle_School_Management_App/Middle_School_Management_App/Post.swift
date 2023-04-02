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
    @Persisted var date: Date
    @Persisted var postType: String
}

class Event: Post {
    @Persisted var files: List<String>
}

class Assignment: Post {
    @Persisted var files: List<String>
}

class Alert: Post {
    @Persisted var files: List<String>
}

class StudentInput: Post {
    @Persisted var inputType: String
    @Persisted var responses: List<String>
}
