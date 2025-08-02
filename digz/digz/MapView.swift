//
//  MapView.swift
//  FindMe
//
//  Created by Arthur Roolfs on 10/22/24.
//

import SwiftUI
import MapKit


struct MapView: View {
    
    var address: String
    var coord: CLLocationCoordinate2D
    var showMarker = true
    
    var body: some View {
        
        ZStack {
            Map(initialPosition: .region(
                MKCoordinateRegion(center: coord, latitudinalMeters: 50, longitudinalMeters: 50))) {
                    if showMarker {
                        Marker(address, coordinate: coord)
                    }
                }
        }
    }
}

#Preview {
    MapView(
        address: "123 Elmgove",
        coord: CLLocationCoordinate2D(latitude: 43.16103, longitude: -77.6109219),
        showMarker: true
    )
}
