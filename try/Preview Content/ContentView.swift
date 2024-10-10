//
//  ContentView.swift
//  try
//
//  Created by alessia frezzetti on 04/10/24.
//



import SwiftUI

struct ContentView: View {
    
    @State var colorButton : Color = .black
    @State var presentAlert = false
    
    @State private var isShowingSheet = false
    
    var body: some View {
        
        
        NavigationStack{
            
            NavigationView{
                VStack {
                    
                    Button(action: {
                        presentAlert = true
                        
                        colorButton = .red
                        
                        
                        
                    }) //action
                    {
                        
                        Circle()
                            .imageScale(.medium)
                            .shadow(radius: 10)
                            .foregroundStyle(colorButton)
                            .padding(60)
                        
                        
                    } //the way it looks
                    
                    
                    
                    
                    Text("press it to get help")
                        .foregroundStyle(.black)
                        .font(.system(size: 20))
                        .padding(.top, 60)
                    
                    
                }
                
            }
            
            .toolbar{
                ToolbarItem(placement: .topBarTrailing)
                {
                    NavigationLink(destination: SettingsPage()) {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                        
                    }
                    
                }
            }
        }
        /* .alert("An emergency is going to be sent. Click 'Cancel' to STOP IT", isPresented: $presentAlert, actions: { // 3
         
         
         })*/
        .alert(isPresented: $presentAlert, content: {
            
            Alert(
                title: Text("H2H"),
                message: Text("An emergency is going to be sent in 7s. To stop it press on 'Cancel'"),
                dismissButton:  .cancel()
                
            )
            
        }
               
               
        )
    }
    

        
        
        
            }
    /*struct InfoPage: View {
        
        var body: some View {
           
            ZStack {
                
                TabView{
                    Text("hello world")
                        .tabItem {
                            Image(systemName: "info.circle.fill")
                            Text ("Info")
                        }
                ContactPage()
                .tabItem {
                    Image(systemName: "phone")
                    Text ("Contacts")
                        .font(.largeTitle)
                    
                   
                        }
                    /*  Text("About")
                     .foregroundStyle(.black)
                     
                     
                     
                     Text("Contact list")
                     .foregroundStyle(.black)
                     .underline()
                     */
                    //contact list
                }
               
            }
                
        }
    }
    */


        /*  Text("About")
         .foregroundStyle(.black)
         
         
         
         Text("Contact list")
         .foregroundStyle(.black)
         .underline()
         */
        //contact list


#Preview {
    ContentView()
}
