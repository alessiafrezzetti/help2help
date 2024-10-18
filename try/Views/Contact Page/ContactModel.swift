//
//  ContactModel.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//


import Foundation
import SwiftUI

struct Contact: Identifiable {
    var id = UUID()
    
    var name : String
    var surname : String
    var favouriteColor : Color
    
    
    
}
/*identifiable--> it becomes powerful--> to be identifiable it needs an ID


var id = UUID()*/
