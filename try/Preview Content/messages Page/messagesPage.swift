import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isReceived: Bool // True per i messaggi ricevuti, false per quelli inviati
}

struct messagesPage: View {
    @State private var chats: [Chat] = [
        Chat(personName: "Mario Rossi", lastMessage: "I'm in danger, please call the cops.", profileImage: "person.fill"),
        Chat(personName: "Luca Verdi", lastMessage: "I need help, this is my location...", profileImage: "person.fill"),
        Chat(personName: "Giulia Bianchi", lastMessage: "This message has benn sent through the H2H app. I need help.", profileImage: "person.fill")
    ]
    
    var body: some View {
        
            List(chats) { chat in
                NavigationLink(destination: ChatDetailView(chat: chat)) {
                   
                    
                        
                        HStack {
                            
                            Image(systemName: chat.profileImage)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading) {
                                Text(chat.personName)
                                    .font(.headline)
                                Text(chat.lastMessage)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                            }
                           
                        }
                    }
                }
           
            .navigationTitle("Your H2H people")
        }
    }


struct ChatDetailView: View {
    var chat: Chat
    
    @State private var chats: [Chat] = [
        Chat(personName: "Mario Rossi", lastMessage: "I'm in danger, please call the cops.", profileImage: "person.fill")]
    
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "hello", isReceived:true)
        
      /*  ChatMessage(text: "Come stai?", isReceived: true),
        ChatMessage(text: "Sto bene, grazie! E tu?", isReceived: false)*/
    ]
    @State private var messageText: String = ""
    @State private var keyboardHeight: CGFloat = 0 // Altezza della tastiera

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    ForEach(messages) { message in
                        VStack {
                            Text(chat.personName)
                                .bold()
                                .padding(.bottom, 10)
                            Text(chat.lastMessage)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .maximum(0, 350), alignment: .leading)
                                   
                        }
                        
                    }
                }
            }
            
            /* HStack {
             TextField("Inserisci messaggio", text: $messageText)
             .textFieldStyle(RoundedBorderTextFieldStyle())
             .frame(minHeight: 30)
             
             Button(action: sendMessage) {
             Text("Invia")
             .padding()
             .background(Color.blue)
             .foregroundColor(.white)
             .cornerRadius(8)
             }
             }
             .padding()
             .padding(.bottom, keyboardHeight)
             .animation(.easeOut(duration: 0.16), value: keyboardHeight)
             }
             .padding()
             .navigationTitle(chat.personName)
             .onAppear {
             startObservingKeyboard()
             }
             .onDisappear {
             stopObservingKeyboard()
             }
             }
             
             // Funzione per inviare un messaggio
             func sendMessage() {
             guard !messageText.isEmpty else { return }
             let newMessage = ChatMessage(text: messageText, isReceived: false)
             messages.append(newMessage)
             messageText = ""
             }
             
             func startObservingKeyboard() {
             NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
             if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
             self.keyboardHeight = keyboardFrame.height
             }
             }
             
             NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
             self.keyboardHeight = 0
             }
             }
             
             func stopObservingKeyboard() {
             NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
             NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
             }
             }*/
        }
    }
    }


struct ChatMessages: Identifiable {
    let id = UUID()
    let text: String
    let isReceived: Bool
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        messagesPage()
    }
}
