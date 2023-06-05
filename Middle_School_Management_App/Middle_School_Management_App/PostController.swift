//
//  PostController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-04-11.
//

import Foundation
import RealmSwift

class PostContoller {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    // CREATE
    
    // create a new Event object
    func createEvent(classObj: Class, title: String, desc: String, date: Date, files: List<String>) {
        let newEvent = Event()
        newEvent.title = title
        newEvent.desc = desc
        newEvent.date = date
        newEvent.files = files
        newEvent.postType = "EVENT"
        
        try! realm.write {
            realm.add(newEvent)
            classObj.events.append(newEvent)
        }
    }
    
    // create a new Assignment object
    func createAssignment(classObj: Class, title: String, desc: String, date: Date, dueDate: Date, files: List<String>) {
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
    
    // READ

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
    
    func getEventById(id: ObjectId) -> Event {
        return realm.object(ofType: Event.self, forPrimaryKey: id) ?? Event()
    }
    
    func getAssignmentById(id: ObjectId) -> Assignment {
        return realm.object(ofType: Assignment.self, forPrimaryKey: id) ?? Assignment()
    }
    
    func getAlertById(id: ObjectId) -> Alert {
        return realm.object(ofType: Alert.self, forPrimaryKey: id) ?? Alert()
    }
    
    func getStudentInpById(id: ObjectId) -> StudentInput {
        return realm.object(ofType: StudentInput.self, forPrimaryKey: id) ?? StudentInput()
    }
    
    // UPDATE
    
    // update an event object
    func updateEvent(eventObj: Event, title: String, desc: String, files: List<String>, startDate: Date, endDate: Date) {
        try! realm.write {
            eventObj.title = title
            eventObj.desc = desc
            eventObj.files = files
            eventObj.startDate = startDate
            eventObj.endDate = endDate
        }
    }
    
    func updateAssignment(assignmentObj: Assignment, title: String, desc: String, dueDate: Date) {
        try! realm.write {
            assignmentObj.title = title
            assignmentObj.desc = desc
            assignmentObj.dueDate = dueDate
        }
    }
    
    func updateAlert(alertObj: Alert, title: String, desc: String, priority: String) {
        try! realm.write {
            alertObj.title = title
            alertObj.desc = desc
            alertObj.priority = priority
        }
    }
    
    func updateStudentInput(studentInp: StudentInput, title: String, desc: String, inputType: String) {
        try! realm.write {
            studentInp.title = title
            studentInp.desc = desc
            studentInp.inputType = inputType
        }
    }
    
    func addResponse(studentInp: StudentInput, response: String) {
        try! realm.write {
            studentInp.responses.append(response)
        }
    }
    
    // DELETE
    
    func deleteEvent(eventObj: Event) {
        try! realm.write {
            realm.delete(eventObj)
        }
    }
    
    func deleteAssignment(assignmentObj: Assignment) {
        try! realm.write {
            realm.delete(assignmentObj)
        }
    }
    
    func deleteAlert(alertObj: Alert) {
        try! realm.write {
            realm.delete(alertObj)
        }
    }
    
    func deleteStudentInput(studentInp: StudentInput) {
        try! realm.write {
            realm.delete(studentInp)
        }
    }
}
