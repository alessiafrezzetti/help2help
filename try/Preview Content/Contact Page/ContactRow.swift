//
//  ContactRow.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//

import SwiftUI

struct ContactRow: View {
    
    var contact1: Contact = Contact(name: "alessia", surname: "frezzetti", favouriteColor: .blue)
    
    
   
    var body: some View {
        HStack {
            
            Image(systemName: "person.fill")
                .foregroundStyle(contact1.favouriteColor)
            Text(contact1.name + " " + contact1.surname)
            
            
            
        }
    }
}

#Preview {
    ContactRow()
}
