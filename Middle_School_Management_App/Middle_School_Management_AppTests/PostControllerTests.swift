//
//  PostControllerTests.swift
//  Middle_School_Management_AppTests
//
//  Created by Vivianne Yee on 2023-10-18.
//

import XCTest
@testable import Middle_School_Management_App
import RealmSwift

final class PostControllerTests: XCTestCase {
    
    var postController: PostContoller!
    var classController: ClassController!
    var newClass: Class!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "TestRealm"))
        postController = PostContoller(realm: realm)
        classController = ClassController(realm: realm)
        newClass = classController.createClass(name: "testClass", color: "Red")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        postController = nil
        super.tearDown()
    }
    
    func testCreateEvent() {
        let eventTitle = "event1"
        let eventDesc = "test event"
        let startDate = Date() // todays date
        let endDate = Date.init(timeIntervalSinceNow: 86400) // tomorrows date
        
        let newEvent = postController.createEvent(classObj: newClass, title: eventTitle, desc: eventDesc, startDate: startDate, endDate: endDate)
        
        XCTAssertNotNil(newEvent)
        XCTAssertEqual(newEvent.title, eventTitle)
        XCTAssertEqual(newEvent.desc, eventDesc)
        XCTAssertNotNil(newEvent.date)
        XCTAssertEqual(newEvent.startDate, startDate)
        XCTAssertEqual(newEvent.endDate, endDate)
        XCTAssertEqual(newEvent.postType, "EVENT")
    }
    
    func testCreateAssignment() {
        let assignmentTitle = "assignment1"
        let assignmentDesc = "test assignment"
        let assignmentDueDate = Date.init(timeIntervalSinceNow: 86400)
        
        let newAssignment = postController.createAssignment(classObj: newClass, title: assignmentTitle, desc: assignmentDesc, dueDate: assignmentDueDate)
        
        XCTAssertNotNil(newAssignment)
        XCTAssertEqual(newAssignment.title, assignmentTitle)
        XCTAssertEqual(newAssignment.desc, assignmentDesc)
        XCTAssertNotNil(newAssignment.date)
        XCTAssertEqual(newAssignment.dueDate, assignmentDueDate)
        XCTAssertEqual(newAssignment.postType, "ASSIGNMENT")
    }
    
    func testCreateAlert() {
        let alertTitle = "alert1"
        let alertPriority = "high"
        let alertDesc = "test alert"
        
        let newAlert = postController.createAlert(classObj: newClass, title: alertTitle, desc: alertDesc, priority: alertPriority)
        
        XCTAssertNotNil(newAlert)
        XCTAssertEqual(newAlert.title, alertTitle)
        XCTAssertEqual(newAlert.priority, alertPriority)
        XCTAssertEqual(newAlert.desc, alertDesc)
        XCTAssertNotNil(newAlert.date)
        XCTAssertEqual(newAlert.postType, "ALERT")
    }
    
    func testCreateStudentInput() {
        let siTitle = "studentInput1"
        let inputType = "Poll"
        let siDesc = "test student input"
        
        let newStuInput = postController.createStudentInput(classObj: newClass, title: siTitle, desc: siDesc, inputType: inputType)
        
        XCTAssertNotNil(newStuInput)
        XCTAssertEqual(newStuInput.title, siTitle)
        XCTAssertEqual(newStuInput.inputType, inputType)
        XCTAssertEqual(newStuInput.desc, siDesc)
        XCTAssertNotNil(newStuInput.date)
        XCTAssertEqual(newStuInput.postType, "STUDENTINPUT")
        
    }
    
    func testUpdateEvent() {
        let eventTitle = "event1"
        let eventDesc = "test event"
        let startDate = Date()
        let endDate = Date.init(timeIntervalSinceNow: 86400)
        
        let newTitle = "event2"
        let newDesc = "updated event"
        let newStartDate = Date.init(timeIntervalSinceNow: 86400) // tomorrow
        let newEndDate = Date.init(timeIntervalSinceNow: 172800) // 2 days from now
        
        let newEvent = postController.createEvent(classObj: newClass, title: eventTitle, desc: eventDesc, startDate: startDate, endDate: endDate)
        
        postController.updateEvent(eventObj: newEvent, title: newTitle, desc: newDesc, startDate: newStartDate, endDate: newEndDate)
        
        XCTAssertNotNil(newEvent)
        XCTAssertEqual(newEvent.title, newTitle)
        XCTAssertEqual(newEvent.desc, newDesc)
        XCTAssertEqual(newEvent.startDate, newStartDate)
        XCTAssertEqual(newEvent.endDate, newEndDate)
    }
    
    func testUpdateAssignment() {
        let assignmentTitle = "event1"
        let assignmentDesc = "test event"
        let dueDate = Date.init(timeIntervalSinceNow: 86400)
        
        let newTitle = "assignment2"
        let newDesc = "updated assignment"
        let newDueDate = Date.init(timeIntervalSinceNow: 172800) // 2 days from now
        
        let newAssignment = postController.createAssignment(classObj: newClass, title: assignmentTitle, desc: assignmentDesc, dueDate: dueDate)
        
        postController.updateAssignment(assignmentObj: newAssignment, title: newTitle, desc: newDesc, dueDate: newDueDate)
        
        XCTAssertNotNil(newAssignment)
        XCTAssertEqual(newAssignment.title, newTitle)
        XCTAssertEqual(newAssignment.desc, newDesc)
        XCTAssertEqual(newAssignment.dueDate, newDueDate)
    }
    
    func testUpdateAlert() {
        let alertTitle = "alert1"
        let alertPriority = "high"
        let alertDesc = "test alert"
        
        let newTitle = "alert2"
        let newPriority = "low"
        let newDesc = "updated alert"
        
        let newAlert = postController.createAlert(classObj: newClass, title: alertTitle, desc: alertDesc, priority: alertPriority)
        
        postController.updateAlert(alertObj: newAlert, title: newTitle, desc: newDesc, priority: newPriority)
        
        XCTAssertEqual(newAlert.title, newTitle)
        XCTAssertEqual(newAlert.priority, newPriority)
        XCTAssertEqual(newAlert.desc, newDesc)
    }
    
    func testUpdateStudentAlert() {
        let siTitle = "studentInput1"
        let inputType = "Poll"
        let siDesc = "test student input"
        
        let newTitle = "studentInput2"
        let newType = "Text"
        let newDesc = "updated student input"
        
        let newStuInput = postController.createStudentInput(classObj: newClass, title: siTitle, desc: siDesc, inputType: inputType)
        
        postController.updateStudentInput(studentInp: newStuInput, title: newTitle, desc: newDesc, inputType: newType)
        
        XCTAssertEqual(newStuInput.title, newTitle)
        XCTAssertEqual(newStuInput.inputType, newType)
        XCTAssertEqual(newStuInput.desc, newDesc)
    }
    
    func testGetEvents() {
        let title1 = "event1"
        let desc1 = "test event1"
        let startDate1 = Date()
        let endDate1 = Date.init(timeIntervalSinceNow: 86400)
        
        let title2 = "event2"
        let desc2 = "test event2"
        let startDate2 = Date.init(timeIntervalSinceNow: 86400) // tomorrow
        let endDate2 = Date.init(timeIntervalSinceNow: 172800) // 2 days from now
        
        let event1 = postController.createEvent(classObj: newClass, title: title1, desc: desc1, startDate: startDate1, endDate: endDate1)
        
        let event2 = postController.createEvent(classObj: newClass, title: title2, desc: desc2, startDate: startDate2, endDate: endDate2)
        
        let events = postController.getEvents(classObj: newClass)
        
        XCTAssertEqual(events.count, 2)
    }
    
    func testGetAssignments() {
        let title1 = "assignment1"
        let desc1 = "test assignment1"
        let dueDate1 = Date.init(timeIntervalSinceNow: 86400)
        
        let title2 = "assignment2"
        let desc2 = "test assignment2"
        let dueDate2 = Date.init(timeIntervalSinceNow: 172800) // 2 days from now
        
        let assignment1 = postController.createAssignment(classObj: newClass, title: title1, desc: desc1, dueDate: dueDate1)
        
        let assignment2 = postController.createAssignment(classObj: newClass, title: title2, desc: desc2, dueDate: dueDate2)
        
        let assignments = postController.getAssignments(classObj: newClass)
        
        XCTAssertEqual(assignments.count, 2)
    }
    
    func testGetAlerts() {
        let title1 = "alert1"
        let desc1 = "test alert1"
        let priority1 = "high"
        
        let title2 = "alert2"
        let desc2 = "test alert2"
        let priority2 = "medium"
        
        let alert1 = postController.createAlert(classObj: newClass, title: title1, desc: desc1, priority: priority1)
        
        let alert2 = postController.createAlert(classObj: newClass, title: title2, desc: desc2, priority: priority2)
        
        let alerts = postController.getAlerts(classObj: newClass)
        
        XCTAssertEqual(alerts.count, 2)
    }
    
    func testGetStudentInputs() {
        let title1 = "si1"
        let desc1 = "test si1"
        let type1 = "poll"
        
        let title2 = "si2"
        let desc2 = "test si2"
        let type2 = "text"
        
        let si1 = postController.createStudentInput(classObj: newClass, title: title1, desc: desc1, inputType: type1)
        
        let si2 = postController.createStudentInput(classObj: newClass, title: title2, desc: desc2, inputType: type2)
        
        let studentInputs = postController.getStudentInputs(classObj: newClass)
        
        XCTAssertEqual(studentInputs.count, 2)
    }
    
    func testGetEventById() {
        let eventTitle = "event1"
        let eventDesc = "test event"
        let startDate = Date()
        let endDate = Date.init(timeIntervalSinceNow: 86400)
        
        let newEvent = postController.createEvent(classObj: newClass, title: eventTitle, desc: eventDesc, startDate: startDate, endDate: endDate)
        
        let eventId = newEvent._id
        
        let retrievedEvent = postController.getEventById(id: eventId)
        
        XCTAssertNotNil(retrievedEvent)
        XCTAssertEqual(retrievedEvent.title, eventTitle)
        XCTAssertEqual(retrievedEvent.desc, eventDesc)
        XCTAssertEqual(retrievedEvent.startDate, startDate)
        XCTAssertEqual(retrievedEvent.endDate, endDate)
    }
    
    func testGetAssignmentById() {
        let assignmentTitle = "assignment1"
        let assignmentDesc = "test assignment"
        let assignmentDueDate = Date.init(timeIntervalSinceNow: 86400)
        
        let newAssignment = postController.createAssignment(classObj: newClass, title: assignmentTitle, desc: assignmentDesc, dueDate: assignmentDueDate)
        
        let assignmentId = newAssignment._id
        
        let retrievedAssignment = postController.getAssignmentById(id: assignmentId)
        
        XCTAssertNotNil(retrievedAssignment)
        XCTAssertEqual(retrievedAssignment.title, assignmentTitle)
        XCTAssertEqual(retrievedAssignment.desc, assignmentDesc)
        XCTAssertEqual(retrievedAssignment.dueDate, assignmentDueDate)
    }
    
    func testGetAlertById() {
        let alertTitle = "alert1"
        let alertPriority = "high"
        let alertDesc = "test alert"
        
        let newAlert = postController.createAlert(classObj: newClass, title: alertTitle, desc: alertDesc, priority: alertPriority)
        
        let alertId = newAlert._id
        
        let retrievedAlert = postController.getAlertById(id: alertId)
        
        XCTAssertNotNil(retrievedAlert)
        XCTAssertEqual(retrievedAlert.title, alertTitle)
        XCTAssertEqual(retrievedAlert.priority, alertPriority)
        XCTAssertEqual(retrievedAlert.desc, alertDesc)
    }
    
    func testGetStudentInputById() {
        let siTitle = "studentInput1"
        let inputType = "Poll"
        let siDesc = "test student input"
        
        let newStuInput = postController.createStudentInput(classObj: newClass, title: siTitle, desc: siDesc, inputType: inputType)
        
        let studentInputId = newStuInput._id
        
        let retrievedStuInput = postController.getStudentInpById(id: studentInputId)
        
        XCTAssertNotNil(retrievedStuInput)
        XCTAssertEqual(retrievedStuInput.title, siTitle)
        XCTAssertEqual(retrievedStuInput.inputType, inputType)
        XCTAssertEqual(retrievedStuInput.desc, siDesc)
    }
    
    func testAddResponse() {
        let siTitle = "studentInput1"
        let inputType = "Poll"
        let siDesc = "test student input"
        
        let response1 = "yes"
        let response2 = "no"
        
        let newStuInput = postController.createStudentInput(classObj: newClass, title: siTitle, desc: siDesc, inputType: inputType)
        
        postController.addResponse(studentInp: newStuInput, response: response1)
        postController.addResponse(studentInp: newStuInput, response: response2)
        
        XCTAssertNotNil(newStuInput.responses)
        XCTAssertEqual(newStuInput.responses.count, 2)
    }
    
    func testDeleteEvent() {
        let eventTitle = "event1"
        let eventDesc = "test event"
        let startDate = Date()
        let endDate = Date.init(timeIntervalSinceNow: 86400)
        
        let newEvent = postController.createEvent(classObj: newClass, title: eventTitle, desc: eventDesc, startDate: startDate, endDate: endDate)
        
        postController.deleteEvent(eventObj: newEvent)
        
        let events = postController.getEvents(classObj: newClass)
        
        XCTAssertEqual(events.count, 0)
    }
    
    func testDeleteAssignment() {
        let assignmentTitle = "assignment1"
        let assignmentDesc = "test assignment"
        let assignmentDueDate = Date.init(timeIntervalSinceNow: 86400)
        
        let newAssignment = postController.createAssignment(classObj: newClass, title: assignmentTitle, desc: assignmentDesc, dueDate: assignmentDueDate)
        
        postController.deleteAssignment(assignmentObj: newAssignment)
        
        let assignments = postController.getAssignments(classObj: newClass)
        
        XCTAssertEqual(assignments.count, 0)
    }
    
    func testDeleteAlert() {
        let alertTitle = "alert1"
        let alertPriority = "high"
        let alertDesc = "test alert"
        
        let newAlert = postController.createAlert(classObj: newClass, title: alertTitle, desc: alertDesc, priority: alertPriority)
        
        postController.deleteAlert(alertObj: newAlert)
        
        let alerts = postController.getAlerts(classObj: newClass)
        
        XCTAssertEqual(alerts.count, 0)
    }
    
    func testDeleteStudentInput() {
        let siTitle = "studentInput1"
        let inputType = "Poll"
        let siDesc = "test student input"
        
        let newStuInput = postController.createStudentInput(classObj: newClass, title: siTitle, desc: siDesc, inputType: inputType)
        
        postController.deleteStudentInput(studentInp: newStuInput)
        
        let stuInputs = postController.getStudentInputs(classObj: newClass)
        
        XCTAssertEqual(stuInputs.count, 0)
    }

}
