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
            return 1.0
        case .weak:
            return 0.3
        case .medium:
            return 0.7
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
        
        if password.contains(" ") {
            return .none // Contains spaces between letters
        }
        
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$"
        let strength = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isStrong = strength.evaluate(with: trimmedPassword)
        
        if isStrong {
            return .strong
        } else if length == 6 {
            return .medium
        } else {
            return length > 0 ? .weak : .none // Check if there are any letters, else none
        }
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
