//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Lance Paolo Aldeosa on 12/28/23.
//

import Foundation

@Observable
class Expenses {
    var items: [ExpenseItem] = [] {
        didSet {
            guard let itemsData = try? JSONEncoder().encode(items) else { return }
            UserDefaults.standard.set(itemsData, forKey: "items")
        }
    }
    
    init() {
        if let itemsData = UserDefaults.standard.data(forKey: "items"),
            let items = try? JSONDecoder().decode([ExpenseItem].self, from: itemsData) {
            self.items = items
        } else {
            self.items = []
        }
    }
}

struct ExpenseItem: Identifiable, Codable {
    enum ExpenseType: String, CaseIterable, Codable {
        case personal
        case business
        
        var title: String { self.rawValue.capitalized }
    }
    
    var id: UUID = .init()
    let name: String
    let type: ExpenseType
    let amount: Double
}
