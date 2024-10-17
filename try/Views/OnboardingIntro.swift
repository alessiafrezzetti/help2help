//
//  OnboardingIntro.swift
//  try
//
//  Created by Diego Arroyo on 17/10/24.
//

import SwiftUI

struct OnboardingIntro: View {
    @State private var isAnimating = false
    @Binding var currentOnboardingView: Int

    var body: some View {
        VStack {

            Spacer()
                .frame(height: 50)

            ZStack {
                Circle()
                    .fill(Color.primary)
                    .frame(width: 180, height: 180)
                    .scaleEffect(isAnimating ? 1.03 : 0.98)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true)
                    ) {
                        isAnimating = true  // Activa la animación al aparecer
                    }
                }
            }

            Spacer()
                .frame(height: 50)

            VStack(alignment: .leading) {
                Text(
                    "If you feel unsafe, just press the button. Your coordinates and a message will be sent to nearby devices through Bluetooth. The message will also be sent to your trusted contacts via SMS."
                )
                .font(.system(size: 16))
                .padding(.horizontal, 40)
                Spacer().frame(height: 10)
                Text("No internet connection is needed.")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 40)
            }

            Spacer()

            Button(action: {
                currentOnboardingView = 3
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }

            Spacer()
                .frame(height: 50)
        }
        .padding(.top, 100)
    }
}

#Preview {
    OnboardingIntro(currentOnboardingView: .constant(2))
}
