//
//  WeekySalesChartView.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 15.03.2026..
//

import SwiftUI
import Charts

struct WeekySalesChartView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        Chart(salesViewModel.salesByWeek, id: \.day) { saleDate in
            BarMark(x: .value("Weeek", saleDate.day, unit: .weekOfYear),
                    y: .value("Sales", saleDate.sales))
            .foregroundStyle(Color.blue.gradient)
            
        }
    }
}

struct PlainSalesChartView: View {
    
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Weeek", sale.saleDate, unit: .weekOfYear),
                    y: .value("Sales", sale.quantity))
            .foregroundStyle(Color.blue.gradient)
            
        }
    }
}

#Preview("Weekly Sales Chart") {
    WeekySalesChartView(salesViewModel: SalesViewModel.preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

#Preview("Plain Sales Chart") {
    PlainSalesChartView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
