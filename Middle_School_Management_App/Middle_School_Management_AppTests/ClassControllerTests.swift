//
//  ClassControllerTests.swift
//  Middle_School_Management_AppTests
//
//  Created by Vivianne Yee on 2023-10-17.
//

import XCTest
@testable import Middle_School_Management_App
import RealmSwift

class ClassControllerTests: XCTestCase {
    
    var classController: ClassController!
    var classCode: String?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "TestRealm"))
        classController = ClassController(realm: realm)
    }

    override func tearDown() {
        classController = nil
        super.tearDown()
    }
    
    // test createClass function
    func testCreateClass() {
        // class attributes
        let className = "Math"
        let classColor = "Red"
        
        do {
            let newClass = try classController.createClass(name: className, color: classColor)
            
            // assert class exists, has the right name and color, and has a code
            XCTAssertNotNil(newClass)
            XCTAssertEqual(newClass.name, className)
            XCTAssertEqual(newClass.color, classColor)
            XCTAssertNotNil(newClass.code)
        } catch {
            XCTFail("Failed to create class: \(error)")
        }
    }
    
    func testGetClassByCode() {
        // class attributes
        let className = "English"
        let classColor = "Yellow"
        
        do {
            let newClass = try classController.createClass(name: className, color: classColor)
            let retrievedClass = try classController.getClassByCode(code: newClass.code)
            
            // assert that the right class is retrieved
            XCTAssertNotNil(retrievedClass)
            XCTAssertEqual(retrievedClass.name, className)
            XCTAssertEqual(retrievedClass.color, classColor)
        } catch {
            XCTFail("Failed to get class: \(error)")
        }
    }
    
    func testGetAllClasses() {
        // class attributes for 2 classes
        let className1 = "Science"
        let className2 = "Social Studies"

        let classColor1 = "Green"
        let classColor2 = "Blue"
        
        do {
            let newClass1 = try classController.createClass(name: className1, color: classColor1)
            let newClass2 = try classController.createClass(name: className2, color: classColor2)
            
            let allClasses = try classController.getAllClasses()
            
            XCTAssertNotNil(allClasses)
            XCTAssertEqual(allClasses.count, 2)
        } catch {
            XCTFail("Failed to get all classes")
        }
    }
    
    func testUpdateClass() {
        let className = "Gym"
        let classColor = "Black"
        
        do {
            let newClass = classController.createClass(name: className, color: classColor)
            
            classController.updateClass(classObj: newClass, name: "Dance", color: "Purple")
            
            XCTAssertEqual(newClass.name, "Dance")
            XCTAssertEqual(newClass.color, "Purple")
        } catch {
            XCTFail("Failed to update class \(error)")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
