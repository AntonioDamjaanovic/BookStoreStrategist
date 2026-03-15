//
//  MonthlySalesChartView.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 15.03.2026..
//

import SwiftUI
import Charts

struct MonthlySalesChartView: View {
    
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Month", sale.saleDate, unit: .month),
                    y: .value("Sales", sale.quantity))
        }
    }
}

#Preview {
    MonthlySalesChartView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
