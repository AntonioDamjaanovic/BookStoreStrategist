//
//  SimpleExpensesLineChartView.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 29.03.2026..
//

import SwiftUI
import Charts

struct SimpleExpensesLineChartView: View {
    
    @ObservedObject var expensesViewModel: ExpensesViewModel
    
    let linearGradient = LinearGradient(colors: [Color.pink.opacity(0.7), Color.pink.opacity(0.3)],
                                        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your total expenses for the last year are: ") +
            Text("$\(String(format: "%.2f", expensesViewModel.totalExpenses))")
                .bold()
                .foregroundStyle(.pink)
            
            Chart(expensesViewModel.monthlyExpenseData) { data in
                AreaMark(x: .value("Month", data.month),
                         y: .value("Expenses", data.totalExpenses))
                .foregroundStyle(linearGradient)
            }
            .frame(height: 70)
            .chartXScale(domain: 1...12)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
        }
    }
}

#Preview {
    SimpleExpensesLineChartView(expensesViewModel: .preview)
        .padding()
}
