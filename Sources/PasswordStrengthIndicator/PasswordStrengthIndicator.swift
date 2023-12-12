import SwiftUI

public enum PasswordStrengthColor {
    case none, weak, medium, strong

    var color: Color {
        switch self {
        case .none:
            return Color.gray.opacity(0.3)
        case .weak:
            return Color.red
        case .medium:
            return Color.yellow
        case .strong:
            return Color.green
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
        guard !password.isEmpty else { return .none }

        let passwordRegex = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}"

        let strength = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return strength.evaluate(with: password) ? .strong : .weak
    }
}

struct ProgressBar: View {
    var passwordStrength: PasswordStrengthColor

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .foregroundColor(passwordStrength.color)
                    .cornerRadius(5.0)
                    .opacity(passwordStrength == .none ? 0.3 : 1.0)
                    .animation(.linear)
            }
        }
    }
}

