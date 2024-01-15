//
//  ContentView.swift
//  Navigation
//
//  Created by Lance Paolo Aldeosa on 1/15/24.
//

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet { save() }
    }
    
    private let url = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: url),
           let representation = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
            path = NavigationPath(representation)
            return
        }
        
        path = NavigationPath()
    }
    
    private func save() {
        guard let representation = path.codable else { return }

        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: url)
        } catch {
            // Do nothing
        }
    }
}

struct ContentView: View {
//    @State private var path = NavigationPath()
    @State private var pathStore = PathStore()
    
    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(0..<5) { i in
//                    NavigationLink("Option \(i)", value: i)
//                }
//                ForEach(0..<5) { i in
//                    NavigationLink("Option \(i)", value: "\(i)")
//                }
//            }
//            .navigationDestination(for: Int.self) { number in
//                Text("Number \(number)")
//            }
//            .navigationDestination(for: String.self) { numberString in
//                Text("String \(numberString)")
//            }
//        }
        
//        NavigationStack(path: $path) {
//            VStack {
//                Button("Show 32") {
//                    path.append(32)
//                }
//                Button("Show 64") {
//                    path.append("64")
//                }
//                Button("Show 32 then 64") {
//                    path.append(32)
//                    path.append("64")
//                }
//            }
//            .navigationDestination(for: Int.self) { number in
//                Text("Number \(number)")
//            }
//            .navigationDestination(for: String.self) { numberString in
//                Text("String \(numberString)")
//            }
//        }
//        
//        NavigationStack(path: $pathStore.path) {
//            DetailView(number: 0)
//                .navigationDestination(for: Int.self) { i in
//                    DetailView(number: i)
//                }
//        }
        
        NavigationStack {
            List(0..<100) { i in
                Text("\(i)")
            }
            .navigationTitle("Weeeeee")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
//            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}

struct DetailView: View {
//    @Binding var path: NavigationPath
    let number: Int
    
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 1...100))
//            .toolbar {
//                Button("Home") {
//                    path = NavigationPath()
//                }
//            }
    }
}
