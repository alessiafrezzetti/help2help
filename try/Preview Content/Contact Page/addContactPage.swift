//
//  addContactPage.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//

import SwiftUI

struct addContactPage: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}



struct addContactButton: View {
    @State private var showSheet = false
    var body: some View {
        VStack{
            
            Button(action: {
                
                showSheet.toggle() //toggle btw true and flse the boo
                
            }) //action
            {
                
                Image(systemName: "plus.circle.fill")
                
            } //the way it looks
            
            
        }
        .sheet(isPresented: $showSheet, content: {
            addContactPage()
        })
    }
}
#Preview {
    addContactPage()
}
