import SwiftUI

public enum PasswordStrengthColor {
    case weak, medium, strong

    var color: Color {
        switch self {
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
            ProgressBar(passwordStrength: calculateStrength(password))
                .frame(height: 10)
    }

    private func calculateStrength(_ password: String) -> PasswordStrengthColor {
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
                    .foregroundColor(Color.gray.opacity(0.3))
                    .cornerRadius(5.0)

                Rectangle()
                    .frame(width: self.getWidth(from: geometry.size.width), height: geometry.size.height)
                    .foregroundColor(self.passwordStrength.color)
                    .cornerRadius(5.0)
                    .animation(.linear)
            }
        }
    }

    private func getWidth(from totalWidth: CGFloat) -> CGFloat {
        switch passwordStrength {
        case .weak:
            return totalWidth * 0.3
        case .medium:
            return totalWidth * 0.6
        case .strong:
            return totalWidth * 1.0
        }
    }
}
