//
//  ClassInfoViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class ClassInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    let labels: [String] = [
        "Events",
        "Assignments",
        "Alerts",
        "Student Input"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let labelCell = labels[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LinkTableViewCell
        cell.labelName.text = labelCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let labelCell = labels[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(identifier: "event") as! EventViewController
        
        if (labelCell == "Events") {
            let vc = storyboard?.instantiateViewController(identifier: "event") as! EventViewController
            vc.className = self.title!
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Events"
        } else if (labelCell == "Assignments") {
            let vc = storyboard?.instantiateViewController(identifier: "assign") as! AssignmentViewController
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Assignments"
        } else if (labelCell == "Alerts") {
            let vc = storyboard?.instantiateViewController(identifier: "alert") as! AlertViewController
            navigationController?.pushViewController(vc, animated: true)
            vc.className = self.title!
            vc.title = "Alerts"
        } else if (labelCell == "Student Input") {
            let vc = storyboard?.instantiateViewController(identifier: "sInput") as! StudentInputViewController
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Student Input"
        }
        
        vc.title = labelCell
    }
    
}
