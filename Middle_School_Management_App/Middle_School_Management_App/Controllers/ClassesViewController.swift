//
//  ClassesViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class ClassesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var userID: String = ""
    
//    struct Class: Decodable {
//        let _id: String
//        let className: String
//        let color: String
//        let code: String
//        let events: [Event]
//        let assignments: [Assignment]
//        let alerts: [Alert]
//        let users: [User]
//
    
//    struct ClassInfo {
//        let subject: String
//        let eventCount: String
//        let assignCount: String
//        let alertCount: String
//        let colour: UIColor
//    }
    
    // hardcoded data for testing
//    let data: [ClassInfo] = [
//        ClassInfo(subject: "French", eventCount: "3", assignCount: "1", alertCount: "2", colour: UIColor.purple.withAlphaComponent(0.25)),
//        ClassInfo(subject: "6A - Art", eventCount: "1", assignCount: "2", alertCount: "2", colour: UIColor.blue.withAlphaComponent(0.25)),
//        ClassInfo(subject: "6B - Art", eventCount: "1", assignCount: "2", alertCount: "2", colour: UIColor.blue.withAlphaComponent(0.25)),
//        ClassInfo(subject: "Social Studies", eventCount: "3", assignCount: "1", alertCount: "1", colour: UIColor.orange.withAlphaComponent(0.25)),
//        ClassInfo(subject: "Gym", eventCount: "2", assignCount: "2", alertCount: "2", colour: UIColor.green.withAlphaComponent(0.25)),
//        ClassInfo(subject: "Music", eventCount: "1", assignCount: "2", alertCount: "0", colour: UIColor.systemYellow.withAlphaComponent(0.25)),
//        ClassInfo(subject: "Languages", eventCount: "0", assignCount: "2", alertCount: "2", colour: UIColor.systemPink.withAlphaComponent(0.25)),
//        ClassInfo(subject: "Junior Girls Volleyball", eventCount: "2", assignCount: "0", alertCount: "2", colour: UIColor.systemMint.withAlphaComponent(0.25)),
//        ClassInfo(subject: "Track and Field", eventCount: "1", assignCount: "0", alertCount: "1", colour: UIColor.systemGray.withAlphaComponent(0.25))
//    ]
    var data: [Class] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
        
        print("classes page userID: ", self.userID)
        
        let userController = UserController()
        let classContoller = ClassController()
        self.data.removeAll()
        let dispatchGroup = DispatchGroup()
        // Start dispatch group
//        dispatchGroup.enter()
        userController.getUserById(id: self.userID){ [self] result in
            switch result {
            case .success(let dataResponse):
                print("Login successful")
                
//                DispatchQueue.main.async {
                    print(dataResponse)
                    print(dataResponse._id)
                    print("classes", dataResponse.classes)
//                    var d: [Class] = []
                for c in dataResponse.classes {
//                    dispatchGroup.enter()
                    classContoller.getClassById(id: c){ [self] result in
                        switch result {
                        case .success(let dataResponse):
                            print("get class success", dataResponse)
                            self.data.append(dataResponse.class)
                            DispatchQueue.main.async {
                                print("self.data", self.data)
                                self.table.reloadData()
                            }
                        case .failure(let error):
                            print ("get classes failed with error: \(error)")
                        }
                        //                    self.data = dataResponse.classes
                    }
                }
            case .failure(let error):
                print ("get classes failed with error: \(error)")
            }
//            dispatchGroup.leave()
        }
//        // Notify when all async tasks in the dispatch group are finished
//            dispatchGroup.notify(queue: .main) {
//                self.table.reloadData()
//            }
//        DispatchQueue.main.async {
//            self.table.reloadData()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch user data every time the view is about to appear
//        let userController = UserController()
//        userController.getUserById(id: self.userID) { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let dataResponse):
//                print("re load user data successful")
//                DispatchQueue.main.async {
//                    print(dataResponse)
//                    print(dataResponse._id)
//                    print("classes", dataResponse.classes)
//                    self.data = dataResponse.classes
//                    // Reload the table view
//                    self.table.reloadData()
//                }
//            case .failure(let error):
//                print ("get classes failed with error: \(error)")
//            }
//        }
        let userController = UserController()
        let classContoller = ClassController()
        self.data.removeAll()
        let dispatchGroup = DispatchGroup()

            // Start dispatch group
//            dispatchGroup.enter()
        userController.getUserById(id: self.userID){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dataResponse):
                print("Login successful")
                
//                DispatchQueue.main.async {
                    print(dataResponse)
                    print(dataResponse._id)
                    print("classes", dataResponse.classes)
//                    var d: [Class] = []
                for c in dataResponse.classes {
//                    dispatchGroup.enter()
                    print("c: ", c)
                    print("c type", type(of: c))
                    classContoller.getClassById(id: c){ [self] result in
                        switch result {
                        case .success(let dataResponse):
                            print("get class success", dataResponse)
                            self.data.append(dataResponse.class)
                            DispatchQueue.main.async {
                                print("self.data", self.data)
                                self.table.reloadData()
                            }
                        case .failure(let error):
                            print ("get classes failed with error: \(error)")
                        }
                        //                    self.data = dataResponse.classes
                    }
                }
                
                print("data ", self.data)
            case .failure(let error):
                print ("get classes failed with error: \(error)")
            }
            
//            dispatchGroup.leave()
        }
//        // Notify when all async tasks in the dispatch group are finished
//            dispatchGroup.notify(queue: .main) {
//                self.table.reloadData()
//            }
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }

    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createClass") as! CreateClassViewController
        vc.userID = self.userID
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let classCell = self.data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClassTableViewCell
        cell.className.text = classCell.className
        cell.events.text = "Events - " + String(classCell.events.count)
        cell.assignments.text = "Assignments - " + String(classCell.assignments.count)
        cell.alerts.text = "Alerts - " + String(classCell.alerts.count)
        let font = UIFont.systemFont(ofSize: 25)
        let configuration = UIImage.SymbolConfiguration(font: font)
        if let color = UIColor(hex: classCell.color) {
            let im = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal).withTintColor(color)
            cell.colour.image = im
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let classCell = self.data[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "classInfo") as! ClassInfoViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.userID = self.userID
        vc.title = classCell.className
        vc.classID = classCell._id
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
