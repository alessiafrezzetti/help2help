//
//  ContentView.swift
//  try
//
//  Created by alessia frezzetti on 04/10/24.
//

import SwiftUI

struct ContentView: View {
    // Usamos BluetoothManager para manejar ubicación y operaciones de Bluetooth
    @StateObject var bluetoothManager = BluetoothManager()

    var body: some View {
        NavigationStack {
            VStack {
                if bluetoothManager.latitude != 0.0 && bluetoothManager.longitude != 0.0 {
                    Text("Coordinates: \(bluetoothManager.latitude), \(bluetoothManager.longitude)")
                } else {
                    Text(" ")
                }

                Button(action: {
                    // Iniciar la publicidad y escaneo al presionar el botón SOS
                    bluetoothManager.startBluetoothOperations()
                }) {
                    Circle()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.red)
                        .shadow(radius: 10)
                        .padding(60)
                }
                
                Text("help to be helped")
                    .foregroundStyle(.black)
                    .font(.system(size: 20))
                    .padding(.top, 60)

                // Mostrar mensajes SOS recibidos
                if !bluetoothManager.sosMessage.isEmpty {
                    Text("SOS message from: \(bluetoothManager.sosMessage)")
                        .foregroundColor(.red)
                        .padding(.top, 20)
                }
            }

            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // Acción del botón de información
                    }) {
                        Image(systemName: "info.circle")
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
