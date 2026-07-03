//
//  Show.swift
//  Encore
//
//  Created by Toyin on 03/07/2026.
//


import Foundation

enum ShowStatus {
    case attended
    case upcoming
    
}

struct Show: Identifiable {
    var artistName: String
    var venueName: String
    var city: String
    var date: Date
    var status: ShowStatus
    
    let id = UUID()
}
