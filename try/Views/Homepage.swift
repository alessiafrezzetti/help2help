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
    
    var body: some View {
        VStack {
            if bluetoothManager.latitude != 0.0
                && bluetoothManager.longitude != 0.0
            {
                Text(
                    "Coordenadas: \(bluetoothManager.latitude), \(bluetoothManager.longitude)"
                )
            } else {
                Text("Obteniendo ubicación...")
            }

            Button(action: {
                bluetoothManager.advertiseSOS()
            }) {
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.red)
                    .shadow(radius: 10)
                    .padding(60)
            }

            Text("hold to be helped")
                .foregroundStyle(.black)
                .font(.system(size: 20))
                .padding(.top, 60)

            // Mostrar mensajes SOS recibidos
            if !bluetoothManager.sosMessage.isEmpty {
                Text("Mensaje SOS recibido: \(bluetoothManager.sosMessage)")
                    .foregroundColor(.red)
                    .padding(.top, 20)
            }
        }
    }
}

#Preview {
    Homepage(currentOnboardingView: .constant(6))
}


