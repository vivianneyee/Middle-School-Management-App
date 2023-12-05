//
//  EventViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var className: String = ""
    var userID: String = ""
    var classID: String = ""
    var eventData: [Event] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
        
        let eventController = EventController()
        let classController = ClassController()
        self.eventData.removeAll()
        classController.getClassById(id: self.classID){ [self] result in
            switch result {
            case .success(let dataResponse):
                var classTitle = dataResponse.class.className
                print(dataResponse)
                // for each class, go through each alert
                for ev in dataResponse.class.events {
                    eventController.getEventById(id: ev) { [self] result in
                        switch result {
                        case .success(let dataResponse):
                            print(dataResponse)
                            self.eventData.append(dataResponse.event)
                            DispatchQueue.main.async {
                                print("self.eventData ", self.eventData )
                                self.table.reloadData()
                            }
                        case .failure(let error):
                            print("error", error)
                        }
                    }
                }
            case .failure(let error):
                print("error", error)
                
            }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let eventController = EventController()
//        let classController = ClassController()
//        self.eventData.removeAll()
//        classController.getClassById(id: self.classID){ [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let dataResponse):
//                var classTitle = dataResponse.class.className
//                print(dataResponse)
//                // for each class, go through each alert
//                for ev in dataResponse.class.events {
//                    eventController.getEventById(id: ev) { [self] result in
//                        switch result {
//                        case .success(let dataResponse):
//                            print(dataResponse)
//                            self.eventData.append(dataResponse.event)
//                            DispatchQueue.main.async {
//                                print("self.eventData ", self.eventData )
//                                self.table.reloadData()
//                            }
//                        case .failure(let error):
//                            print("error", error)
//                        }
//                    }
//                }
//            case .failure(let error):
//                print("error", error)
//                
//            }
//            
//        }
//    }
    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createEvent") as! CreateEventViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.className = self.className
        vc.title = "Create New Event"
        vc.userID = self.userID
        vc.classID = self.classID
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dcFormatter = DateComponentsFormatter()
        dcFormatter.includesApproximationPhrase = false
        dcFormatter.allowedUnits = [.month, .day, .year]
        
        let eventCell = self.eventData[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
//
//        let date = Calendar.current.date(from: eventCell.date)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM dd yyyy"
//        cell.date.text = formatter.string(from : date!)
//
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: eventCell.datePosted) {
            dateFormatter.dateFormat = "MMMM dd yyyy"
            let formattedDate = dateFormatter.string(from: date)
            cell.date.text = formattedDate
        } else {
            cell.date.text = eventCell.datePosted
        }
        
        cell.name.text = eventCell.title
        cell.desc.text = eventCell.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventCell = eventData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "createEvent") as! CreateEventViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Edit " + eventCell.title
        vc.eventID = eventCell._id
        vc.eventName = eventCell.title
        vc.classID = self.classID
    }
}
