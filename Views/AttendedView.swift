//
//  ContentView.swift
//  Encore
//
//  Created by Toyin on 03/07/2026.
//

import SwiftUI
import SwiftData

struct AttendedView: View {
    @Query private var shows: [Show]
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        
        NavigationStack{
            List(shows) { show in
                Text(show.artistName)
            }
            .navigationTitle("Attended")
            .toolbar{
                Button("Add show!",
                       systemImage: "plus"
                ){
                    modelContext.insert(Show (artistName: "Foo Fighters", venueName: "California", city: "San Francisco", date: .now, status: .attended),
                    )
                }
            }
        }
        
    }
}

#Preview {
    AttendedView()
        .modelContainer(for: Show.self, inMemory: true)
}
