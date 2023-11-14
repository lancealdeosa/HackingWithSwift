//
//  MainView.swift
//  WeSplit
//
//  Created by Lance Paolo Aldeosa on 9/26/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("WeSplit", systemImage: "dollarsign.circle")
                }
            GuessTheFlag()
                .tabItem {
                    Label("Guess the Flag", systemImage: "flag.checkered")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
