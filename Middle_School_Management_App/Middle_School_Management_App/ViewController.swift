//
//  ViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-13.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let realm = try Realm()
            
            // for debugging
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
            // test class
            createClass(realm: realm, name: "test class", color: "blue")
            
            // test posts
            let date = Date()
            let files = List<String>()
            createEvent(realm: realm, title: "testEvent", date: date, files: files)
            createAlert(realm: realm, title: "testAlert", date: date, files: files)
            createAssignment(realm: realm, title: "testAssignment", date: date, files: files)
            createStudentInput(realm: realm, title: "testStudentInput", date: date, inputType: "TEXT")
        } catch let error as NSError {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
    }
        

    func createClass(realm: Realm, name: String, color: String) {
        let code = generateClassCode(realm: realm)
        let newClass = Class(name: name, color: color, code: code)
        try! realm.write {
             realm.add(newClass)
        }
    }
    
    // generate random 6-character code made up of 3 letters and 3 numbers
    func generateCode() -> String {
        var code = ""
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let nums = "1234567890"
        for _ in 0..<3 {
            let letterIndex = Int.random(in: 0..<letters.count)
            code.append(letters[letters.index(letters.startIndex, offsetBy: letterIndex)])
        }
        for _ in 0..<3 {
            let numIndex = Int.random(in: 0..<nums.count)
            code.append(nums[nums.index(nums.startIndex, offsetBy: numIndex)])
        }
        
        return code
    }
    
    // use generateCode() to create a random class code and ensure it is not already in use
    func generateClassCode(realm: Realm) -> String {
        var code = generateCode()
        while realm.objects(Class.self).filter("code == %@", code).count > 0 {
            code = generateCode()
        }
        return code
    }
    
    // create a new post object in db
    func createPost(realm: Realm, title: String, date: Date, postType: String) {
        let newPost = Post(title: title, date: date, postType: postType)
        try! realm.write {
             realm.add(newPost)
        }
    }
    
    func createEvent(realm: Realm, title: String, date: Date, files: List<String>) {
        let newEvent = Event(title: title, date: date, files: files)
        try! realm.write {
             realm.add(newEvent)
        }
        createPost(realm: realm, title: title, date: date, postType: newEvent.postType)
    }
    
    func createAssignment(realm: Realm, title: String, date: Date, files: List<String>) {
        let newAssignment = Assignment(title: title, date: date, files: files)
        try! realm.write {
             realm.add(newAssignment)
        }
        createPost(realm: realm, title: title, date: date, postType: newAssignment.postType)
    }
    
    func createAlert(realm: Realm, title: String, date: Date, files: List<String>) {
        let newAlert = Alert(title: title, date: date, files: files)
        try! realm.write {
             realm.add(newAlert)
        }
        createPost(realm: realm, title: title, date: date, postType: newAlert.postType)
    }
    
    func createStudentInput(realm: Realm, title: String, date: Date, inputType: String) {
        let newStudentInput = StudentInput(title: title, date: date, inputType: inputType)
        try! realm.write {
             realm.add(newStudentInput)
        }
        createPost(realm: realm, title: title, date: date, postType: newStudentInput.postType)
    }
}

