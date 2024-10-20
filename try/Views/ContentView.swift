import SwiftUI

struct ContentView: View {
    @State private var currentOnboardingView = 1
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                if currentOnboardingView == 6 || hasSeenOnboarding {
                    Homepage(currentOnboardingView: $currentOnboardingView)
                        .transition(.move(edge: .trailing))
                } else if currentOnboardingView == 1 {
                    Onboarding(currentOnboardingView: $currentOnboardingView)
                } else if currentOnboardingView == 2 {
                    OnboardingIntro(currentOnboardingView: $currentOnboardingView)
                } else if currentOnboardingView == 3 {
                    OnboardingLocation(currentOnboardingView: $currentOnboardingView)
                } else if currentOnboardingView == 4 {
                    OnboardingBluetooth(currentOnboardingView: $currentOnboardingView)
                } else if currentOnboardingView == 5 {
                    OnboardingData(currentOnboardingView: $currentOnboardingView)
                }
            }
            .animation(.easeInOut, value: currentOnboardingView)
        }
        /*.onAppear {
            // Solicitar permiso de notificaciones al aparecer la vista
            notificationManager.requestNotificationPermission()

            // Asignar el NotificationManager a BluetoothManager
            bluetoothManager.notificationManager = notificationManager
        }*/
        .navigationBarBackButtonHidden(true)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
