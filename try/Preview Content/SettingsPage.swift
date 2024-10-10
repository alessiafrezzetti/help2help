//
//  SettingsPage.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//

import SwiftUI

struct SettingsPage: View {
    
    var body: some View {
        NavigationStack{
            
            
            VStack{
                
                
                NavigationLink(destination: faqPage()) {
                    VStack{
                        Image(systemName: "info.circle.fill")
                        Text ("Faq")
                    }
                }
                    
                NavigationLink(destination: ContactPage()) {
                        VStack{
                            VStack{
                                Image(systemName: "phone.fill")
                                Text ("Contacts")
                                
                            }.padding(.top, 100)
                        }
                    }
                NavigationLink(destination: messagesPage()) {
                        VStack{
                            VStack{
                                Image(systemName: "message.fill")
                                Text ("Messages")
                                
                            }
                            .padding(.top, 100)
                        }
                    }
                    
                }
              
        }
    }
}
        
struct InfoPage: View {
    var body: some View {
        
        Text ("hello")
        
    }
    
}
#Preview {
    SettingsPage()
}
