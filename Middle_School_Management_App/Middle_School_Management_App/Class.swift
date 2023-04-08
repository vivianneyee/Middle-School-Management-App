//
//  Class.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-21.
//

import Foundation
import RealmSwift

class Class: Object {
    @Persisted var name: String = ""
    @Persisted var color: String = ""
    @Persisted var code: String = ""
    @Persisted var events: List<Event>
    @Persisted var assignments: List<Assignment>
    @Persisted var alerts: List<Alert>
    @Persisted var studentInputs: List<StudentInput>
    
    convenience init(name: String, color: String, code: String) {
        self.init()
        self.name = name
        self.color = color
        self.code = code
    }
}

class ClassDataAccess {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    // create a new class
    func createClass(name: String, color: String) {
        let code = generateClassCode(realm: realm)
        let newClass = Class(name: name, color: color, code: code)
        try! realm.write {
             realm.add(newClass)
        }
    }
    
    // delete a class
    func deleteClass(classObj: Class) {
        try! realm.write {
            realm.delete(classObj)
        }
    }
    
    // update a class
    func updateClass(classObj: Class, name: String, color: String) {
        try! realm.write {
            classObj.name = name
            classObj.color = color
        }
    }
    
    // return all classes in db
    func getAllClasses() -> Results<Class> {
        return realm.objects(Class.self)
    }
    
    // get a specific class by its code
    func getClassByCode(code: String) -> Class {
        let classes = getAllClasses()
        let classObj = classes.where {
            $0.code == code
        }[0]
        return classObj
    }
    
    // ***** FOR TESTING *****
    func getFirstClass() -> Class {
        let classes = getAllClasses()
        return classes[0]
    }
    
    // generate random 6-character code made up of 3 letters and 3 numbers
    private func generateCode() -> String {
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
    private func generateClassCode(realm: Realm) -> String {
        var code = generateCode()
        while realm.objects(Class.self).filter("code == %@", code).count > 0 {
            code = generateCode()
        }
        return code
    }
}
