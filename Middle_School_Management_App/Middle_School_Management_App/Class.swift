//
//  Class.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-21.
//

import Foundation
import RealmSwift

class Class: Object {
    @Persisted var name: String = ""
    @Persisted var color: String = ""
    @Persisted var code: String = ""
    @Persisted var events: List<Event>
    @Persisted var assignments: List<Assignment>
    @Persisted var alerts: List<Alert>
    @Persisted var studentInputs: List<StudentInput>
    
    convenience init(name: String, color: String, code: String) {
        self.init()
        self.name = name
        self.color = color
        self.code = code
    }
}
