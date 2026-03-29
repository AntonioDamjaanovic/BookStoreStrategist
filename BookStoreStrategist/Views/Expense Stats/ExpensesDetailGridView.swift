//
//  ExpensesDetailGridView.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 29.03.2026..
//

import SwiftUI

struct ExpensesDetailGridView: View {
    
    @ObservedObject var expensesViewModel: ExpensesViewModel
    
    var body: some View {
        Grid(alignment: .trailing, horizontalSpacing: 15, verticalSpacing: 10) {
            GridRow {
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                Text("Fixed")
                    .gridCellAnchor(.center)
                Text("Variable")
                    .gridCellAnchor(.center)
                Text("All")
                    .gridCellAnchor(.center)
            }
            
            Divider()
                .gridCellUnsizedAxes([.vertical, .horizontal])
            
            ForEach(expensesViewModel.monthlyExpenseData) { data in
                GridRow {
                    Text(month(for: data.month))
                    
                    Text(String(format: "%.2f", data.fixedExpenses))
                    Text(String(format: "%.2f", data.variableExpenses))
                    Text(String(format: "%.2f", data.totalExpenses))
                        .bold()
                }
            }
            
            Divider()
                .gridCellUnsizedAxes([.vertical, .horizontal])
            
            GridRow {
                Text("Total")
                    .bold()
                
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    .gridCellColumns(2)
                
                Text("$" + String(format: "%.2f", expensesViewModel.totalExpenses))
                    .bold()
                    .foregroundStyle(.pink)
                    .fixedSize()
            }
        }
    }
    
    let formatter = DateFormatter()
    
    func month(for number: Int) -> String {
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
}

#Preview {
    ExpensesDetailGridView(expensesViewModel: .preview)
}
