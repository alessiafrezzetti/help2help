import SwiftUI

struct faqPage: View {
    // Dati dell'utente
    @State private var name = "Diego Arroyo"
    @State private var dateOfBirth = "17 Aug 2002"
    @State private var sex = "Male"
    @State private var bloodType = "O+"
    @State private var phoneNumber = "+39 329 8939837"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Name")
                            .foregroundColor(.gray)
                        Spacer()
                        TextField("Name", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Date of Birth")
                            .foregroundColor(.gray)
                        Spacer()
                        TextField("Date of Birth", text: $dateOfBirth)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Sex")
                            .foregroundColor(.gray)
                        Spacer()
                        TextField("Sex", text: $sex)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Blood Type")
                            .foregroundColor(.gray)
                        Spacer()
                        TextField("Blood Type", text: $bloodType)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Phone Number")
                            .foregroundColor(.gray)
                        Spacer()
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    faqPage()
}
