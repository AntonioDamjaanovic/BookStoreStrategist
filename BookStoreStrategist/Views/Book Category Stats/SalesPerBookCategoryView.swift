//
//  SalesPerBookCategoryView.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 21.03.2026..
//

import SwiftUI

struct SalesPerBookCategoryView: View {
    
    enum ChartStyle: CaseIterable, Identifiable {
        case pie
        case bar
        
        var id: Self { self }
        
        var displayName: String {
            switch self {
                case .pie:
                    "Pie Chart"
                case .bar:
                    "Bar Chart"
            }
        }
    }
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var selectedChartType: ChartStyle = .pie
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Picker("Chart Type", selection: $selectedChartType.animation()) {
                ForEach(ChartStyle.allCases) {
                    Text($0.displayName)
                }
            }
            .pickerStyle(.segmented)
            
            SalesPerBookCategoryHeaderView(salesViewModel: salesViewModel)
            
            switch selectedChartType {
                case .pie:
                    SalesPerBookCategoryPieChartView(salesViewModel: salesViewModel)
                case .bar:
                    SalesPerBookCategoryBarChartView(salesViewModel: salesViewModel)
            }
        }
        .padding()
        
        Spacer()
    }
}

#Preview {
    SalesPerBookCategoryView(salesViewModel: .preview)
}
