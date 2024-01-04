//
//  Bundle+JSON.swift
//  Moonshot
//
//  Created by Lance Paolo Aldeosa on 1/4/24.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(file fileName: String, dateFormat: String? = "y-MM-dd") -> T {
        guard let url = url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(fileName) from bundle")
        }
        
        let decoder = JSONDecoder()
        if let dateFormat {
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
            decoder.dateDecodingStrategy = .formatted(formatter)
        }
    
        guard let dict = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(fileName) from bundle")
        }
        
        return dict
    }
}
