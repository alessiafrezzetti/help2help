import SwiftUI

struct FAQPage: View {
    var body: some View {
        VStack(alignment: .leading) {
            List {
                FAQItem(question: "What does the SOS button do?", answer: "The SOS button sends a distress signal to nearby devices using Bluetooth. It also sends your coordinates if you have enabled location services.")
                
                FAQItem(question: "How can I customize my emergency message?", answer: "Go to the settings page and update your H2H message. This message will be sent with your location in case of an emergency.")
                
                FAQItem(question: "Does the app store my location?", answer: "No, your location is only used to send your coordinates to nearby devices. We do not store your location.")
                
                FAQItem(question: "How do I enable Bluetooth permissions?", answer: "When you first launch the app, you will be prompted to enable Bluetooth. If you missed this, you can enable it in your device settings.")
                
                FAQItem(question: "Can I use the app without internet access?", answer: "Yes! The app works offline by using Bluetooth to send your SOS signal to nearby devices.")
                
                FAQItem(question: "What happens if my location is unavailable?", answer: "If your location cannot be determined, the app will still send an SOS signal, but without the location data.")
            }
        }
        .background(Color(.systemGray6))
        .navigationTitle("Frequently Asked Questions")
    }
}

struct FAQItem: View {
    let question: String
    let answer: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question)
                .font(.headline)
            Text(answer)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    FAQPage()
}
