//
//  PasswordStrengthIndicatorTests 2.swift
//  
//
//  Created by Pajaziti Labinot on 13.12.23..
//

import XCTest
@testable import PasswordStrengthIndicator

final class PasswordStrengthIndicatorTests_2: XCTestCase {

    func testPasswordStrengthNone() {
        let password = "weak"
        XCTAssertEqual(password.calculateStrength(), .weak, "Password strength should be weak")
    }

    func testPasswordStrengthWeak() {
        let password = "Abcdef" // Weak password, no special characters
        XCTAssertEqual(password.calculateStrength(), .medium, "Password strength should be none")
    }

    func testPasswordStrengthMedium() {
        let password = "Abcdef!" // Medium password, has uppercase, lowercase, and special character
        XCTAssertEqual(password.calculateStrength(), .strong, "Password strength should be strong with up 6")
    }

    func testPasswordStrengthStrong() {
        let password = "Abcdef123!" // Strong password, has uppercase, lowercase, special character, and number
        XCTAssertEqual(password.calculateStrength(), .strong, "Password strength should be strong")
    }

    func testPasswordWithSpace() {
        let password = "Abc def123!" // Password containing space
        XCTAssertEqual(password.calculateStrength(), .none, "Password with space should have strength none")
    }

    func testPasswordEmpty() {
        let password = "" // Empty password
        XCTAssertEqual(password.calculateStrength(), .none, "Empty password should have strength none")
    }
}

