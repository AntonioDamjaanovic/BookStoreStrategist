//
//  ExpensesLineChartView.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 29.03.2026..
//

import SwiftUI
import Charts

struct ExpensesLineChartView: View {
    
    @ObservedObject var expensesViewModel: ExpensesViewModel
    
    let lineWidth: CGFloat = 2
    
    var body: some View {
        Chart(expensesViewModel.monthlyExpenseData) { data in
            Plot {
                LineMark(x: .value("Month", data.month),
                         y: .value("Expenses", data.fixedExpenses))
                .foregroundStyle(by: .value("Expenses", "fixed"))
                .symbol(by: .value("Expenses", "fixed"))
                
                LineMark(x: .value("Month", data.month),
                         y: .value("Expenses", data.variableExpenses))
                .foregroundStyle(by: .value("Expenses", "variable"))
                .symbol(by: .value("Expenses", "variable"))
            }
            .lineStyle(StrokeStyle(lineWidth: lineWidth))
            .interpolationMethod(.catmullRom)
        }
        .aspectRatio(1, contentMode: .fit)
        .chartForegroundStyleScale(["variable": .purple, "fixed": .cyan])
        .chartSymbolScale(["variable": Circle().strokeBorder(lineWidth: lineWidth),
                           "fixed": Square().strokeBorder(lineWidth: lineWidth)])
        .chartXScale(domain: 0...13)
        .chartXAxis {
            AxisMarks(values: [1, 4, 7, 10]) { value in
                AxisGridLine()
                AxisTick()
                
                if let number = value.as(Int.self) {
                    AxisValueLabel(month(for: number), anchor: .top)
                }
            }
        }
        .chartYAxis {
            AxisMarks { value in
                AxisGridLine()
                AxisTick()
                
                if let number = value.as(Double.self) {
                    AxisValueLabel("\(Int(number / 1000)) K")
                }
            }
        }
    }
    
    let formatter = DateFormatter()
    
    func month(for number: Int) -> String {
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
}

/// A square symbol for charts.
struct Square: ChartSymbolShape, InsettableShape {
    let inset: CGFloat

    init(inset: CGFloat = 0) {
        self.inset = inset
    }

    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 1
        let minDimension = min(rect.width, rect.height)
        return Path(
            roundedRect: .init(x: rect.midX - minDimension / 2, y: rect.midY - minDimension / 2, width: minDimension, height: minDimension),
            cornerRadius: cornerRadius
        )
    }

    func inset(by amount: CGFloat) -> Square {
        Square(inset: inset + amount)
    }

    var perceptualUnitRect: CGRect {
        // The width of the unit rectangle (square). Adjust this to
        // size the diamond symbol so it perceptually matches with
        // the circle.
        let scaleAdjustment: CGFloat = 0.75
        return CGRect(x: 0.5 - scaleAdjustment / 2, y: 0.5 - scaleAdjustment / 2, width: scaleAdjustment, height: scaleAdjustment)
    }
}

#Preview {
    ExpensesLineChartView(expensesViewModel: .preview)
        .padding()
}
