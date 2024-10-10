//
//  faqRow.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//

import SwiftUI

import SwiftUI

struct chatRow: View {
    
    var chatRow1: Chat = Chat(personName: "Mario Rossi", lastMessage: "I'm in danger, please call the cops.", profileImage: "person.fill")
    
    
   
    var body: some View {
        VStack (alignment: .leading, spacing: 6) {
            

            Text(chatRow1.personName)
                .font(.title2)
                .bold()
               
            
            
            Text(chatRow1.lastMessage)
               
                
        }
    }
}
/*
struct lastMessageModel : View{
    var message1: Chat = Chat(personName: "Mario Rossi", lastMessage: "I'm in danger, please call the cops.", profileImage: "person.fill")
    
    var body: some View {
        VStack (alignment: .leading, spacing: 6) {
            
            
            Text(message1.personName)
                .font(.title2)
                .bold()
            
            
            
            Text(message1.lastMessage)
            
            
        }
    }
    
}

*/
#Preview {
    chatRow()
}
