//
//  OnboardingData.swift
//  try
//
//  Created by Diego Arroyo on 17/10/24.
//

import SwiftUI

struct OnboardingData: View {
    @State private var name: String = ""
    @State private var sex: String = ""
    @State private var bloodType: String = ""
    @Binding var currentOnboardingView: Int
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false

    var body: some View {
        VStack {

            Spacer()
                .frame(height: 50)

            Spacer()
                .frame(height: 50)

            VStack(alignment: .leading) {
                Text("Your essential information")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 15)
                    .frame(maxWidth: .infinity)

                HStack {
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    Spacer()
                }
                Spacer()
                    .frame(height: 30)
                VStack(spacing: 15) {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Enter your name", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.horizontal)
                    .frame(height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(
                            Color.gray, lineWidth: 1))

                    HStack {
                        Text("Sex")
                        Spacer()
                        TextField("Enter your sex", text: $sex)  // Campo para el sexo
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.horizontal)
                    .frame(height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(
                            Color.gray, lineWidth: 1))

                    HStack {
                        Text("Birth Date")
                        Spacer()
                        TextField("Enter your blood type", text: $bloodType)  // Campo para el tipo de sangre
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.horizontal)
                    .frame(height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(
                            Color.gray, lineWidth: 1))
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 40)

            Spacer()

            Button(action: {
                currentOnboardingView = 6
                hasSeenOnboarding = true
            }) {
                Text("Start")
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
    OnboardingData(currentOnboardingView: .constant(5))
}
