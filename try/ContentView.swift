//
//  ContentView.swift
//  try
//
//  Created by alessia frezzetti on 04/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .imageScale(.large)
                    .shadow(radius: 10)
                    .foregroundStyle(.red)
                Text("HELP Us")
                    .foregroundStyle(.white)
                    .font(.system(size: 90))
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
