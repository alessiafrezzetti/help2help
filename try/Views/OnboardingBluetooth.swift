import SwiftUI
import CoreBluetooth

struct OnboardingBluetooth: View {
    @Binding var currentOnboardingView: Int
    @State private var bluetoothManager: CBPeripheralManager?

    var body: some View {
        VStack {

            Spacer()
                .frame(height: 50)
            

            Spacer()
                .frame(height: 50)

            VStack(alignment: .leading) {
                Text("Allow Bluetooth access")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 15)
                    .frame(maxWidth: .infinity)
                
                HStack {
                    Spacer()
                    Image(systemName: "person.2.wave.2.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    Spacer()
                }
                Spacer()
                    .frame(height: 30)
                Text(
                    "We use Bluetooth to send emergency signals to nearby devices. Make sure to always have Bluetooth on in case of an emergency."
                )
                .font(.system(size: 16))
            }
            .padding(.horizontal, 40)
            
            Spacer()

            Button(action: {
                // Solicitar acceso a Bluetooth al presionar el botón
                bluetoothManager = CBPeripheralManager(delegate: BluetoothDelegate(), queue: nil)
                currentOnboardingView = 5
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

class BluetoothDelegate: NSObject, CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            print("Bluetooth está activado.")
        case .poweredOff:
            print("Bluetooth está desactivado.")
        case .unauthorized:
            print("La app no tiene permiso para usar Bluetooth.")
        case .unsupported:
            print("Este dispositivo no soporta Bluetooth.")
        default:
            print("Estado desconocido de Bluetooth.")
        }
    }
}

#Preview {
    OnboardingBluetooth(currentOnboardingView: .constant(4))
}
