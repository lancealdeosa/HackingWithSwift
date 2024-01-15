//
//  AstronautCell.swift
//  Moonshot
//
//  Created by Lance Paolo Aldeosa on 1/15/24.
//

import SwiftUI

struct AstronautCell: View {
    let member: CrewMember
    
    var body: some View {
        HStack {
            Image(member.astronaut.imageName)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(.capsule)
                .overlay {
                    Capsule()
                        .stroke(.white, lineWidth: 1)
                }
            
            VStack(alignment: .leading) {
                Text(member.astronaut.name)
                    .foregroundStyle(.white)
                    .font(.headline)
                Text(member.role)
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
    }
}


#Preview(traits: .fixedLayout(width: 250, height: 100)) {
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let member = CrewMember(astronaut: astronauts["aldrin"]!, role: "Command Pilot")
    return AstronautCell(member: member)
        .preferredColorScheme(.dark)
}
