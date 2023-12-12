import SwiftUI

public enum PasswordStrengthColor {
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
            return 0.25 // Adjust these values based on your criteria
        case .medium:
            return 0.5 // Adjust these values based on your criteria
        case .strong:
            return 1.0
        }
    }
}

public struct PasswordStrengthView: View {
    @Binding var password: String

    public init(password: Binding<String>) {
        self._password = password
    }

    public var body: some View {
        VStack(alignment: .leading) {
            if password.containsSpacesBetweenLetters {
                Text("Password should not contain spaces between letters")
                    .foregroundColor(.red)
                    .padding(.bottom, 5)
            }
            ProgressBar(passwordStrength: calculateStrength(password))
                .frame(height: 10)
        }
    }

    private func calculateStrength(_ password: String) -> PasswordStrengthColor {
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let length = trimmedPassword.count

        // Check for spaces between letters
        if password.containsSpacesBetweenLetters {
            return .none
        }

        // Check against regex patterns for password strength
        if length >= 8 {
            if NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$").evaluate(with: trimmedPassword) {
                return .weak
            } else if NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$").evaluate(with: trimmedPassword) {
                return .medium
            } else if NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$").evaluate(with: trimmedPassword) {
                return .medium
            } else if NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,10}$").evaluate(with: trimmedPassword) {
                return .strong
            }
        }
        return length > 0 ? .none : .none // Check if there are any letters, else none
    }

}

struct ProgressBar: View {
    var passwordStrength: PasswordStrengthColor

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width * CGFloat(self.passwordStrength.progress), height: geometry.size.height)
                    .foregroundColor(self.passwordStrength.color)
                    .cornerRadius(5.0)
                    .animation(.linear)
            }
        }
    }
}

extension String {
    var containsSpacesBetweenLetters: Bool {
        return self.contains(" ")
    }
}
