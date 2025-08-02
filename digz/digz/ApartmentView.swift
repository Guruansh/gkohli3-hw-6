//
//  digzApp.swift
//  digz
//
//  Created by Guruansh  Kohli  on 8/2/25.
//
import SwiftUI
import SwiftData
import CoreLocation
import MapKit

struct ApartmentView: View {
    // Bindable step
    @Bindable var apartment: Apartment
    @State private var region: MKCoordinateRegion

    init(apartment: Apartment) {
        self._apartment = Bindable(apartment)
        self._region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: apartment.latitude,
                longitude: apartment.longitude
            ),
            latitudinalMeters: 500,
            longitudinalMeters: 500
        ))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 4) {
                    Text("Title")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Title", text: $apartment.title)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                }

                // Rent
                VStack(alignment: .leading, spacing: 4) {
                    Text("Rent")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField(
                        "Rent",
                        value: $apartment.rent,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                }

                // Square Feet
                VStack(alignment: .leading, spacing: 4) {
                    Text("Square Feet")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField(
                        "Sqft",
                        value: $apartment.sqft,
                        format: .number
                    )
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                }

                // Address
                VStack(alignment: .leading, spacing: 4) {
                    Text("Address")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Address", text: $apartment.address)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                }

                // Phone number
                VStack(alignment: .leading, spacing: 4) {
                    Text("Phone")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Phone Number", text: $apartment.phoneNumber)
                        .keyboardType(.phonePad)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                }

                // Notes
                VStack(alignment: .leading, spacing: 4) {
                    Text("Notes")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextEditor(text: $apartment.notes)
                        .frame(height: 100)
                        .padding(4)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                }

                // Date added
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date Added")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(apartment.dateAdded.formatted(date: .long, time: .shortened))
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                }

                // Map
                VStack(alignment: .leading, spacing: 4) {
                    Text("Map")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Map(initialPosition: .region(region)) {
                        Marker(
                            apartment.address,
                            coordinate: CLLocationCoordinate2D(
                                latitude: apartment.latitude,
                                longitude: apartment.longitude
                            )
                        )
                    }
                    .frame(height: 200)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let sample = Apartment(
        title: "Rush Rhees",
        rent: 86000,
        sqft: 65000,
        address: "720 library road",
        latitude: 43.1283,
        longitude: 77.6289,
        notes: "cool library.",
        phoneNumber: "585-123-4567",
        dateAdded: Date(),
        order: 0
    )
    ApartmentView(apartment: sample)
}
