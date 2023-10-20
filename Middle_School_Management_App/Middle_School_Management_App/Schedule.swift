//
//  Schedule.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-10-18.
//

import Foundation
import RealmSwift

class Schedule: Object {
    // each day in the 10 day schedule will be initialized as empty string array of size 5 since there are 5 periods per day
    var day1 = [String](repeating: "", count: 5)
    var day2 = [String](repeating: "", count: 5)
    var day3 = [String](repeating: "", count: 5)
    var day4 = [String](repeating: "", count: 5)
    var day5 = [String](repeating: "", count: 5)
    var day6 = [String](repeating: "", count: 5)
    var day7 = [String](repeating: "", count: 5)
    var day8 = [String](repeating: "", count: 5)
    var day9 = [String](repeating: "", count: 5)
    var day10 = [String](repeating: "", count: 5)
}
