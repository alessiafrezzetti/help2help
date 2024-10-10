//
//  faqPage.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//

import SwiftUI

struct faqPage: View {
    @State private var showSheet = false
   /* var aDifferentLearner: Learner = Learner(name: "diego", surname: "arroyo", favouriteColor: .yellow)*/
    
    var question: [Question] = [ Question(title: "In case of robbery", body: "Ultrices augue morbi curabitur eu nam, tellus pulvinar maecenas. Est nulla iaculis, potenti natoque tempus pulvinar himenaeos nullam. Quam hac et mollis feugiat quisque penatibus. Eu purus commodo efficitur pretium nullam mauris. Condimentum laoreet leo commodo ligula tincidunt mauris eu quisque. Leo justo velit convallis penatibus malesuada. Natoque mollis a suscipit dapibus arcu fermentum nulla"),
                                 Question(title: "In case of robbery", body: "Lorem ipsum odor amet, consectetuer adipiscing elit. Facilisis porta nam taciti eleifend sed interdum laoreet mauris. Sodales class efficitur fringilla at vestibulum. Dapibus taciti lobortis nunc a nunc habitasse massa dapibus."),
                                 Question(title: "In case of robbery", body: "Dapibus taciti lobortis nunc a nunc habitasse massa dapibus. Diam inceptos aptent non, nunc sit porttitor volutpat. Ullamcorper auctor congue ex magnis, eget taciti suspendisse. Potenti dui tristique praesent mus gravida felis ullamcorper sapien dignissim.")
    ]
    var body: some View {
        NavigationStack{
            
            NavigationView{
                VStack{
                    Text("What should I do?")
                        .font(.title).fontWeight(.bold)
                    
                    List {
                        ForEach(question) {question in
                            faqRow(faq1: question)
                        }
                    }
                }
            }
           
        }
    }

}

#Preview {
    faqPage()
}
