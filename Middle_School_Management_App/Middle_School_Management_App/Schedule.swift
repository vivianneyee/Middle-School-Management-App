//
//  Schedule.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-10-18.
//

import Foundation
import RealmSwift

//class Schedule: Object {
//    // each day in the 10 day schedule will be initialized as empty string array of size 5 since there are 5 periods per day
//    var day1 = [String](repeating: "", count: 5)
//    var day2 = [String](repeating: "", count: 5)
//    var day3 = [String](repeating: "", count: 5)
//    var day4 = [String](repeating: "", count: 5)
//    var day5 = [String](repeating: "", count: 5)
//    var day6 = [String](repeating: "", count: 5)
//    var day7 = [String](repeating: "", count: 5)
//    var day8 = [String](repeating: "", count: 5)
//    var day9 = [String](repeating: "", count: 5)
//    var day10 = [String](repeating: "", count: 5)
//}

struct ScheduleResponse: Decodable {
    let message: String
    let _id: String
    let day1: [String]
    let day2: [String]
    let day3: [String]
    let day4: [String]
    let day5: [String]
    let day6: [String]
    let day7: [String]
    let day8: [String]
    let day9: [String]
    let day10: [String]
}

struct Schedule: Decodable {
    let _id: String
    let day1: [String]
    let day2: [String]
    let day3: [String]
    let day4: [String]
    let day5: [String]
    let day6: [String]
    let day7: [String]
    let day8: [String]
    let day9: [String]
    let day10: [String]
    
    enum CodingKeys: String, CodingKey {
        case _id
        case day1
        case day2
        case day3
        case day4
        case day5
        case day6
        case day7
        case day8
        case day9
        case day10
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.day1 = try container.decode([String].self, forKey: .day1)
        self.day2 = try container.decode([String].self, forKey: .day2)
        self.day3 = try container.decode([String].self, forKey: .day3)
        self.day4 = try container.decode([String].self, forKey: .day4)
        self.day5 = try container.decode([String].self, forKey: .day5)
        self.day6 = try container.decode([String].self, forKey: .day6)
        self.day7 = try container.decode([String].self, forKey: .day7)
        self.day8 = try container.decode([String].self, forKey: .day8)
        self.day9 = try container.decode([String].self, forKey: .day9)
        self.day10 = try container.decode([String].self, forKey: .day10)
    }
}
