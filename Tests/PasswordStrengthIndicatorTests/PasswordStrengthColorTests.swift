//
//  PasswordStrengthColorTests.swift
//  
//
//  Created by Pajaziti Labinot on 13.12.23..
//

import XCTest
import SwiftUI
@testable import PasswordStrengthIndicator

final class PasswordStrengthColorTests: XCTestCase {

    func testColorForNone() {
        let strengthColor: PasswordStrengthColor = .none
        XCTAssertEqual(strengthColor.color, Color.gray.opacity(0.2), "Color for none should be gray with opacity 0.2")
    }

    func testColorForWeak() {
        let strengthColor: PasswordStrengthColor = .weak
        XCTAssertEqual(strengthColor.color, Color.red, "Color for weak should be red")
    }

    func testColorForMedium() {
        let strengthColor: PasswordStrengthColor = .medium
        XCTAssertEqual(strengthColor.color, Color.yellow, "Color for medium should be yellow")
    }

    func testColorForStrong() {
        let strengthColor: PasswordStrengthColor = .strong
        XCTAssertEqual(strengthColor.color, Color.green, "Color for strong should be green")
    }

    func testProgressForNone() {
        let strengthColor: PasswordStrengthColor = .none
        XCTAssertEqual(strengthColor.progress, 0.0, "Progress for none should be 0.0")
    }

    func testProgressForWeak() {
        let strengthColor: PasswordStrengthColor = .weak
        XCTAssertEqual(strengthColor.progress, 0.3, "Progress for weak should be 0.3")
    }

    func testProgressForMedium() {
        let strengthColor: PasswordStrengthColor = .medium
        XCTAssertEqual(strengthColor.progress, 0.7, "Progress for medium should be 0.7")
    }

    func testProgressForStrong() {
        let strengthColor: PasswordStrengthColor = .strong
        XCTAssertEqual(strengthColor.progress, 1.0, "Progress for strong should be 1.0")
    }
}

