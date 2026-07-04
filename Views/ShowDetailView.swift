//
//  ShowDetailView.swift
//  Encore
//
//  Created by Toyin on 04/07/2026.
//

import SwiftUI
import SwiftData

struct ShowDetailView: View {
    @Bindable var show: Show
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showEditSheet = false
    @State private var showDeleteAlert = false
    @State private var newSetlistEntry = ""
    var body: some View {
        List {
            Section("Show Info"){
                LabeledContent("Artist", value: show.artistName)
                LabeledContent("Venue", value: show.venueName)
                LabeledContent("City", value: show.city)
                LabeledContent("Date", value: show.date.formatted(date: .long, time: .omitted))
                LabeledContent("Status", value: show.status.rawValue.capitalized)
            }
            if show.status == .attended {
                Section("Rating"){
                    StarRatingView(rating: Binding(get: {
                        show.rating ?? 0
                    }, set: {
                        show.rating = $0 > 0 ? $0 : nil
                    })
                    )
                }
            }
            Section ("Notes"){
                if let notes = show.notes,
                    !notes.isEmpty {
                    Text(notes)
                } else {
                    Text("No notes added!")
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("Setlist"){
                if show.setlist.isEmpty{
                    Text("No songs Added")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(show.setlist.indices, id: \.self) {
                        index in
                        HStack{
                            Text("\(index + 1)")
                                .foregroundStyle(.secondary)
                                .frame(width: 28, alignment: .leading)
                            Text(show.setlist[index])
                        }
                    }
                    .onDelete{
                        indexSet in
                        show.setlist.remove(atOffsets: indexSet)
                    }
                    .onMove{
                        source, destination in
                        show.setlist.move(fromOffsets: source, toOffset: destination)
                    }
                }
                HStack{
                    TextField("Add song", text: $newSetlistEntry)
                    Button("Add"){
                        let trimmed = newSetlistEntry.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        show.setlist.append(trimmed)
                        newSetlistEntry = ""
                    }
                    .disabled(newSetlistEntry.trimmingCharacters(in: .whitespaces).isEmpty )
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction){
                Menu {
                    Button("Edit Show"){
                        showEditSheet = true
                    }
                    Divider()
                    Button("Delete Show", role: .destructive){
                        showDeleteAlert = true
                    }
                }
                label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showEditSheet){
            AddEditShowView(show: show)
        }
        .alert("Delete Show?", isPresented: $showDeleteAlert){
            Button("Delete", role: .destructive){
                modelContext.delete(show)
                dismiss()
            }
            Button("Cancel", role: .cancel){}
        } message: {
            Text("This will permanently remove \(show.artistName) from your history")
        }
    }
}

#Preview {
    ShowDetailView(show: Show(artistName: "Example Artist", venueName: "Example Venue", city: "Example City", date: Date(), status: .attended))
}
