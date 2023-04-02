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
        // Do any additional setup after loading the view.
        let realm = try! Realm()
        
        // for debugging
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        // test class
        createClass(realm: realm, name: "test class", color: "red")
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
    
}

