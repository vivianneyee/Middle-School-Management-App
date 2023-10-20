//
//  NotificationsViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift


class NotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
        
    }
    
    //    @objc func didTapAdd() {
    //        let vc = storyboard?.instantiateViewController(identifier: "createPost") as! CreatePostViewController
    //        navigationController?.pushViewController(vc, animated: true)
    //
    //        vc.title = "Create New Event"
    //    }
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dcFormatter = DateComponentsFormatter()
        dcFormatter.includesApproximationPhrase = false
        dcFormatter.allowedUnits = [.month, .day, .year]
        
        let eventCell = allNotifs[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotifTableViewCell
        
        let date = Calendar.current.date(from: eventCell.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        
        
        cell.date.text = formatter.string(from : date!)
        
        cell.className.text = eventCell.name
        
        cell.notif.text = eventCell.notif
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
