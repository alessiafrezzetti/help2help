import SwiftUI
import Contacts

struct AddContacts: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var isContactAdded: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                addContact()
            }) {
                Text("Add Contact")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()

            if isContactAdded {
                Text("Contact Added Successfully!")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }

    private func addContact() {
        let contact = CNMutableContact()
        contact.givenName = firstName
        contact.familyName = lastName

        let phone = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: phoneNumber))
        contact.phoneNumbers = [phone]

        let email = CNLabeledValue(label: CNLabelHome, value: email as NSString)
        contact.emailAddresses = [email]

        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)

        do {
            try store.execute(saveRequest)
            isContactAdded = true
            clearFields()
        } catch {
            print("Failed to save the contact: \(error)")
        }
    }

    private func clearFields() {
        firstName = ""
        lastName = ""
        phoneNumber = ""
        email = ""
    }
}

struct ContactPage_Previews: PreviewProvider {
    static var previews: some View {
        AddContacts()
    }
}
