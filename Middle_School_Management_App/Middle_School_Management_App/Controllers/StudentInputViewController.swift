//
//  StudentInputViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class StudentInputViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
    }
    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createSI") as! CreateStudentInputViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Create New Student Input"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentInputData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dcFormatter = DateComponentsFormatter()
        dcFormatter.includesApproximationPhrase = false
        dcFormatter.allowedUnits = [.month, .day, .year]
        
        let eventCell = studentInputData[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        let date = Calendar.current.date(from: eventCell.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        cell.date.text = formatter.string(from : date!)
        
        cell.name.text = eventCell.name
        
        cell.inputType.text = eventCell.inputType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventCell = studentInputData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "editSI") as! EditStudentInputViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Edit " + eventCell.name
    }
}
