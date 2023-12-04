//
//  ScheduleInfoViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-12-02.
//
import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class ScheduleInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var userID: String = ""
    var classID: String = ""
    var scheduleID: String = ""
    var changedDays: [Int] = [-1]
    var scheduleData: [[String]] = [["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""]]
    var scheduleDataID: [[String]] = [["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""]]
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var button: UIButton!
    var day1Sche: [String] = ["","","","","","",""]
    var day2Sche: [String] = ["","","","","","",""]
    var day3Sche: [String] = ["","","","","","",""]
    var day4Sche: [String] = ["","","","","","",""]
    var day5Sche: [String] = ["","","","","","",""]
    var day6Sche: [String] = ["","","","","","",""]
    var day7Sche: [String] = ["","","","","","",""]
    var day8Sche: [String] = ["","","","","","",""]
    var day9Sche: [String] = ["","","","","","",""]
    var day10Sche: [String] = ["","","","","","",""]
    
    let dayLabels: [String] = [
        "Day 1",
        "Day 2",
        "Day 3",
        "Day 4",
        "Day 5",
        "Day 6",
        "Day 7",
        "Day 8",
        "Day 9",
        "Day 10",
//        "Student Input"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        if self.title == "Create New Schedule" {
            // creating
            self.button.setTitle("Create", for: .normal)
        } else {
            // editing
            self.button.setTitle("Update", for: .normal)
            scheduleController.getScheduleById(id: self.scheduleID) { [self] result in
                switch result {
                case .success(let schedule):
                    print("successfully got user schedule", schedule)
                    DispatchQueue.main.async {
                        self.day1Sche = schedule.day1
                        self.day2Sche = schedule.day2
                        self.day3Sche = schedule.day3
                        self.day4Sche = schedule.day4
                        self.day5Sche = schedule.day5
                        self.day6Sche = schedule.day6
                        self.day7Sche = schedule.day7
                        self.day8Sche = schedule.day8
                        self.day9Sche = schedule.day9
                        self.day10Sche = schedule.day10
                        self.table.reloadData()
                    }
                case .failure(let error):
                    print("failed to get schedule", error)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("changed days currently before", self.changedDays)
        DispatchQueue.main.async {
            var ind = 0
            while ind < self.changedDays.count {
                let i = self.changedDays[ind]
                switch i {
                case 0:
                    self.day1Sche = self.scheduleData[0]
                    self.changedDays.remove(at: ind)
                case 1:
                    self.day2Sche = self.scheduleData[1]
                    self.changedDays.remove(at: ind)
                case 2:
                    self.day3Sche = self.scheduleData[2]
                    self.changedDays.remove(at: ind)
                case 3:
                    self.day4Sche = self.scheduleData[3]
                    self.changedDays.remove(at: ind)
                case 4:
                    self.day5Sche = self.scheduleData[4]
                    self.changedDays.remove(at: ind)
                case 5:
                    self.day6Sche = self.scheduleData[5]
                    self.changedDays.remove(at: ind)
                case 6:
                    self.day7Sche = self.scheduleData[6]
                    self.changedDays.remove(at: ind)
                case 7:
                    self.day8Sche = self.scheduleData[7]
                    self.changedDays.remove(at: ind)
                case 8:
                    self.day9Sche = self.scheduleData[8]
                    self.changedDays.remove(at: ind)
                case 9:
                    self.day10Sche = self.scheduleData[9]
                    self.changedDays.remove(at: ind)
                default:
                    ind += 1
                    print("no change")
                }
                
            }
//            self.day1Sche = self.scheduleData[0]
//            self.day2Sche = self.scheduleData[1]
//            self.day3Sche = self.scheduleData[2]
//            self.day4Sche = self.scheduleData[3]
//            self.day5Sche = self.scheduleData[4]
//            self.day6Sche = self.scheduleData[5]
//            self.day7Sche = self.scheduleData[6]
//            self.day8Sche = self.scheduleData[7]
//            self.day9Sche = self.scheduleData[8]
//            self.day10Sche = self.scheduleData[9]
            
            self.table.reloadData()
            print("schedule data currently", self.scheduleData)
            print("changed days currently after", self.changedDays)
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let labelCell = dayLabels[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScheduleTableViewCell
        cell.day.text = labelCell
        DispatchQueue.main.async {
            if cell.day.text  == "Day 1" {
                //            cell.period1.text = self.scheduleData[0][0]
                //            cell.period2.text = self.scheduleData[0][1]
                //            cell.period3.text = self.scheduleData[0][2]
                //            cell.period4.text = self.scheduleData[0][3]
                //            cell.period5.text = self.scheduleData[0][4]
                //            cell.period6.text = self.scheduleData[0][5]
                //            cell.period7.text = self.scheduleData[0][6]
                cell.period1.text = self.day1Sche[0]
                cell.period2.text = self.day1Sche[1]
                cell.period3.text = self.day1Sche[2]
                cell.period4.text = self.day1Sche[3]
                cell.period5.text = self.day1Sche[4]
                cell.period6.text = self.day1Sche[5]
                cell.period7.text = self.day1Sche[6]
            } else if cell.day.text  == "Day 2" {
                //            cell.period1.text = self.scheduleData[1][0]
                //            cell.period2.text = self.scheduleData[1][1]
                //            cell.period3.text = self.scheduleData[1][2]
                //            cell.period4.text = self.scheduleData[1][3]
                //            cell.period5.text = self.scheduleData[1][4]
                //            cell.period6.text = self.scheduleData[1][5]
                //            cell.period7.text = self.scheduleData[1][6]
                cell.period1.text = self.day2Sche[0]
                cell.period2.text = self.day2Sche[1]
                cell.period3.text = self.day2Sche[2]
                cell.period4.text = self.day2Sche[3]
                cell.period5.text = self.day2Sche[4]
                cell.period6.text = self.day2Sche[5]
                cell.period7.text = self.day2Sche[6]
            } else if cell.day.text  == "Day 3" {
                //            cell.period1.text = self.scheduleData[2][0]
                //            cell.period2.text = self.scheduleData[2][1]
                //            cell.period3.text = self.scheduleData[2][2]
                //            cell.period4.text = self.scheduleData[2][3]
                //            cell.period5.text = self.scheduleData[2][4]
                //            cell.period6.text = self.scheduleData[2][5]
                //            cell.period7.text = self.scheduleData[2][6]
                cell.period1.text = self.day3Sche[0]
                cell.period2.text = self.day3Sche[1]
                cell.period3.text = self.day3Sche[2]
                cell.period4.text = self.day3Sche[3]
                cell.period5.text = self.day3Sche[4]
                cell.period6.text = self.day3Sche[5]
                cell.period7.text = self.day3Sche[6]
            } else if cell.day.text  == "Day 4" {
                //            cell.period1.text = self.scheduleData[3][0]
                //            cell.period2.text = self.scheduleData[3][1]
                //            cell.period3.text = self.scheduleData[3][2]
                //            cell.period4.text = self.scheduleData[3][3]
                //            cell.period5.text = self.scheduleData[3][4]
                //            cell.period6.text = self.scheduleData[3][5]
                //            cell.period7.text = self.scheduleData[3][6]
                cell.period1.text = self.day4Sche[0]
                cell.period2.text = self.day4Sche[1]
                cell.period3.text = self.day4Sche[2]
                cell.period4.text = self.day4Sche[3]
                cell.period5.text = self.day4Sche[4]
                cell.period6.text = self.day4Sche[5]
                cell.period7.text = self.day4Sche[6]
            } else if cell.day.text  == "Day 5" {
                //            cell.period1.text = self.scheduleData[4][0]
                //            cell.period2.text = self.scheduleData[4][1]
                //            cell.period3.text = self.scheduleData[4][2]
                //            cell.period4.text = self.scheduleData[4][3]
                //            cell.period5.text = self.scheduleData[4][4]
                //            cell.period6.text = self.scheduleData[4][5]
                //            cell.period7.text = self.scheduleData[4][6]
                cell.period1.text = self.day5Sche[0]
                cell.period2.text = self.day5Sche[1]
                cell.period3.text = self.day5Sche[2]
                cell.period4.text = self.day5Sche[3]
                cell.period5.text = self.day5Sche[4]
                cell.period6.text = self.day5Sche[5]
                cell.period7.text = self.day5Sche[6]
            } else if cell.day.text  == "Day 6" {
                //            cell.period1.text = self.scheduleData[5][0]
                //            cell.period2.text = self.scheduleData[5][1]
                //            cell.period3.text = self.scheduleData[5][2]
                //            cell.period4.text = self.scheduleData[5][3]
                //            cell.period5.text = self.scheduleData[5][4]
                //            cell.period6.text = self.scheduleData[5][5]
                //            cell.period7.text = self.scheduleData[5][6]
                cell.period1.text = self.day6Sche[0]
                cell.period2.text = self.day6Sche[1]
                cell.period3.text = self.day6Sche[2]
                cell.period4.text = self.day6Sche[3]
                cell.period5.text = self.day6Sche[4]
                cell.period6.text = self.day6Sche[5]
                cell.period7.text = self.day6Sche[6]
            } else if cell.day.text  == "Day 7" {
                //            cell.period1.text = self.scheduleData[6][0]
                //            cell.period2.text = self.scheduleData[6][1]
                //            cell.period3.text = self.scheduleData[6][2]
                //            cell.period4.text = self.scheduleData[6][3]
                //            cell.period5.text = self.scheduleData[6][4]
                //            cell.period6.text = self.scheduleData[6][5]
                //            cell.period7.text = self.scheduleData[6][6]
                cell.period1.text = self.day7Sche[0]
                cell.period2.text = self.day7Sche[1]
                cell.period3.text = self.day7Sche[2]
                cell.period4.text = self.day7Sche[3]
                cell.period5.text = self.day7Sche[4]
                cell.period6.text = self.day7Sche[5]
                cell.period7.text = self.day7Sche[6]
            } else if cell.day.text  == "Day 8" {
                //            cell.period1.text = self.scheduleData[7][0]
                //            cell.period2.text = self.scheduleData[7][1]
                //            cell.period3.text = self.scheduleData[7][2]
                //            cell.period4.text = self.scheduleData[7][3]
                //            cell.period5.text = self.scheduleData[7][4]
                //            cell.period6.text = self.scheduleData[7][5]
                //            cell.period7.text = self.scheduleData[7][6]
                cell.period1.text = self.day8Sche[0]
                cell.period2.text = self.day8Sche[1]
                cell.period3.text = self.day8Sche[2]
                cell.period4.text = self.day8Sche[3]
                cell.period5.text = self.day8Sche[4]
                cell.period6.text = self.day8Sche[5]
                cell.period7.text = self.day8Sche[6]
            } else if cell.day.text  == "Day 9" {
                //            cell.period1.text = self.scheduleData[8][0]
                //            cell.period2.text = self.scheduleData[8][1]
                //            cell.period3.text = self.scheduleData[8][2]
                //            cell.period4.text = self.scheduleData[8][3]
                //            cell.period5.text = self.scheduleData[8][4]
                //            cell.period6.text = self.scheduleData[8][5]
                //            cell.period7.text = self.scheduleData[8][6]
                cell.period1.text = self.day9Sche[0]
                cell.period2.text = self.day9Sche[1]
                cell.period3.text = self.day9Sche[2]
                cell.period4.text = self.day9Sche[3]
                cell.period5.text = self.day9Sche[4]
                cell.period6.text = self.day9Sche[5]
                cell.period7.text = self.day9Sche[6]
            } else {
                //            cell.period1.text = self.scheduleData[9][0]
                //            cell.period2.text = self.scheduleData[9][1]
                //            cell.period3.text = self.scheduleData[9][2]
                //            cell.period4.text = self.scheduleData[9][3]
                //            cell.period5.text = self.scheduleData[9][4]
                //            cell.period6.text = self.scheduleData[9][5]
                //            cell.period7.text = self.scheduleData[9][6]
                cell.period1.text = self.day10Sche[0]
                cell.period2.text = self.day10Sche[1]
                cell.period3.text = self.day10Sche[2]
                cell.period4.text = self.day10Sche[3]
                cell.period5.text = self.day10Sche[4]
                cell.period6.text = self.day10Sche[5]
                cell.period7.text = self.day10Sche[6]
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let labelCell = dayLabels[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(identifier: "createSche") as! CreateScheduleViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.userID = self.userID
        if self.title == "Edit Schedule" {
            vc.title = "Edit " + labelCell + " Schedule"
        } else {
            vc.title = "Create " + labelCell + " Schedule"
        }
        vc.currentDay = indexPath.row
        vc.scheduleID = self.scheduleID
    }
    
    let userController = UserController()
    let scheduleController = ScheduleController()
    @IBAction func tappedButton() {
        if self.title == "Create New Schedule" {
            // creating
            self.button.setTitle("Create", for: .normal)
            scheduleController.createSchedule(day1: self.day1Sche, day2: self.day2Sche, day3: self.day3Sche, day4: self.day4Sche, day5: self.day5Sche, day6: self.day6Sche, day7: self.day7Sche, day8: self.day8Sche, day9: self.day9Sche, day10: self.day10Sche){ [self] result in
                switch result {
                case .success(let dataResponse):
                    print("Created schedule successully ", dataResponse)
                    userController.setSchedule(id: self.userID, scheduleId: dataResponse._id) { [self] result in
                        switch result {
                        case .success(let dataResponse):
                            print("successfully set schedule to user", dataResponse)
                        case .failure(let error):
                            print("failed to set schedule to user", error)
                        }
                    }
                case .failure(let error):
                    print("failed to create schedule: ", error)
                }
            }
        } else {
            // editing
//            self.button.setTitle("Edit", for: .normal)
            scheduleController.updateSchedule(id: self.scheduleID, day1: self.day1Sche, day2: self.day2Sche, day3: self.day3Sche, day4: self.day4Sche, day5: self.day5Sche, day6: self.day6Sche, day7: self.day7Sche, day8: self.day8Sche, day9: self.day9Sche, day10: self.day10Sche){ [self] result in
                switch result {
                case .success(let dataResponse):
                    print("updated schedule successully ", dataResponse)
                    userController.setSchedule(id: self.userID, scheduleId: dataResponse._id) { [self] result in
                        switch result {
                        case .success(let dataResponse):
                            print("successfully set schedule to user", dataResponse)
                        case .failure(let error):
                            print("failed to set schedule to user", error)
                        }
                    }
                case .failure(let error):
                    print("failed to update schedule: ", error)
                }
            }
        }
        DispatchQueue.main.async {
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }
    
}
