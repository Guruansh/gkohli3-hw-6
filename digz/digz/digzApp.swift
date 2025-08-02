//
//  digzApp.swift
//  digz
//
//  Created by Guruansh  Kohli  on 8/2/25.
//

import SwiftUI
import SwiftData

@main
struct digzApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            // container
                .modelContainer(for: [Apartment.self])
        }
    }
}
