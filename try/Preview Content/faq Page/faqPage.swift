import SwiftUI

struct faqPage: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var bio: String = ""
    @State private var date = Date()
    @State private var h2hMessage = "I don't feel safe, please reach me or call the cops."
    @State private var coordinates = "40.8367° N, 14.3022° E"
    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
             

                                        DatePicker(
                                            "Birthdate",
                                            selection: $date,
                                            displayedComponents: [.date]
                                        )
                                    }
                Section("Your h2h message") {
                    ZStack(alignment: .topLeading) {
                        // Segnaposto manuale
                        if bio.isEmpty {
                            Text("I don't feel safe, please reach me or call the cops. These are my coordinates: \(coordinates) ")
                                .foregroundStyle(.tertiary)
                                .padding(.top, 8)
                               
                        }
                        else {
//                            Text("" + "\(coordinates) ")
                        }
                        TextEditor(text: $bio)
                            .frame(height: 100) // Regola l'altezza come preferisci
                        
                        
                        
                    }
                    
                  
                    
                    
                }
                Section("These are your coordinates: \(coordinates). They will always be added to your h2h message."){
                    
                    
                }
                
                           
                                }
                                .navigationTitle("Settings")
                            }
                        }
                    }


#Preview {
    faqPage()
}
