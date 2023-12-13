import SwiftUI

public struct PasswordStrengthView: View {
    @Binding var password: String

    public init(password: Binding<String>) {
        self._password = password
    }

    public var body: some View {
        VStack(alignment: .leading) {
            if password.containsSpacesBetweenLetters {
                Text("Password should not contain spaces")
                    .font(.footnote.bold())
            }
            ProgressBar(passwordStrength: calculateStrength(password))
                .frame(height: 10)
        }
    }
        
    private func calculateStrength(_ password: String) -> PasswordStrengthColor {
        return password.calculateStrength() // Using extension method directly
    }
}
