//
//  PasswordStrengthColor.swift
//  
//
//  Created by Pajaziti Labinot on 13.12.23..
//

import SwiftUI

 enum PasswordStrengthColor {
    case none, weak, medium, strong

    var color: Color {
        switch self {
        case .none:
            return Color.gray.opacity(0.2)
        case .weak:
            return Color.red
        case .medium:
            return Color.yellow
        case .strong:
            return Color.green
        }
    }

    var progress: Double {
        switch self {
        case .none:
            return 0.0
        case .weak:
            return 0.3
        case .medium:
            return 0.7
        case .strong:
            return 1.0
        }
    }
}
