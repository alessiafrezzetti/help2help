//
//  tryButton.swift
//  try
//
//  Created by alessia frezzetti on 16/10/24.
//

import SwiftUI

struct tryButton: View {
    @State var HPress = false
    @State var fb = false
    @GestureState var topG = false
    
    var body: some View {
        ZStack{
            
            Circle().frame(width: 120, height: 120)
                .foregroundStyle(.background)
                .shadow(color: .black.opacity(0.1), radius: 10, x:10, y:10)
                .shadow(color: .white.opacity(0.1), radius: 10, x:-20, y:-20)
            
            
            Circle()
                .stroke(lineWidth: 7)
                .frame(width: 120, height: 120)
                .foregroundStyle(.background)
            
            Circle()
                .stroke(lineWidth: 5.5)
                .frame(width: 105, height: 105)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .black.opacity(0.06), .gray.opacity(0.01), .black.opacity(0.06)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            
            
            if topG {
                
                
                
            }
            Image (systemName: "hand.raised.fill" )
            
            
        }
        .gesture(LongPressGesture().updating($topG){ cstate, gstate, trantion in gstate = cstate
        }
            .onEnded({
                value in
                HPress.toggle()
                
            })
        )
    }
}

#Preview {
    tryButton()
}
