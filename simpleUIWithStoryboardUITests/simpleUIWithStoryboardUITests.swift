//
//  simpleUIWithStoryboardUITests.swift
//  simpleUIWithStoryboardUITests
//
//  Created by Sunil Dutt on 30/09/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import XCTest

class simpleUIWithStoryboardUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["UserName"]
        usernameTextField.tap()
        usernameTextField.typeText("hari")
        
        let passwordTextField = app.textFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText("hari")
        app.buttons["Login"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.tap()

        
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        
        let prevButton = app.buttons["Previous"]
        prevButton.tap()
        prevButton.tap()
        prevButton.tap()
        prevButton.tap()
        prevButton.tap()
                        
        
    }
    
}
