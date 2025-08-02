//
//  digzApp.swift
//  digz
//
//  Created by Guruansh  Kohli  on 8/2/25.
//
import SwiftUI
import SwiftData
import CoreLocation

struct AddApartmentView: View {
    
    @Query(sort: \Apartment.order) private var apartments: [Apartment]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    // Apartment input fields
    @State private var title: String = ""
    @State private var rent: String = ""
    @State private var sqft: String = ""
    @State private var address: String = ""
    @State private var phoneNumber: String = ""
    @State private var notes: String = ""

    @StateObject private var locationVM = LocationVM()

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    // Title
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Title")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField("Enter title", text: $title)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                    }

                    // Rent
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Rent")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField("Enter rent", text: $rent)
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
                        TextField("Enter sqft", text: $sqft)
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
                        TextField("Enter address", text: $address)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                    }

                    // Phone Number
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Phone Number")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField("Enter phone number", text: $phoneNumber)
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
                        TextEditor(text: $notes)
                            .frame(height: 100)
                            .padding(4)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                    }

                    // Location
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Location")
                            .font(.caption)
                            .foregroundColor(.gray)
                        VStack(spacing: 8) {
                            if let loc = locationVM.location {
                                Text("Lat: \(loc.coordinate.latitude)")
                                Text("Lon: \(loc.coordinate.longitude)")
                                MapView(
                                    address: address,
                                    coord: loc.coordinate
                                )
                                .frame(height: 150)
                                .cornerRadius(8)
                            }
                            Button(locationVM.enabled ? "Stop Location" : "Start Location") {
                                if locationVM.enabled {
                                    locationVM.stop()
                                } else {
                                    locationVM.start()
                                }
                            }
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor.opacity(0.1))
                            .cornerRadius(8)
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Add Apartment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Cancel button
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                // Save button
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Button("Save") {
                            let apt = Apartment(
                                title: title,
                                rent: Double(rent) ?? 0,
                                sqft: Int(sqft) ?? 0,
                                address: address,
                                latitude: locationVM.location?.coordinate.latitude ?? 0,
                                longitude: locationVM.location?.coordinate.longitude ?? 0,
                                notes: notes,
                                phoneNumber: phoneNumber,
                                dateAdded: .now,
                                order: apartments.count
                            )
                            modelContext.insert(apt)
                            try? modelContext.save()
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    AddApartmentView()
}
