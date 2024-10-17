import SwiftUI

struct ContentVieww: View {
    @State var colorButton: Color = .black
    @State private var isLongPressing = false
    @State private var showAlert = false
    @State private var recording = false
    @State private var tapped = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var holdProgress: CGFloat = 0.0  // Progreso del long press

    // Temporizador para actualizar el feedback visual durante el long press
    @State private var timer: Timer? = nil

    var body: some View {
        NavigationView {
            VStack {
                Circle()
                    .fill(
                        recording
                            ? Color.red
                            : (isLongPressing
                                ? colorButton.opacity(0.8) : colorButton)
                    )
                    .scaleEffect(buttonScale)  // Cambia el tamaño del círculo
                    .shadow(radius: 20)
                    .frame(width: 300, height: 300)
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !isLongPressing {
                                startLongPressFeedback()  // Comienza el feedback visual
                            }
                        }
                        .onEnded { _ in
                            endLongPressFeedback()  // Termina el long press
                        }
                    )

                Text("Hold it to get help")
                    .foregroundStyle(.black)
                    .font(.system(size: 20))
                    .padding(.top, 60)
            }
            .toolbar {
                         ToolbarItem(placement: .navigationBarTrailing) {
                             NavigationLink(destination: SettingsPage()) {
                                 Image(systemName: "gearshape.fill")
                                     .foregroundStyle(.black)
                             }
                         }
                     }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("H2H"),
                    message: Text(
                        "An emergency is going to be sent. Click 'Cancel' to STOP IT."
                    ),
                    dismissButton: .cancel {
                        // Acción cuando el usuario presiona "Cancel"
                        recording = false
                        withAnimation(.easeOut(duration: 0.5)) {
                            colorButton = .black
                            buttonScale = 1.0
                        }
                    }
                )
            }
        }
    }

    // Iniciar el feedback visual cuando comienza el long press
    func startLongPressFeedback() {
        isLongPressing = true
        colorButton = .red
        holdProgress = 0.0

        // Iniciar el temporizador para actualizar el feedback visual
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if holdProgress < 1.0 {
                holdProgress += 0.1
                withAnimation(.linear(duration: 0.1)) {
                    buttonScale = 1.0 + holdProgress * 0.3  // Incremento progresivo del tamaño
                }
            } else {
                endLongPressFeedback()  // Finaliza el long press cuando el progreso llega a 1.0
            }
        }
    }

    // Finalizar el feedback visual cuando se suelta el botón
    func endLongPressFeedback() {
        timer?.invalidate()  // Detiene el temporizador
        timer = nil
        isLongPressing = false
        holdProgress = 0.0

        // Mostrar alerta y restablecer el círculo a su tamaño original
        showAlert = true
        recording = true
        withAnimation(.easeOut(duration: 0.2)) {
            buttonScale = 1.0  // Restablece el tamaño del círculo
        }
    }
}

#Preview {
    ContentVieww()
}
