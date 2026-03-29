//
//  ExpensesViewModel.swift
//  BookStoreStrategist
//
//  Created by Antonio Damjanović on 26.03.2026..
//

import Foundation
import Combine

class ExpensesViewModel: ObservableObject {
    
    @Published private var expenses: [Expense] = []
    @Published var monthlyExpenseData: [ExpenseStates] = []
    @Published var totalExpenses: Double = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // fetch data from server
        
        $expenses.sink { [unowned self] expenses in
            let fixedExpenses = self.expensesByMonth(for: .fixed, expenses: expenses)
            let variableExpenses = self.expensesByMonth(for: .variable, expenses: expenses)
            
            self.monthlyExpenseData = self.calculateTotalMonthlyExpenses(fixedExpenses: fixedExpenses, variableExpenses: variableExpenses)
            self.totalExpenses = self.calculateTotalExpenses(for: expenses)
        }
        .store(in: &subscriptions)
    }
    
    private func expensesByMonth(for category: ExpenseCategory, expenses: [Expense]) -> [(month: Int, amount: Double)] {
        let calendar = Calendar.current
        var expensesByMonth: [Int: Double] = [:]
        
        for expense in expenses where expense.category == category {
            let month = calendar.component(.month, from: expense.expenseDate)
            expensesByMonth[month, default: 0] += expense.amount
        }
        
        let result = expensesByMonth.map { (month: $0.key, amount: $0.value) }
        
        return result.sorted { $0.month < $1.month }
    }
    
    private func calculateTotalMonthlyExpenses(fixedExpenses: [(month: Int, amount: Double)],
                                       variableExpenses: [(month: Int, amount: Double)]) -> [ExpenseStates] {
        var result = [ExpenseStates]()
        let count = min(fixedExpenses.count, variableExpenses.count)
        
        for index in 0..<count {
            let month = fixedExpenses[index].month
            result.append(ExpenseStates(month: month,
                                        fixedExpenses: fixedExpenses[index].amount,
                                        variableExpenses: variableExpenses[index].amount))
        }
        
        return result
    }
    
    private func calculateTotalExpenses(for expenses: [Expense]) -> Double {
        let totalExpenses = expenses.reduce(0) { total, expense in
            total + expense.amount
        }
        return totalExpenses
    }
    
    // MARK: - preview
    static var preview: ExpensesViewModel {
        let vm = ExpensesViewModel()
        vm.expenses = Expense.yearExamples
        return vm
    }
}

struct ExpenseStates: Identifiable {
    let month: Int
    let fixedExpenses: Double
    let variableExpenses: Double
    
    var totalExpenses: Double {
        fixedExpenses + variableExpenses
    }
    
    var id: Int { return month }
}
