//
//  CalculatorPresenterTests.swift
//  FinancialAppTests
//
//  Created by Mehmet Can Seyhan on 2021-05-22.
//

import XCTest
@testable import FinancialApp

class CalculatorPresenterTests: XCTestCase {
    
    var sut: CalculatorPresenter!

    override func setUpWithError() throws {
        sut = CalculatorPresenter()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // test
    // given
    // expect

    func testAnnualReturnLabelTextColor_givenResultIsProfitable_expectSystemGreen() {
        // given
        let result = DCAResult(currentValue: 0,
                               investmentAmount: 0,
                               gain: 0,
                               yield: 0,
                               annualReturn: 0,
                               isProfitable: true)
        // when
        let presentation = sut.getPresentation(result: result)
        // then
        XCTAssertEqual(presentation.annualReturnLabelTextColor, UIColor.systemGreen)
    }
    
    func testYieldLabelTextColor_givenResultIsProfitable_expectSystemGreen() {
        // given
        let result = DCAResult(currentValue: 0,
                               investmentAmount: 0,
                               gain: 0,
                               yield: 0,
                               annualReturn: 0,
                               isProfitable: true)
        // when
        let presentation = sut.getPresentation(result: result)
        // then
        XCTAssertEqual(presentation.yieldLabelTextColor, UIColor.systemGreen)
    }
    
    
    func testAnnualReturnLabelTextColor_givenResultIsNotProfitable_expectSystemRed() {
        // given
        let result = DCAResult(currentValue: 0,
                               investmentAmount: 0,
                               gain: 0,
                               yield: 0,
                               annualReturn: 0,
                               isProfitable: false)
        // when
        let presentation = sut.getPresentation(result: result)
        // then
        XCTAssertEqual(presentation.annualReturnLabelTextColor, UIColor.systemRed)
    }
    
    func testYieldLabelTextColor_givenResultIsNotProfitable_expectSystemRed() {
        // given
        let result = DCAResult(currentValue: 0,
                               investmentAmount: 0,
                               gain: 0,
                               yield: 0,
                               annualReturn: 0,
                               isProfitable: false)
        // when
        let presentation = sut.getPresentation(result: result)
        // then
        XCTAssertEqual(presentation.yieldLabelTextColor, UIColor.systemRed)
    }
    
    func testYieldLabel_expectBrackets() {
        // given
        let openBracket: Character = "("
        let closeBracket: Character = ")"
        let result = DCAResult(currentValue: 0,
                               investmentAmount: 0,
                               gain: 0,
                               yield: 0.25,
                               annualReturn: 0,
                               isProfitable: false)
        // when
        let presentation = sut.getPresentation(result: result)
        // then
        XCTAssertEqual(presentation.yield.first, openBracket)
        XCTAssertEqual(presentation.yield.last, closeBracket)
    }

}

