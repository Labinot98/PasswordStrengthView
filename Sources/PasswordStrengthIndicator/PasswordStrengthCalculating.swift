//
//  File.swift
//  
//
//  Created by Pajaziti Labinot on 13.12.23..
//

import Foundation


 extension String {
    func calculateStrength() -> PasswordStrengthColor {
        // Custom logic for calculating password strength
        let trimmedPassword = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let length = trimmedPassword.count
        
        if self.contains(" ") {
            return .none
        }
        
        if length >= 6 {
            if trimmedPassword.rangeOfCharacter(from: .uppercaseLetters) != nil && trimmedPassword.rangeOfCharacter(from: .punctuationCharacters) != nil {
                return .strong
            } else if trimmedPassword.rangeOfCharacter(from: .uppercaseLetters) != nil {
                return .medium
            } else if trimmedPassword.rangeOfCharacter(from: .lowercaseLetters) != nil && trimmedPassword.rangeOfCharacter(from: .punctuationCharacters) != nil {
                return .medium
            }
        }
        return length > 0 ? .weak : .none
    }
}
