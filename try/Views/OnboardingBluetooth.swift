import CoreBluetooth
import SwiftUI

struct OnboardingBluetooth: View {
    @Binding var currentOnboardingView: Int
    @State private var bluetoothManager: CBPeripheralManager?
    @State private var permissionHandled = false

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
                bluetoothManager = CBPeripheralManager(
                    delegate: BluetoothDelegate(
                        permissionHandled: $permissionHandled
                    ), queue: nil)
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            .disabled(permissionHandled)  // Desactivar botón si el permiso ya fue gestionado

            Spacer()
                .frame(height: 50)
        }
        .padding(.top, 100)
        .onChange(of: permissionHandled) { newValue in
            if newValue {
                currentOnboardingView = 5  // Cambiar de pantalla solo si el permiso ya se ha gestionado
            }
        }
    }
}

class BluetoothDelegate: NSObject, CBPeripheralManagerDelegate {
    @Binding var permissionHandled: Bool

    init(permissionHandled: Binding<Bool>) {
        _permissionHandled = permissionHandled
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            print("Bluetooth está activado.")
            permissionHandled = true  // El usuario ha gestionado el permiso
        case .poweredOff, .unauthorized, .unsupported:
            print("El usuario ha rechazado o no puede usar Bluetooth.")
            permissionHandled = true  // El permiso ha sido gestionado de alguna manera
        default:
            print("Estado desconocido de Bluetooth.")
            permissionHandled = true  // Gestionamos cualquier otro estado
        }
    }
}

#Preview {
    OnboardingBluetooth(currentOnboardingView: .constant(4))
}
