//
//  ScheduleController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-10-18.
//

import Foundation
import RealmSwift

class ScheduleController {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    // CREATE
    func createSchedule(day1: [String], day2: [String], day3: [String], day4: [String], day5: [String], day6: [String], day7: [String], day8: [String], day9: [String], day10: [String]) -> Schedule {
        let newSchedule = Schedule()
        
        // add daily schedule to schedule object
        newSchedule.day1 = day1
        newSchedule.day2 = day2
        newSchedule.day3 = day3
        newSchedule.day4 = day4
        newSchedule.day5 = day5
        newSchedule.day6 = day6
        newSchedule.day7 = day7
        newSchedule.day8 = day8
        newSchedule.day9 = day9
        newSchedule.day10 = day10
        
        // write the new schedule to the database
        try! realm.write {
            realm.add(newSchedule)
        }
        
        // return schedule, mostly for testing
        return newSchedule
    }
    
    // READ
    func getSchedule(user: User) -> Schedule {
        // get the schedule for a specific user
        return user.schedule
    }
    
    // UPDATE
    func updateSchedule(schedule: Schedule, day1: [String], day2: [String], day3: [String], day4: [String], day5: [String], day6: [String], day7: [String], day8: [String], day9: [String], day10: [String]) {
        
        // update new fields to the db
        // any unchanged fields will be replaced in the db with their original value
        try! realm.write {
            schedule.day1 = day1
            schedule.day2 = day2
            schedule.day3 = day3
            schedule.day4 = day4
            schedule.day5 = day5
            schedule.day6 = day6
            schedule.day7 = day7
            schedule.day8 = day8
            schedule.day9 = day9
            schedule.day10 = day10
        }
    }
    
    // DELETE
    func deleteSchedule(schedule: Schedule) {
        // delete schedule
        // for cleanup when user is deleted
        try! realm.write {
            realm.delete(schedule)
        }
    }
}
