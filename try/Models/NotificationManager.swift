//
//  NotificationManager.swift
//  try
//
//  Created by Diego Arroyo on 15/10/24.
//

import SwiftUI
import UserNotifications

class NotificationManager {

    // Solicitar permisos de notificaciones
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error al solicitar permiso de notificaciones: \(error.localizedDescription)")
                return
            }

            if granted {
                print("Permiso de notificaciones concedido")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Permiso de notificaciones denegado")
            }
        }
    }

    // Mostrar notificación local cuando se recibe un SOS
    func showLocalNotification(sosMessage: String) {
        let content = UNMutableNotificationContent()
        content.title = "Alerta de SOS"
        content.body = "Alerta: usuario cercano necesita ayuda. Mensaje: \(sosMessage)"
        content.sound = UNNotificationSound.default

        // Crear una solicitud de notificación con un trigger inmediato
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)

        // Añadir la notificación al centro de notificaciones
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error al mostrar la notificación local: \(error.localizedDescription)")
            }
        }
    }


}
