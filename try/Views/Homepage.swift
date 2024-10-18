//
//  Homepage.swift
//  try
//
//  Created by Diego Arroyo on 17/10/24.
//

import SwiftUI

struct Homepage: View {
    @Binding var currentOnboardingView: Int
    @StateObject var bluetoothManager = BluetoothManager()
    var notificationManager = NotificationManager()
    @State var colorButton: Color = .black
    @State private var isLongPressing = false
    @State private var showAlert = false
    @State private var recording = false
    @State private var tapped = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var holdProgress: CGFloat = 0.0
    @State private var timer: Timer? = nil

    var body: some View {
        NavigationStack {
            VStack {
                if bluetoothManager.latitude != 0.0
                    && bluetoothManager.longitude != 0.0
                {
                    Text(
                        "Coordinates: \(bluetoothManager.latitude), \(bluetoothManager.longitude)"
                    )
                } else {
                    Text("Getting location...")
                }
                Spacer()
                    .frame(height: 50)
                Button(action: {
                    bluetoothManager.advertiseSOS()
                }) {
                    Circle()
                        .fill(
                            recording
                                ? Color.red
                                : (isLongPressing
                                    ? colorButton.opacity(0.8) : colorButton)
                        )
                        .scaleEffect(buttonScale)
                        .shadow(radius: 20)
                        .frame(width: 300, height: 300)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    if !isLongPressing {
                                        startLongPressFeedback()
                                    }
                                }
                                .onEnded { _ in
                                    endLongPressFeedback()
                                }
                        )
                }

                Text("hold to be helped")
                    .foregroundStyle(.black)
                    .font(.system(size: 20))
                    .padding(.top, 60)

                if !bluetoothManager.sosMessage.isEmpty {
                    Text("SOS message received: \(bluetoothManager.sosMessage)")
                        .foregroundColor(.red)
                        .padding(.top, 20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsPage().environmentObject(bluetoothManager)) {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .padding(0)
    }

    func startLongPressFeedback() {
        isLongPressing = true
        colorButton = .red
        holdProgress = 0.0

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
            _ in
            if holdProgress < 1.0 {
                holdProgress += 0.1
                withAnimation(.linear(duration: 0.1)) {
                    buttonScale = 1.0 + holdProgress * 0.3
                }
            } else {
                endLongPressFeedback()
            }

        }

    }

    func endLongPressFeedback() {
        timer?.invalidate()
        timer = nil
        isLongPressing = false
        holdProgress = 0.0

        showAlert = true
        recording = true

        withAnimation(.easeOut(duration: 0.2)) {
            buttonScale = 1.0
        }
    }

}

#Preview {
    Homepage(currentOnboardingView: .constant(6))
}
