//
//  AlertViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class AlertViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    var className: String = ""
    var userID: String = ""
    var classID: String = ""

    var alertData: [Alert] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
        
        let alertController = AlertController()
        let classController = ClassController()
        self.alertData.removeAll()
        classController.getClassById(id: self.classID){ [self] result in
            switch result {
            case .success(let dataResponse):
                var classTitle = dataResponse.class.className
                print(dataResponse)
                // for each class, go through each alert
                for al in dataResponse.class.alerts {
                    alertController.getAlertById(id: al) { [self] result in
                        switch result {
                        case .success(let dataResponse):
                            print(dataResponse)
                            self.alertData.append(dataResponse.alert)
                            DispatchQueue.main.async {
                                print("self.alertData ", self.alertData )
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let alertController = AlertController()
        let classController = ClassController()
        self.alertData.removeAll()
        classController.getClassById(id: self.classID){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dataResponse):
                var classTitle = dataResponse.class.className
                print(dataResponse)
                // for each class, go through each alert
                for al in dataResponse.class.alerts {
                    alertController.getAlertById(id: al) { [self] result in
                        switch result {
                        case .success(let dataResponse):
                            print(dataResponse)
                            self.alertData.append(dataResponse.alert)
                            DispatchQueue.main.async {
                                print("self.alertData", self.alertData)
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
    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createAlert") as! CreateAlertViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.className = self.className
        vc.title = "Create New Alert"
        vc.userID = self.userID
        vc.classID = self.classID
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dcFormatter = DateComponentsFormatter()
        dcFormatter.includesApproximationPhrase = false
        dcFormatter.allowedUnits = [.month, .day, .year]
        
        let eventCell = alertData[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
//        let date = Calendar.current.date(from: eventCell.datePosted)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM dd yyyy"
//        cell.date.text = formatter.string(from : eventCell.datePosted)
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventCell = alertData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "createAlert") as! CreateAlertViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Edit " + eventCell.title
        vc.userID = self.userID
        vc.classID = self.classID
        vc.alertID = eventCell._id
        vc.alertName = eventCell.title
    }
}
