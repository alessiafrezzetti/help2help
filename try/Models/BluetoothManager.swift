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
    var isBluetoothReady = false  // Estado del Bluetooth
    var notificationManager: NotificationManager? // Agregado para manejar notificaciones locales
    
    override init() {
        super.init()
        // Inicializar los administradores de Bluetooth y ubicación
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        centralManager = CBCentralManager(delegate: self, queue: nil)
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        // Inicia la obtención de ubicación y el escaneo de dispositivos
        locationManager?.requestLocation()
        startScanningForPeripherals()
    }
    
    // Verificación adicional del estado de Bluetooth antes de cualquier operación
    func advertiseSOS() {
        guard isBluetoothReady else {
            print("Bluetooth no está listo para transmitir.")
            return
        }

        let locationServiceUUID = CBUUID(string: "1234")
        let locationCharacteristicUUID = CBUUID(string: "5678")

        // Creación del mensaje SOS con latitud y longitud
        let sosData = "SOS \(latitude), \(longitude)".data(using: .utf8)

        // Característica que contiene el mensaje SOS
        locationCharacteristic = CBMutableCharacteristic(
            type: locationCharacteristicUUID,
            properties: .read,
            value: sosData,
            permissions: .readable
        )

        // Servicio de Bluetooth para transmitir la característica
        let sosService = CBMutableService(type: locationServiceUUID, primary: true)
        sosService.characteristics = [locationCharacteristic!]
        peripheralManager?.add(sosService)

        // Publicitar el mensaje SOS
        if peripheralManager?.state == .poweredOn {
            peripheralManager?.startAdvertising([
                CBAdvertisementDataServiceUUIDsKey: [locationServiceUUID],
                CBAdvertisementDataLocalNameKey: "SOS"
            ])
            print("Transmitiendo SOS: \(latitude), \(longitude)")
        } else {
            print("Bluetooth no está listo para publicitar.")
        }
    }


    // Escaneo con verificación de estado
    func startScanningForPeripherals() {
        guard isBluetoothReady else {
            print("Bluetooth no está listo para escanear.")
            return
        }

        let options = [
            CBCentralManagerScanOptionAllowDuplicatesKey: NSNumber(value: true)
        ]

        if centralManager?.state == .poweredOn {
            centralManager?.scanForPeripherals(withServices: [CBUUID(string: "1234")], options: options)
            print("Escaneando periféricos cercanos...")
        } else {
            print("Bluetooth no está listo para escanear.")
        }
    }


    
    // Actualización del estado de CBCentralManager
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Central Manager listo para escanear.")
            isBluetoothReady = true
            startScanningForPeripherals()  // Iniciar escaneo de periféricos
        case .poweredOff:
            print("Bluetooth está apagado.")
            isBluetoothReady = false
        case .resetting:
            print("El estado de Bluetooth se está reseteando.")
            isBluetoothReady = false
        case .unauthorized:
            print("Esta app no tiene permiso para usar Bluetooth.")
            isBluetoothReady = false
        case .unsupported:
            print("Este dispositivo no soporta Bluetooth.")
            isBluetoothReady = false
        case .unknown:
            print("El estado de Bluetooth es desconocido.")
            isBluetoothReady = false
        @unknown default:
            print("Estado desconocido.")
        }
    }
    
    // Actualización de ubicación
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            print("Ubicación actualizada: \(latitude), \(longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error obteniendo la localización: \(error.localizedDescription)")
    }
    
    // Descubrir periféricos cercanos
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        discoveredPeripheral = peripheral
        centralManager?.stopScan()
        centralManager?.connect(peripheral, options: nil)
    }
    
    // Conectar a periférico cercano
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: "1234")])
    }
    
    // Descubrir servicios del periférico
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics([CBUUID(string: "5678")], for: service)
        }
    }
    
    // Recibir valores de la característica SOS
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == CBUUID(string: "5678") {
                peripheral.readValue(for: characteristic)
            }
        }
    }

    // Actualizar valores recibidos
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error al leer el valor de la característica: \(error.localizedDescription)")
            return
        }

        // Proceso del mensaje SOS recibido
        if let sosData = characteristic.value, let sosMessage = String(data: sosData, encoding: .utf8) {
            self.sosMessage = sosMessage
            print("Mensaje SOS recibido: \(sosMessage)")
            
            // Inmediatamente mostrar la notificación local
            notificationManager?.showLocalNotification(sosMessage: sosMessage)
        } else {
            print("No se recibió ningún dato.")
        }
    }
    
    // Delegate que maneja cambios en los servicios del periférico
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        print("Servicios modificados en el periférico: \(invalidatedServices)")

        // Vuelve a descubrir los servicios después de la modificación
        peripheral.discoverServices([CBUUID(string: "1234")])
        
        for service in invalidatedServices {
            print("Servicio modificado: \(service.uuid.uuidString)")
        }
    }

    
    // Estado de PeripheralManager
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            print("Peripheral Manager listo para transmitir.")
            isBluetoothReady = true
        default:
            print("Bluetooth no disponible para publicidad.")
            isBluetoothReady = false
        }
    }
}
