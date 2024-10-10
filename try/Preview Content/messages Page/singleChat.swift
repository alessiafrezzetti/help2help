import SwiftUI
import Combine

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isReceived: Bool // True per i messaggi ricevuti, false per quelli inviati
}

struct singleChat: View {
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Ciao!", isReceived: true),
        ChatMessage(text: "Come stai?", isReceived: true),
        ChatMessage(text: "Sto bene, grazie!", isReceived: false)
    ]
    @State private var keyboardHeight: CGFloat = 0 // Altezza della tastiera

    var body: some View {
        VStack {
            // Lista dei messaggi
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isReceived {
                                // Messaggi ricevuti (allineati a sinistra)
                                Text(message.text)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                // Messaggi inviati (allineati a destra)
                                Spacer() // Spinge il messaggio verso destra
                                Text(message.text)
                                    .padding()
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }

            // Campo di testo e pulsante invio
            HStack {
                TextField("Inserisci messaggio", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 30)
                    .onTapGesture {
                        // Scorre in automatico quando si clicca nel campo di testo
                        scrollToBottom()
                    }

                Button(action: sendMessage) {
                    Text("Invia")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .padding(.bottom, keyboardHeight) // Sposta la vista sopra la tastiera
            .animation(.easeOut(duration: 0.16), value: keyboardHeight) // Nuovo approccio
        }
        .padding()
        .onAppear {
            // Inizia l'osservazione degli eventi della tastiera
            startObservingKeyboard()
        }
        .onDisappear {
            // Ferma l'osservazione degli eventi della tastiera
            stopObservingKeyboard()
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    // Chiude la tastiera quando si clicca fuori
                    hideKeyboard()
                }
        )
    }

    // Funzione per inviare il messaggio
    func sendMessage() {
        guard !messageText.isEmpty else { return }
        let newMessage = ChatMessage(text: messageText, isReceived: false)
        messages.append(newMessage)
        messageText = ""
        scrollToBottom()
    }

    // Funzione per far scorrere la lista verso il basso
    func scrollToBottom() {
        DispatchQueue.main.async {
            // Scroll automatico verso il basso
        }
    }

    // Inizia l'osservazione degli eventi della tastiera
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

    // Ferma l'osservazione degli eventi della tastiera
    func stopObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // Nasconde la tastiera
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        singleChat()
    }
}
