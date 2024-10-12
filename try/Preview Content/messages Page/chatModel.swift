//
//  chatModel.swift
//  try
//
//  Created by alessia frezzetti on 11/10/24.
//
import SwiftUI
import Foundation

struct Chat: Identifiable {
    let id = UUID()
    let personName: String
    let lastMessage: String
    let profileImage: String
}



