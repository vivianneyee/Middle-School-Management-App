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
    @Persisted var priority: String
}

class StudentInput: Post {
    @Persisted var inputType: String
    @Persisted var responses: List<String>
}

class PostDataAccess {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    // create a new Event object
    func createEvent(classObj: Class, title: String, date: Date, files: List<String>) {
        let newEvent = Event()
        newEvent.title = title
        newEvent.date = date
        newEvent.files = files
        newEvent.postType = "EVENT"
        
        try! realm.write {
            realm.add(newEvent)
            classObj.events.append(newEvent)
        }
    }
    
    // create a new Assignment object
    func createAssignment(classObj: Class, title: String, date: Date, files: List<String>) {
        let newAssignment = Assignment()
        newAssignment.title = title
        newAssignment.date = date
        newAssignment.files = files
        newAssignment.postType = "ASSIGNMENT"
        
        try! realm.write {
            realm.add(newAssignment)
            classObj.assignments.append(newAssignment)
        }
    }
    
    // create new Alert object
    func createAlert(classObj:Class, title: String, date: Date, priority: String) {
        let newAlert = Alert()
        newAlert.title = title
        newAlert.date = date
        newAlert.priority = priority
        newAlert.postType = "ALERT"
        
        try! realm.write {
            realm.add(newAlert)
            classObj.alerts.append(newAlert)
        }
    }
    
    // create a new StudnetInput object
    func createStudentInput(classObj:Class, title: String, date: Date, inputType: String) {
        let newStudentInput = StudentInput()
        newStudentInput.title = title
        newStudentInput.date = date
        newStudentInput.inputType = inputType
        newStudentInput.postType = "STUDENTINPUT"
        
        try! realm.write {
            realm.add(newStudentInput)
            classObj.studentInputs.append(newStudentInput)
        }
    }

    // read all events belonging to a class
    func getEvents(classObj: Class) -> [Event] {
        return Array(classObj.events)
    }
    
    // read all assignments belonging to a class
    func getAssignments(classObj: Class) -> [Assignment] {
        return Array(classObj.assignments)
    }
    
    // read all alerts belonging to a class
    func getAlerts(classObj: Class) -> [Alert] {

        return Array(classObj.alerts)
    }

    // read all student inputs belonging to a class
    func getStudentInputs(classObj: Class) -> [StudentInput] {
        return Array(classObj.studentInputs)
    }
}
