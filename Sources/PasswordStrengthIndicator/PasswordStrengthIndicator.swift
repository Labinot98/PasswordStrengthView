import SwiftUI

public enum PasswordStrengthColor {
    case none, weak, medium, strong

    var color: Color {
        switch self {
        case .none:
            return Color.gray.opacity(0.0) // Transparent if no letters
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

public struct PasswordStrengthView: View {
    @Binding var password: String

    public init(password: Binding<String>) {
        self._password = password
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text("Password Strength:")
                .font(.headline)
                .foregroundColor(.black)

            ProgressBar(passwordStrength: calculateStrength(password))
                .frame(height: 10)
        }
    }

    private func calculateStrength(_ password: String) -> PasswordStrengthColor {
        let length = password.count
        if length >= 6 {
            if password.rangeOfCharacter(from: .uppercaseLetters) != nil && password.rangeOfCharacter(from: .punctuationCharacters) != nil {
                return .strong
            } else if password.rangeOfCharacter(from: .uppercaseLetters) != nil {
                return .medium
            } else if password.rangeOfCharacter(from: .lowercaseLetters) != nil && password.rangeOfCharacter(from: .punctuationCharacters) != nil {
                return .medium
            }
        }
        return length > 0 ? .weak : .none // Check if there are any letters, else none
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
