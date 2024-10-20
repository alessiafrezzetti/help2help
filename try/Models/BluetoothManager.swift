import CoreBluetooth
import CoreLocation

class BluetoothManager: NSObject, ObservableObject, CBPeripheralManagerDelegate,
    CBCentralManagerDelegate, CBPeripheralDelegate, CLLocationManagerDelegate
{

    var peripheralManager: CBPeripheralManager?
    var centralManager: CBCentralManager?
    var locationManager: CLLocationManager?
    var locationCharacteristic: CBMutableCharacteristic?
    var discoveredPeripheral: CBPeripheral?

    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var sosMessage: String = ""
    var isBluetoothReady = false
    var notificationManager: NotificationManager?

    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        centralManager = CBCentralManager(delegate: self, queue: nil)
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        startScanningForPeripherals()
    }

    func advertiseSOS() {
        guard isBluetoothReady else {
            print("Bluetooth not ready to transmit.")
            return
        }

        let locationServiceUUID = CBUUID(string: "1234")
        let locationCharacteristicUUID = CBUUID(string: "5678")

        let fullName = UserDefaults.standard.string(forKey: "fullName") ?? "Unknown"
        let dateOfBirthString = UserDefaults.standard.string(forKey: "dateOfBirth") ?? "Unknown"
        let sex = UserDefaults.standard.string(forKey: "sex") ?? "Unknown"
        let h2hMessage = UserDefaults.standard.string(forKey: "h2hMessage") ?? "No message"

        let sosMessage =
        """
        H2H ALERT!
        Name: \(fullName)
        Date of Birth: \(dateOfBirthString)
        Sex: \(sex)
        Message: \(h2hMessage)
        Coordinates: \(latitude), \(longitude)
        """

        let sosData = sosMessage.data(using: .utf8)

        locationCharacteristic = CBMutableCharacteristic(
            type: locationCharacteristicUUID,
            properties: .read,
            value: sosData,
            permissions: .readable
        )

        let sosService = CBMutableService(type: locationServiceUUID, primary: true)
        sosService.characteristics = [locationCharacteristic!]
        peripheralManager?.add(sosService)

        if peripheralManager?.state == .poweredOn {
            peripheralManager?.startAdvertising([
                CBAdvertisementDataServiceUUIDsKey: [locationServiceUUID],
                CBAdvertisementDataLocalNameKey: "SOS",
            ])
            print("Transmitting SOS with details:\n\(sosMessage)")
        } else {
            print("Bluetooth not ready to advertise.")
        }
    }


    func startScanningForPeripherals() {
        guard isBluetoothReady else {
            print("Bluetooth not ready to scan.")
            return
        }

        let options = [
            CBCentralManagerScanOptionAllowDuplicatesKey: NSNumber(value: true)
        ]

        if centralManager?.state == .poweredOn {
            centralManager?.scanForPeripherals(
                withServices: [CBUUID(string: "1234")], options: options)
            print("Scanning nearby peripherals...")
        } else {
            print("Bluetooth not ready to scan.")
        }
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Central Manager ready to scan.")
            isBluetoothReady = true
            startScanningForPeripherals()
        case .poweredOff:
            print("Bluetooth turned off.")
            isBluetoothReady = false
        case .resetting:
            print("Bluetooth status is resetting.")
            isBluetoothReady = false
        case .unauthorized:
            print("Bluetooth services not allowed.")
            isBluetoothReady = false
        case .unsupported:
            print("Bluetooth not supported.")
            isBluetoothReady = false
        case .unknown:
            print("Unknown Bluetooth status.")
            isBluetoothReady = false
        @unknown default:
            print("Unknown status.")
        }
    }

    func locationManager(
        _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            print("Updated location: \(latitude), \(longitude)")
        }
    }

    func locationManager(
        _ manager: CLLocationManager, didFailWithError error: Error
    ) {
        print("Error getting location: \(error.localizedDescription)")
    }

    func centralManager(
        _ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
        advertisementData: [String: Any], rssi RSSI: NSNumber
    ) {
        discoveredPeripheral = peripheral
        centralManager?.stopScan()
        centralManager?.connect(peripheral, options: nil)
    }

    func centralManager(
        _ central: CBCentralManager, didConnect peripheral: CBPeripheral
    ) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: "1234")])
    }

    func peripheral(
        _ peripheral: CBPeripheral, didDiscoverServices error: Error?
    ) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(
                [CBUUID(string: "5678")], for: service)
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverCharacteristicsFor service: CBService, error: Error?
    ) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == CBUUID(string: "5678") {
                peripheral.readValue(for: characteristic)
            }
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didUpdateValueFor characteristic: CBCharacteristic, error: Error?
    ) {
        if let error = error {
            print(
                "Error while reading the characteristic: \(error.localizedDescription)"
            )
            return
        }

        if let sosData = characteristic.value,
            let sosMessage = String(data: sosData, encoding: .utf8)
        {
            self.sosMessage = sosMessage
            print("Received SOS message: \(sosMessage)")

            notificationManager?.showLocalNotification(sosMessage: sosMessage)
        } else {
            print("No data received.")
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didModifyServices invalidatedServices: [CBService]
    ) {
        print("Services modified in the periphereal: \(invalidatedServices)")

        peripheral.discoverServices([CBUUID(string: "1234")])

        for service in invalidatedServices {
            print("Modified service: \(service.uuid.uuidString)")
        }
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            print("Peripheral Manager ready to transmit.")
            isBluetoothReady = true
        default:
            print("Bluetooth not available to advertise.")
            isBluetoothReady = false
        }
    }
}
