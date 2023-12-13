import SwiftUI

struct PasswordStrengthView: View {
    @Binding var password: String

    init(password: Binding<String>) {
        self._password = password
    }

    var body: some View {
        VStack(alignment: .leading) {
            if password.containsSpacesBetweenLetters {
                Text("Password should not contain spaces")
                    .font(.footnote.bold())
//                    .padding(.bottom, 5)
            }
            ProgressBar(passwordStrength: calculateStrength(password))
                .frame(height: 10)
        }
    }

    private func calculateStrength(_ password: String) -> PasswordStrengthColor {
        return PasswordStrengthCalculator().calculateStrength(password)
    }
}

struct PasswordStrengthCalculator: PasswordStrengthCalculating {}
