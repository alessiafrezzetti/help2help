import SwiftUI
import CoreLocation

struct OnboardingLocation: View {
    @Binding var currentOnboardingView: Int
    let locationManager = CLLocationManager()

    var body: some View {
        VStack {

            Spacer()
                .frame(height: 50)
            
            Spacer()
                .frame(height: 50)

            VStack(alignment: .leading) {
                Text("Allow location services")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity)
                
                HStack {
                    Spacer()
                    Image(systemName: "location.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                    Spacer()
                }
                Spacer()
                    .frame(height: 30)
                Text(
                    "In order to send your location to nearby devices when you are in danger, we need access to your location."
                )
                .font(.system(size: 16))
                Spacer().frame(height: 10)
                Text("We will never store your location.")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 40)
            
            Spacer()

            Button(action: {
                locationManager.requestWhenInUseAuthorization()
                currentOnboardingView = 4
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
    OnboardingLocation(currentOnboardingView: .constant(3))
}
