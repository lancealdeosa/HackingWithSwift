//
//  MissionsList.swift
//  Moonshot
//
//  Created by Lance Paolo Aldeosa on 1/15/24.
//

import SwiftUI

struct MissionsList: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]

    var body: some View {
        List {
            ForEach(missions) { mission in
                HStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.shortLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.darkBackground)
                .background {
                    NavigationLink("", destination: MissionView(mission: mission, astronauts: astronauts))
                        .opacity(0)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    return MissionsList(astronauts: astronauts, missions: missions)
        .background(.darkBackground)
        .preferredColorScheme(.dark)
}
