//
//  SalesByWeekdayView.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 19.03.2026..
//

import SwiftUI
import Charts

struct SalesByWeekdayView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    @State private var medianSalesIsShown = true
    @State private var individualDaysAreShown = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SalesByWeekdayHeaderView(salesViewModel: salesViewModel)
            
            Chart {
                ForEach(salesViewModel.averageSalesByWeekday, id: \.number) {
                    BarMark(x: .value("Weekday", weekday(for: $0.number)),
                            y: .value("Average sales", $0.sales))
                    .foregroundStyle(Color.gray.gradient)
                    .opacity(0.3)
                    
                    RectangleMark(x: .value("Weekday", weekday(for: $0.number)),
                                  y: .value("Average sales", $0.sales),
                                  height: 3)
                    .foregroundStyle(Color.gray)
                }
                
                if medianSalesIsShown {
                    RuleMark(y: .value("Median sales", salesViewModel.medianSales))
                        .foregroundStyle(.blue)
                        .annotation(position: .top, alignment: .trailing) {
                            Text("Median: \(String(format: "%.2f", salesViewModel.medianSales))")
                                .font(.body.bold())
                                .foregroundStyle(.blue)
                        }
                }
                
                if individualDaysAreShown {
                    ForEach(salesViewModel.salesByWeekday, id: \.number) { weekdayData in
                        ForEach(weekdayData.sales) { sale in
                            PointMark(x: .value("Day" ,weekday(for: weekdayData.number)),
                                      y: .value("Sales", sale.quantity))
                            .foregroundStyle(.indigo.opacity(0.25))
                        }
                    }
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .chartYScale(domain: 0...salesViewModel.maxSales)
            
            Toggle(individualDaysAreShown ? "Hide daily sales" : "Show all daily sales", isOn: $individualDaysAreShown.animation())
            
            Toggle(medianSalesIsShown ? "Hide median sales" : "Show median sales", isOn: $medianSalesIsShown.animation())
            
            Spacer()
        }
        .padding()
    }
    
    func weekday(for number: Int) -> String {
        let formatter = DateFormatter()
        return formatter.shortWeekdaySymbols[number - 1]
    }
}

#Preview {
    SalesByWeekdayView(salesViewModel: .preview)
}
