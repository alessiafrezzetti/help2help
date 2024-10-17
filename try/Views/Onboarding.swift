//
//  Onboarding.swift
//  try
//
//  Created by Diego Arroyo on 17/10/24.
//

import SwiftUI

struct Onboarding: View {
    @Binding var currentOnboardingView: Int

    var body: some View {
        NavigationStack {
            Spacer()
                .frame(height: 50)
            VStack {
                Text("h2h")
                    .font(.system(size: 72, weight: .bold))
                    .bold()
                Text("help to be helped")
                    .font(.system(size: 32, weight: .medium))
                    .padding(.bottom, 30)
                Text(
                    "h2h helps you send emergency alerts to nearby people and trusted contacts."
                )
                .font(.system(size: 16))
                .padding(.horizontal, 40)
                Spacer()

                Button(action: {
                    currentOnboardingView = 2
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 50)
                }
            }
            .padding(.top, 200)
        }
        .statusBar(hidden: false)
    }
}

#Preview {
    Onboarding(currentOnboardingView: .constant(1))
}
