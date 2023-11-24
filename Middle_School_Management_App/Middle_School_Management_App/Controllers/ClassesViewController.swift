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
    
    struct ClassInfo {
        let subject: String
        let eventCount: String
        let assignCount: String
        let alertCount: String
        let colour: UIColor
    }
    
    // hardcoded data for testing
    let data: [ClassInfo] = [
        ClassInfo(subject: "French", eventCount: "3", assignCount: "1", alertCount: "2", colour: UIColor.purple.withAlphaComponent(0.25)),
        ClassInfo(subject: "6A - Art", eventCount: "1", assignCount: "2", alertCount: "2", colour: UIColor.blue.withAlphaComponent(0.25)),
        ClassInfo(subject: "6B - Art", eventCount: "1", assignCount: "2", alertCount: "2", colour: UIColor.blue.withAlphaComponent(0.25)),
        ClassInfo(subject: "Social Studies", eventCount: "3", assignCount: "1", alertCount: "1", colour: UIColor.orange.withAlphaComponent(0.25)),
        ClassInfo(subject: "Gym", eventCount: "2", assignCount: "2", alertCount: "2", colour: UIColor.green.withAlphaComponent(0.25)),
        ClassInfo(subject: "Music", eventCount: "1", assignCount: "2", alertCount: "0", colour: UIColor.systemYellow.withAlphaComponent(0.25)),
        ClassInfo(subject: "Languages", eventCount: "0", assignCount: "2", alertCount: "2", colour: UIColor.systemPink.withAlphaComponent(0.25)),
        ClassInfo(subject: "Junior Girls Volleyball", eventCount: "2", assignCount: "0", alertCount: "2", colour: UIColor.systemMint.withAlphaComponent(0.25)),
        ClassInfo(subject: "Track and Field", eventCount: "1", assignCount: "0", alertCount: "1", colour: UIColor.systemGray.withAlphaComponent(0.25))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
    }
    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createClass") as! CreateClassViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let classCell = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClassTableViewCell
        cell.className.text = classCell.subject
        cell.events.text = "Events - " + classCell.eventCount
        cell.assignments.text = "Assignments - " + classCell.assignCount
        cell.alerts.text = "Alerts - " + classCell.alertCount
        let font = UIFont.systemFont(ofSize: 25)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let im = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal).withTintColor(classCell.colour)
        cell.colour.image = im
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let classCell = data[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "classInfo") as! ClassInfoViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = classCell.subject
    }
}
