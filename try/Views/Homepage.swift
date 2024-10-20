import SwiftUI
import UIKit

struct Homepage: View {
    @Binding var currentOnboardingView: Int
    @StateObject var bluetoothManager = BluetoothManager()
    var notificationManager = NotificationManager()
    @State private var isLongPressing = false
    @State private var recording = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var holdProgress: CGFloat = 0.0
    @State private var timer: Timer? = nil
    @State private var isButtonDisabled = false
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)

    @Environment(\.colorScheme) var colorScheme

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
                            isLongPressing ? Color.red : defaultColor()
                        )
                        .scaleEffect(buttonScale)
                        .shadow(radius: 20)
                        .frame(width: 300, height: 300)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    if !isLongPressing && !isButtonDisabled {
                                        withAnimation(.easeIn(duration: 0.9)) {
                                            startLongPressFeedback()
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    if !isButtonDisabled {
                                        withAnimation(.easeInOut(duration: 1.0))
                                        {
                                            endLongPressFeedback()
                                        }
                                    }
                                }
                        )
                }
                .disabled(isButtonDisabled)

                Text("hold to be helped")
                    .foregroundStyle(Color.accentColor)
                    .font(.system(size: 20))
                    .padding(.top, 60)

                if !bluetoothManager.sosMessage.isEmpty {
                    Text("\(bluetoothManager.sosMessage)")
                        .foregroundColor(.red)
                        .padding(.top, 20)

                    if let (latitude, longitude) = extractCoordinates(
                        from: bluetoothManager.sosMessage)
                    {
                        Link(
                            "Open in Apple Maps",
                            destination: URL(
                                string:
                                    "https://maps.apple.com/?ll=\(latitude),\(longitude)"
                            )!
                        )
                        .padding(.top, 10)
                    } else {
                        Text("Invalid coordinates in SOS message")
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: SettingsPage().environmentObject(
                            bluetoothManager)
                    ) {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.accentColor)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .padding(0)
    }

    func defaultColor() -> Color {
        return colorScheme == .dark ? .white : .black
    }

    func startLongPressFeedback() {
        isLongPressing = true
        holdProgress = 0.0

        impactFeedback.impactOccurred()

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
            _ in
            if holdProgress < 1.0 {
                holdProgress += 0.1
                withAnimation(.linear(duration: 0.1)) {
                    buttonScale = 0.95 + holdProgress * 0.3
                }
            } else {
                endLongPressFeedback()
            }
        }
    }

    func endLongPressFeedback() {
        timer?.invalidate()
        timer = nil
        withAnimation(.easeInOut(duration: 0.2)) {
            isLongPressing = false
        }
        holdProgress = 0.0
        impactFeedback.impactOccurred()

        recording = true

        withAnimation(.easeOut(duration: 0.2)) {
            buttonScale = 1.0
        }

        isButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isButtonDisabled = false
        }
    }

    func extractCoordinates(from message: String) -> (String, String)? {
        if let coordinatesRange = message.range(of: "Coordinates:") {
            let coordinatesText = message[coordinatesRange.upperBound...]
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let components = coordinatesText.split(separator: ",")

            if components.count == 2 {
                let latitud = components[0].trimmingCharacters(in: .whitespaces)
                let longitud = components[1].trimmingCharacters(
                    in: .whitespaces)
                return (latitud, longitud)
            }
        }
        return nil
    }
}

#Preview {
    Homepage(currentOnboardingView: .constant(6))
}
