//
//  LocationModel.swift
//  try
//
//  Created by Diego Arroyo on 09/10/24.
//

import CoreBluetooth
import CoreLocation

class BluetoothManager: NSObject, ObservableObject, CBPeripheralManagerDelegate, CBCentralManagerDelegate, CBPeripheralDelegate, CLLocationManagerDelegate {
    
    var peripheralManager: CBPeripheralManager?
    var centralManager: CBCentralManager?
    var locationManager: CLLocationManager?
    var locationCharacteristic: CBMutableCharacteristic?
    var discoveredPeripheral: CBPeripheral?
    
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var sosMessage: String = ""
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        centralManager = CBCentralManager(delegate: self, queue: nil)
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    // Iniciar escaneo y publicidad de SOS
    func startBluetoothOperations() {
        // Iniciar escaneo (Central)
        startScanningForPeripherals()
        
        // Obtener ubicación y comenzar a publicitar (Peripheral)
        locationManager?.requestLocation()
    }
    
    // Publicitar como Peripheral
    func advertiseSOS(latitude: Double, longitude: Double) {
        let locationServiceUUID = CBUUID(string: "1234")
        let locationCharacteristicUUID = CBUUID(string: "5678")
        
        let sosData = "SOS \(latitude), \(longitude)".data(using: .utf8)
        
        locationCharacteristic = CBMutableCharacteristic(
            type: locationCharacteristicUUID,
            properties: .read,
            value: sosData,
            permissions: .readable
        )
        
        let sosService = CBMutableService(type: locationServiceUUID, primary: true)
        sosService.characteristics = [locationCharacteristic!]
        peripheralManager?.add(sosService)
        
        // Publicitar con Bluetooth
        peripheralManager?.startAdvertising([
            CBAdvertisementDataServiceUUIDsKey: [locationServiceUUID],
            CBAdvertisementDataLocalNameKey: "SOS"
        ])
        
        print("Transmitiendo SOS: \(latitude), \(longitude)")
    }
    
    // Escanear como Central
    func startScanningForPeripherals() {
        centralManager?.scanForPeripherals(withServices: [CBUUID(string: "1234")], options: nil)
        print("Escaneando periféricos cercanos...")
    }
    
    // Delegate requerido para CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Central Manager está encendido y listo para escanear.")
        case .poweredOff:
            print("Bluetooth está apagado.")
        case .resetting:
            print("El estado de Bluetooth está siendo reseteado.")
        case .unauthorized:
            print("La aplicación no tiene permiso para usar Bluetooth.")
        case .unsupported:
            print("Este dispositivo no soporta Bluetooth.")
        case .unknown:
            print("El estado de Bluetooth es desconocido.")
        @unknown default:
            print("Estado desconocido.")
        }
    }
    
    // Delegate para manejar la actualización de ubicación
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            advertiseSOS(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error obteniendo la ubicación: \(error.localizedDescription)")
    }
    
    // Delegate para Central: cuando se descubre un periférico
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        discoveredPeripheral = peripheral
        centralManager?.stopScan()
        centralManager?.connect(peripheral, options: nil)
    }
    
    // Delegate para Central: cuando se conecta a un periférico
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: "1234")])
    }
    
    // Delegate para Central: descubrir servicios
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics([CBUUID(string: "5678")], for: service)
        }
    }
    
    // Delegate para Central: cuando se recibe el valor de la característica
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == CBUUID(string: "5678") {
                peripheral.readValue(for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let sosData = characteristic.value, let sosMessage = String(data: sosData, encoding: .utf8) {
            self.sosMessage = sosMessage
            print("Mensaje SOS recibido: \(sosMessage)")
        }
    }
    
    // Delegate para Peripheral Manager: cuando se actualiza el estado
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            print("Peripheral Manager listo para transmitir.")
        } else {
            print("Bluetooth no está disponible.")
        }
    }
}
