import SwiftUI

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

    
    private func calculateStrength(_ password: String) -> Double {
        var strength = 0.0

        // Check for lowercase characters
        let lowercaseSet = CharacterSet.lowercaseLetters
        let lowercaseRange = password.rangeOfCharacter(from: lowercaseSet)
        if lowercaseRange != nil {
            strength += 0.5
        }

        // Check for uppercase characters
        let uppercaseSet = CharacterSet.uppercaseLetters
        let uppercaseRange = password.rangeOfCharacter(from: uppercaseSet)
        if uppercaseRange != nil {
            strength += 0.5
        }

        // Check for special characters
        let specialCharacterSet = CharacterSet.punctuationCharacters
        let specialCharactersRange = password.rangeOfCharacter(from: specialCharacterSet)
        if specialCharactersRange != nil {
            strength += 1.0
        }

        return min(strength, 2.0) // Cap strength at 2.0
    }
}

struct ProgressBar: View {
    var passwordStrength: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .cornerRadius(5.0)

                Rectangle()
                    .frame(width: min(CGFloat(self.passwordStrength) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(self.getPasswordStrengthColor())
                    .cornerRadius(5.0)
                    .animation(.linear)
            }
        }
    }

    private func getPasswordStrengthColor() -> Color {
        // Modify this logic to set colors based on the password strength
        if passwordStrength < 0.3 {
            return Color.red
        } else if passwordStrength < 0.7 {
            return Color.yellow
        } else {
            return Color.green
        }
    }
}
