//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Lance Paolo Aldeosa on 1/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.flavor) {
                        ForEach(Order.Flavor.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Deliver details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
