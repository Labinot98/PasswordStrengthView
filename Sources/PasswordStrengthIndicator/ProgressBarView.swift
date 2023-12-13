//
//  File.swift
//  
//
//  Created by Pajaziti Labinot on 13.12.23..
//

import SwiftUI

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
