//
//  Apartment.swift
//  digz
//
//  Created by Guruansh  Kohli  on 8/2/25.
//
import Foundation
import SwiftData

@Model

// model for step 1
class Apartment {
    var title: String
    var rent: Double
    var sqft: Int
    var address: String
    var latitude: Double
    var longitude: Double
    var notes: String
    var phoneNumber: String
    var dateAdded: Date
    var order: Int

    init(
        title: String,
        rent: Double,
        sqft: Int,
        address: String,
        latitude: Double,
        longitude: Double,
        notes: String = "",
        phoneNumber: String = "",
        dateAdded: Date = .now,
        order: Int = 0
    ) {
        self.title = title
        self.rent = rent
        self.sqft = sqft
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.notes = notes
        self.phoneNumber = phoneNumber
        self.dateAdded = dateAdded
        self.order = order
    }
}

