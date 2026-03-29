//
//  BookStoreStrategistApp.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 12.03.2026..
//

import SwiftUI

@main
struct BookStoreStrategistApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            ContentView(salesViewModel: .preview)
            #else
            MacContentView()
            #endif
        }
    }
}
