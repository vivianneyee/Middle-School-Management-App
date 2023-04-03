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
    
    convenience init(title: String, date: Date, files: List<String>) {
        self.init()
        self.title = title
        self.date = date
        self.postType = "EVENT"
        self.files = files
    }
}

class Assignment: Post {
    @Persisted var files: List<String>
    
    convenience init(title: String, date: Date, files: List<String>) {
        self.init()
        self.title = title
        self.date = date
        self.postType = "ASSIGNMENT"
        self.files = files
    }
}

class Alert: Post {
    @Persisted var files: List<String>
    
    convenience init(title: String, date: Date, files: List<String>) {
        self.init()
        self.title = title
        self.date = date
        self.postType = "ALERT"
        self.files = files
    }
}

class StudentInput: Post {
    @Persisted var inputType: String
    @Persisted var responses: List<String>
    
    convenience init(title: String, date: Date, inputType: String) {
        self.init()
        self.title = title
        self.date = date
        self.postType = "STUDENTINPUT"
        self.inputType = inputType
        self.responses = List<String>()
    }

}
