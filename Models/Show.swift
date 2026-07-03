//
//  Show.swift
//  Encore
//
//  Created by Toyin on 03/07/2026.
//


import Foundation
import SwiftData
import SwiftUI

enum ShowStatus: String, Codable, CaseIterable {
    case attended
    case upcoming
    
}

@Model
final class Show: Identifiable {
    var artistName: String
    var venueName: String
    var city: String
    var date: Date
    var status: ShowStatus
    
    var rating: Int?
    var notes: String?
    var setlist: [String]
    var createdAt: Date
    
    init(artistName: String, venueName: String, city: String, date: Date, status: ShowStatus) {
        self.artistName = artistName
        self.venueName = venueName
        self.city = city
        self.date = date
        self.status = status
        self.rating = nil
        self.notes = nil
        self.setlist = []
        self.createdAt = .now
    }
}



#Preview {
    // In-memory container for previews
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Show.self, configurations: config)

   
    let sample = Show(artistName: "Tee", venueName: "Abuja", city: "FCT", date: .now, status: .attended)
    container.mainContext.insert(sample)

    return Text(sample.artistName)
        .modelContainer(container)
}
