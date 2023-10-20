//
//  Middle_School_Management_AppUITests.swift
//  Middle_School_Management_AppUITests
//
//  Created by Vivianne Yee on 2023-03-13.
//

import XCTest

final class Middle_School_Management_AppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLogin() {
        // start app
        let app = XCUIApplication() // Create an instance of the app under test
        
        // Launch the app
        app.launch()
        
        // Interact with UI elements
        let emailTextField = app.textFields["Email or Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Login"]
        
        emailTextField.tap()
        emailTextField.typeText("testuser") // Replace with a valid test username
        passwordTextField.tap()
        passwordTextField.typeText("password123") // Replace with a valid test password
        loginButton.tap()
        
        // Verify that you're on the "home" view controller
        let cell = app.cells["cell"]
        XCTAssertTrue(cell.waitForExistence(timeout: 10), "The table cell doesn't exist")
    }
    
    func testSignup() {
        // start app
        let app = XCUIApplication()
        app.launch()
        app.buttons["Create an account"].tap()
        
        // enter credentials
        let emailTextField = app.textFields["Email or Username"]
        emailTextField.tap()
        emailTextField.typeText("test@email.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("password123")
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign up"]/*[[".buttons[\"Sign up\"].staticTexts[\"Sign up\"]",".staticTexts[\"Sign up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Element expected to be displayed is the cell of the home page
        let cell = app.cells["cell"]
        XCTAssertTrue(cell.waitForExistence(timeout: 10), "The table cell doesn't exist")
        
    }
    
    func testLogout() {
        // start app
        let app = XCUIApplication() // Create an instance of the app under test
        
        // Launch the app
        app.launch()
        
        // Interact with UI elements
        let emailTextField = app.textFields["Email or Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Login"]
        
        // Enter credentials
        emailTextField.tap()
        emailTextField.typeText("testuser") // Replace with a valid test username
        passwordTextField.tap()
        passwordTextField.typeText("password123") // Replace with a valid test password
        loginButton.tap()
        
        // Go to profile tab
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Contact Photo"].tap()
        
        // sign out from profile page
        app.staticTexts["Sign out"].tap()
                        
        // Verify that you're on the "login" view controller
        XCTAssertTrue(loginButton.waitForExistence(timeout: 10), "The table cell doesn't exist")
    }
    
    
    func testViewEvents() {
        // start app
        let app = XCUIApplication()
        app.launch()
        
        // go to home page
        app.buttons["Login"].tap()
        app.tabBars["Tab Bar"].buttons["home"].tap()
        
        // navigate the classes table of the home page (testing for French class)
        let tablesQuery = app.tables
        tablesQuery.cells["French, Events - 3, Assignments - 1, Alerts - 2"].children(matching: .other).element(boundBy: 1).tap()
        tablesQuery.cells.containing(.staticText, identifier:"Events").children(matching: .other).element(boundBy: 1).tap()
        
        // Test for existence of add new event button
        let newEventButton = app.navigationBars["Events"].buttons["Add"]
        XCTAssertTrue(newEventButton.waitForExistence(timeout: 10), "This button does not exist")
    }
    
    func testViewAssignments() {
        // start app
        let app = XCUIApplication()
        app.launch()
        app.buttons["Login"].tap()
        
        // navigate to the home page to view all classes
        app.tabBars["Tab Bar"].buttons["home"].tap()
        // test for the french class, then navigate to the assignments page
        let tablesQuery = app.tables
        tablesQuery.cells["French, Events - 3, Assignments - 1, Alerts - 2"].children(matching: .other).element(boundBy: 1).tap()
        tablesQuery.cells.containing(.staticText, identifier:"Assignments").children(matching: .other).element(boundBy: 1).tap()
        
        // assert existence of the new assignment button
        let newAssignmentButton = app.navigationBars["Assignments"].buttons["Add"]
        XCTAssertTrue(newAssignmentButton.waitForExistence(timeout: 10), "This button does not exist")
//
//        app.buttons["Login"].tap()
//
//        let tabBar = app.tabBars["Tab Bar"]
//        tabBar.buttons["home"].tap()
//
//        tablesQuery.staticTexts["Assignments"].tap()
//        app.navigationBars["Assignments"].buttons["Add"].tap()
//        tabBar.buttons["calendar"].tap()
//        app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.staticText, identifier:"Music").element.tap()
//        tabBar.buttons["Add to home screen"].tap()
//        app.buttons["Join"].tap()
//        tabBar.buttons["Contact Photo"].tap()
        
    }
    
    func testSchedule() {
        // start app
        let app = XCUIApplication()
        app.launch()
        app.buttons["Login"].tap()
        
        // go to schedule page
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["calendar"].tap()
        
        // assert that we're on the schedule page based on the title of the navigation bar
        let scheduleStaticText = app.navigationBars["Schedule"].staticTexts["Schedule"]
        XCTAssertTrue(scheduleStaticText.waitForExistence(timeout: 10), "This is not the schedule page")
    }
    
    func testJoinNewClass() {
        // start app
        let app = XCUIApplication()
        app.launch()
        app.buttons["Login"].tap()
        
        // go to join new class page
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Add to home screen"].tap()
        
        // Assert that class code field exists
        let classCodeField = app.textFields["Class code"]
        XCTAssertTrue(classCodeField.waitForExistence(timeout: 10), "Join class button does not exist")
    }
    
    func testProfile() {
        // start app
        let app = XCUIApplication()
        app.launch()
        app.buttons["Login"].tap()
        
        // go to profile page
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Contact Photo"].tap()
        
        // assert that we're on the profile page based on the title of the navigation bar
        let pageTitle =  app.navigationBars["My Profile"].staticTexts["My Profile"]
        XCTAssertTrue(pageTitle.waitForExistence(timeout: 10), "This is not the profile page")
    }
    
    func testNotifications() {
        // start app
        let app = XCUIApplication()
        app.launch()
        app.buttons["Login"].tap()
        
        // go to notifications page
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["notifications"].tap()
        
        // Assert the title of the current page is Notifications
        let pageTitle = app.navigationBars["Notifications"].staticTexts["Notifications"]
        XCTAssertTrue(pageTitle.waitForExistence(timeout: 10), "Page title is not Notification Preferences")
    }
    
    func testPreferences() {
        // start app
        let app = XCUIApplication()
        app.launch()
        app.buttons["Login"].tap()
        
        // go to profile page
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Contact Photo"].tap()
        
        // Go to notification preferences page
        app.staticTexts["Notification preferences "].tap()
        
        // assert the page title is Notification Preferences
        let pageTitle = app.navigationBars["Notification Preferences"].staticTexts["Notification Preferences"]
        XCTAssertTrue(pageTitle.waitForExistence(timeout: 10), "Page title is not Notification Preferences")
    }
}

