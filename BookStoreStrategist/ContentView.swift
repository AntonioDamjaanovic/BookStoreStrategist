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
                Section {
                    NavigationLink {
                        BookSalesView(salesViewModel: salesViewModel)
                    } label: {
                        SimpleBookSalesView(salesViewModel: salesViewModel)
                    }
                }
                
                Section {
                    NavigationLink {
                        SalesByWeekdayView(salesViewModel: salesViewModel)
                    } label: {
                        SimpleSalesByWeekdayView(salesViewModel: salesViewModel)
                    }
                }
            }
            .navigationTitle("Your Book Store Stats")
        }
    }
}

#Preview {
    ContentView(salesViewModel: .preview)
}
