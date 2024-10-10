//
//  faqRow.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//

import SwiftUI

import SwiftUI

struct faqRow: View {
    
    var faq1: Question = Question(title: "alessia", body: "frezzetti")
    
    
   
    var body: some View {
        VStack (alignment: .leading, spacing: 6) {
            

            Text(faq1.title)
                .font(.title2)
                .bold()
               
            
            
            Text(faq1.body)
               
                
        }
    }
}

#Preview {
    faqRow()
}
