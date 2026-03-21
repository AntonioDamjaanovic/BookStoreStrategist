//
//  SalesByWeekdayHeaderView.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 19.03.2026..
//

import SwiftUI

struct SalesByWeekdayHeaderView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        if let highestSellingWeekday = salesViewModel.highestSellingWeekday {
            Text("Your highest selling day of the week is ") +
            Text("\(weekday(for: highestSellingWeekday.number)) ")
                .bold()
                .foregroundStyle(Color.accentColor) +
            Text("\(Int(highestSellingWeekday.number)) sales per day.")
                .bold()
        }
    }
    
    func weekday(for number: Int) -> String {
        let formatter = DateFormatter()
        return formatter.weekdaySymbols[number - 1]
    }
}

#Preview {
    SalesByWeekdayHeaderView(salesViewModel: .preview)
}
