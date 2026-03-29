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
    @State private var rawSelectedDate: Date? = nil
    
    @Environment(\.calendar) var calendar
    
    var selectedDateValue: (day: Date, sales: Int)? {
        if let rawSelectedDate {
            return salesViewModel.salesByWeek.first {
                let startOfWeek = $0.day
                let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? Date()
                
                return (startOfWeek...endOfWeek).contains(rawSelectedDate)
            }
        } else {
            return nil
        }
    }
    
    var body: some View {
        Chart {
            ForEach(salesViewModel.salesByWeek, id: \.day) { saleDate in
                BarMark(x: .value("Weeek", saleDate.day, unit: .weekOfYear),
                        y: .value("Sales", saleDate.sales))
                .foregroundStyle(Color.blue.gradient)
                .opacity(selectedDateValue?.day == nil || selectedDateValue?.day == saleDate.day ? 1 : 0.5)
            }
            
            if let rawSelectedDate {
                RuleMark(x: .value("Selected Date", rawSelectedDate, unit: .day))
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .zIndex(-1)
                    .annotation(position: .top, spacing: 0, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        selectionPopover
                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
    }
    
    @ViewBuilder
    var selectionPopover: some View {
        if let selectedDateValue {
            VStack {
                Text(selectedDateValue.day.formatted(.dateTime.month().day()))
                Text("\(selectedDateValue.sales) sales")
                    .bold()
                    .foregroundStyle(.blue)
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: .blue, radius: 2)
            }
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
