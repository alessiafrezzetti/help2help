//
//  tryApp.swift
//  try
//
//  Created by alessia frezzetti on 04/10/24.
//

import SwiftUI

@main
struct tryApp: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
