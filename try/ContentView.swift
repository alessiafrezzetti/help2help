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
           /* .alert("An emergency is going to be sent. Click 'Cancel' to STOP IT", isPresented: $presentAlert, actions: { // 3
            
                
            })*/
            .alert(isPresented: $presentAlert, content: {
                
                Alert(
                      title: Text("H2H"),
                      message: Text("An emergency is going to be sent. Click 'Cancel' to STOP IT"),
                      dismissButton: .cancel()
                      
                )
            }
            )
            
            .toolbar{
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        isShowingSheet.toggle()
                        
                        
                    }) //action
                    { Image(systemName: "info.circle")
                        
                    } //the way it looks
                    .sheet(isPresented: $isShowingSheet) {
                        VStack {
                            Text("Your page")
                                .font(.title)
                                .padding(.bottom, 500)
                            
                            
                            
                            
                            Button(action: {
                            
                                
                                
                            }) //action
                            { Text("""
                                    how to act
                                """)
                            .padding(.bottom, 50)
                            }
                            
                            
                            
                            
                            Button("Dismiss",
                                   action: { isShowingSheet.toggle() })
                        }
                    }
                           .foregroundColor(.black)
                    
                }
                
                
            }
        }
        
        
            }
            
   
    }
    


#Preview {
    ContentView()
}
