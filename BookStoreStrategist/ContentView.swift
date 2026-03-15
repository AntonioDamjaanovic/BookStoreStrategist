//
//  ContentView.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 12.03.2026..
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var salesViewModel = SalesViewModel.preview
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    DetailBookSalesView(salesViewModel: salesViewModel)
                } label: {
                    SimpleBookSalesView(salesViewModel: salesViewModel)
                }
                
            }
            .navigationTitle("Your Book Store Stats")
        }
    }
}

#Preview {
    ContentView(salesViewModel: .preview)
}
