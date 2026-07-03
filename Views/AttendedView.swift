//
//  ContentView.swift
//  Encore
//
//  Created by Toyin on 03/07/2026.
//

import SwiftUI

struct AttendedView: View {
    @State private var shows: [Show] = []
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
                shows
                  .append(Show.init(artistName: "testName", venueName: "testVenue", city: "testCity", date: Date(), status: .attended))
                }
            }
        }
        
    }
}

#Preview {
    AttendedView()
}
