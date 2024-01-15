//
//  ContentView.swift
//  Moonshot
//
//  Created by Lance Paolo Aldeosa on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingGrid = false
    
    private let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    private let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    
    var body: some View {
        NavigationStack {
            Group {
                if isShowingGrid {
                    MissionsGrid(astronauts: astronauts, missions: missions)
                } else {
                    MissionsList(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("", systemImage: isShowingGrid ? "rectangle.grid.1x2" : "square.grid.2x2") {
                    isShowingGrid.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
