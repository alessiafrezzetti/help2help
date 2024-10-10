//
//  ContactPage.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//

import SwiftUI

        struct ContactPage: View {
            @State private var showSheet = false
           /* var aDifferentLearner: Learner = Learner(name: "diego", surname: "arroyo", favouriteColor: .yellow)*/
            
            var learners: [Contact] = [ Contact (name: "alessia", surname: "frezzetti", favouriteColor: .gray),
                                        Contact(name: "diego", surname: "arroyo", favouriteColor: .orange),
                                        Contact(name: "alessandro", surname: "alvigi", favouriteColor: .cyan)
            ]
            var body: some View {
                NavigationStack{
                    NavigationView{
                    
                        List {
                            ForEach(learners) {contact in
                                ContactRow(contact1: contact)
                            }
                        }
                        .toolbar{
                            ToolbarItem(placement: .topBarTrailing)
                            {
                                addContactButton()
                                    
                                }
                                
                            
                        }
                    }.navigationTitle("Contacts")
                    
                   
                }
            }
        }
 

#Preview {
    ContactPage()
}
