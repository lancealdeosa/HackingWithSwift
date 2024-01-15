//
//  Mission.swift
//  Moonshot
//
//  Created by Lance Paolo Aldeosa on 1/4/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct Crew: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [Crew]
    let description: String
    
    var imageName: String { "apollo\(id)" }

    var displayName: String { "Apollo \(id)" }
    var shortLaunchDate: String { launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A" }
    var longLaunchDate: String { launchDate?.formatted(date: .long, time: .omitted) ?? "N/A" }
}
