//
//  ContentView.swift
//  digz
//
//  Created by Guruansh  Kohli  on 8/2/25.
//
import SwiftUI
import SwiftData
import CoreLocation

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Apartment.order) private var apartments: [Apartment]
    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(apartments) { apt in
                    // making the rows tappable and going to thee ApartmentView
                    NavigationLink(value: apt) {
                        HStack(spacing: 12) {
                            MapView(
                                address: apt.address,
                                coord: CLLocationCoordinate2D(latitude: apt.latitude, longitude: apt.longitude),
                                showMarker: false
                            )
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            // apartment info
                            VStack(alignment: .leading, spacing: 4) {
                                Text(apt.title)
                                    .font(.headline)
                                HStack {
                                    Text("$\(apt.rent, specifier: "%.0f") /mo")
                                    Text("•")
                                    Text("\(apt.sqft) sqft")
                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete(perform: deleteApartments)
                .onMove(perform: moveApartments)
            }
            .navigationDestination(for: Apartment.self) { apt in
                ApartmentView(apartment: apt)
            }
            //title
            .navigationTitle("Digz")
            .toolbar {
                // edit button
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                // add button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddApartmentView()
            }
        }
    }

    // function to delete apartments
    private func deleteApartments(at offsets: IndexSet) {
        for idx in offsets {
            modelContext.delete(apartments[idx])
        }
        try? modelContext.save()
    }

    // custom sort
    private func moveApartments(from source: IndexSet, to destination: Int) {
        var revised = apartments
        revised.move(fromOffsets: source, toOffset: destination)
        for (index, apt) in revised.enumerated() {
            apt.order = index
        }
        try? modelContext.save()
    }
}

#Preview {
    ContentView()
}
