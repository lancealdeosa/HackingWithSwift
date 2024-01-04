//
//  Astronaut.swift
//  Moonshot
//
//  Created by Lance Paolo Aldeosa on 1/4/24.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    
    var imageName: String { id }
}
