//
//  ShowRowView.swift
//  Encore
//
//  Created by Toyin on 03/07/2026.
//

import SwiftUI
import SwiftData

struct ShowRowView: View {
    let show: Show
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(show.artistName)
                .font(.headline)
            
            HStack(spacing: 4){
                Text(show.venueName)
                Text("-")
                Text(show.city)
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            HStack{
                Text(show.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                if let rating = show.rating{
                    Spacer()
                    HStack(spacing: 2){
                        ForEach(1 ... 5, id: \.self){
                            star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .font(.caption2)
                                .foregroundStyle(star <= rating ? Color.yellow : Color.secondary)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    ShowRowView(show: Show(artistName: "Tee", venueName: "Tee Venue", city: "City Tee", date: .now, status: .attended))
}

