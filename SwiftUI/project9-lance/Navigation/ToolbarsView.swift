//
//  ToolbarsView.swift
//  Navigation
//
//  Created by Lance Paolo Aldeosa on 1/15/24.
//

import SwiftUI

struct ToolbarsView: View {
    @State private var text = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello, world.")
                TextField("Enter text", text: $text)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Tap Me") { }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Or Me") { }
                }
                
                ToolbarItem(placement: .keyboard) {
                    Button("Done") { }
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("How about me?") { }
                    Button("And me?") { }
                }
            }
        }
    }
}

#Preview {
    ToolbarsView()
}
