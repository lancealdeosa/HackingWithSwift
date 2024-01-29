//
//  PlaygroundView.swift
//  CupcakeCorner
//
//  Created by Lance Paolo Aldeosa on 1/22/24.
//

import SwiftUI
import CoreHaptics

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    var name = "Taylor"
}

struct PlaygroundView: View {
    @State private var counter = 0
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack {
            Text("Hello, world!")
//            Button("Encode", action: encodeTaylor)
            Button("Tap Me", action: complexSuccess)
                .onAppear(perform: prepareHaptics)
//            .sensoryFeedback(.increase, trigger: counter)
//            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter)
            .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)

        }
        .padding()
    }
    
    private func encodeTaylor() {
        guard let data = try? JSONEncoder().encode(User()) else { return }
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let lowSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
        let highSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        
        events.append(contentsOf: [
            CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, lowSharpness], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, highSharpness], relativeTime: 0.5)
        ])

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

#Preview {
    PlaygroundView()
}
