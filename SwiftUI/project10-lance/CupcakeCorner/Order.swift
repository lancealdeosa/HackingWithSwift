//
//  Order.swift
//  CupcakeCorner
//
//  Created by Lance Paolo Aldeosa on 1/29/24.
//

import SwiftUI

@Observable
class Order: Codable {
    enum Flavor: String, CaseIterable, Codable {
        case vanilla
        case strawberry
        case chocolate
        case rainbow
        
        var title: String { rawValue.capitalized }
        
        var multiplier: Double {
            switch self {
            case .vanilla: return 1.0
            case .strawberry, .chocolate: return 1.5
            case .rainbow: return 2.0
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _flavor = "flavor"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    var flavor = Flavor.vanilla
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        guard !name.isEmpty else { return false }
        guard !streetAddress.isEmpty else { return false }
        guard !city.isEmpty else { return false }
        guard !zip.isEmpty else { return false }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // Complicated cakes cost more
        cost *= flavor.multiplier
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) * 0.5
        }
        
        return cost
    }
}
