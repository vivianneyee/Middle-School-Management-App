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
           
        } catch let error as NSError {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
    }
}

