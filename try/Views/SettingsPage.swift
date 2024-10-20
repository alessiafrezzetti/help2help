//
//  SettingsPage.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//

import SwiftUI

struct SettingsPage: View {
    @AppStorage("fullName") private var fullName: String = ""
    @AppStorage("dateOfBirth") private var dateOfBirthString: String = Date().description
    @AppStorage("sex") private var sex: String = "Male"
    @AppStorage("bio") private var bio: String = ""
    @AppStorage("h2hMessage") private var h2hMessage: String = "I don't feel safe, please reach me or call the cops."
    
    @FocusState private var isH2HMessageFocused: Bool
    @EnvironmentObject var bluetoothManager: BluetoothManager
    
    private var dateOfBirth: Date {
        get {
            return ISO8601DateFormatter().date(from: dateOfBirthString) ?? Date()
        }
    }
    
    private func updateDateOfBirth(to newValue: Date) {
        dateOfBirthString = ISO8601DateFormatter().string(from: newValue)
    }

    var body: some View {
        VStack {
            Form {
                Section("Personal Information") {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Enter your name", text: $fullName)
                            .multilineTextAlignment(.trailing)
                            .submitLabel(.done)
                    }

                    DatePicker(
                        "Date of Birth",
                        selection: Binding(
                            get: { dateOfBirth },
                            set: { newValue in
                                updateDateOfBirth(to: newValue)
                            }
                        ),
                        displayedComponents: [.date]
                    )

                    Picker("Sex", selection: $sex) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                }

                Section(
                    header: Text("Your h2h message"),
                    footer: {
                            if bluetoothManager.latitude != 0.0 && bluetoothManager.longitude != 0.0 {
                                Text("These are your coordinates: \(bluetoothManager.latitude), \(bluetoothManager.longitude). We will add them to your h2h message automatically.")
                            } else {
                                Text("We are currently retrieving your coordinates...")
                            }
                        }()
                ) {
                    ZStack(alignment: .topLeading) {
                        if bio.isEmpty {
                            Text(
                                "I don't feel safe, please reach me or call the cops."
                            )
                            .foregroundStyle(.tertiary)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                        }
                        TextEditor(text: $bio)
                            .frame(height: 100)
                            .focused($isH2HMessageFocused)
                    }
                }

                Section {
                    NavigationLink(destination: ContactPage()) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("Trusted Contacts")
                        }
                    }
                    NavigationLink(destination: FAQPage()) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                            Text("FAQ")
                        }
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .toolbar {
            if isH2HMessageFocused {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isH2HMessageFocused = false
                    }) {
                        Text("Done")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsPage().environmentObject(BluetoothManager())
}
