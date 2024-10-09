//
//  ContentView.swift
//  try
//
//  Created by alessia frezzetti on 04/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var pressed = false
    
    var body: some View {
        NavigationView{
            
            
            VStack {
                Button(action: {
                    
                }) //action
                {
                    
                    Circle()
                        .imageScale(.medium)
                        .shadow(radius: 10)
                        .foregroundStyle(.black)
                        .padding(60)
                    
                } //the way it looks
                
                
                 
                
                Text("help to be helped")
                .foregroundStyle(.black)
                    .font(.system(size: 20))
                    .padding(.top, 60)
            }
            .toolbar{
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        
                    }) //action
                    { Image(systemName: "info.circle")
                        
                    } //the way it looks
                    
                    
                    .foregroundColor(.black)
                
                }
                
                
            }
            }
            
        
    }
}


#Preview {
    ContentView()
}
