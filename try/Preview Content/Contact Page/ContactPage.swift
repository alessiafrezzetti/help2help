import SwiftUI



struct ContactPage: View {
    @State private var showSheet = false
    @State private var learners: [Contact] = [
        Contact(name: "alessia", surname: "frezzetti", favouriteColor: .gray),
        Contact(name: "diego", surname: "arroyo", favouriteColor: .orange),
        Contact(name: "alessandro", surname: "alvigi", favouriteColor: .cyan)
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(learners) { contact in
                    ContactRow(contact1: contact)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Contacts")
            .sheet(isPresented: $showSheet) {
                AddContactView(learners: $learners)
            }
        }
    }
}

struct AddContactView: View {
    @Binding var learners: [Contact]
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var favouriteColor: Color = .gray
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact Details")) {
                    TextField("First Name", text: $name)
                    TextField("Last Name", text: $surname)
                    ColorPicker("Favourite Color", selection: $favouriteColor)
                }
                
                Button("Add Contact") {
                    let newContact = Contact(name: name, surname: surname, favouriteColor: favouriteColor)
                    learners.append(newContact)
                    dismiss()
                }
                .disabled(name.isEmpty || surname.isEmpty)
            }
            .navigationTitle("Add Contact")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}



#Preview {
    ContactPage()
}
