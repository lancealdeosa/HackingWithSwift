//
//  MissionView.swift
//  Moonshot
//
//  Created by Lance Paolo Aldeosa on 1/4/24.
//

import SwiftUI

struct CrewMember {
    let astronaut: Astronaut
    let role: String
}

struct MissionView: View {
    let mission: Mission
    let crewMembers: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crewMembers = mission.crew.map { crewMember in
            guard let astronaut = astronauts[crewMember.name] else {
                fatalError("Mission \(crewMember.name)")
            }
            return CrewMember(astronaut: astronaut, role: crewMember.role)
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                
                ThickDivider()
                    .padding(.vertical)

                VStack(alignment: .leading) {
                    Text("Mission Date")
                        .font(.title2.bold())
                        .padding(.bottom, 5)
                    Text(mission.longLaunchDate)
                        .padding(.bottom, 10)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)
                }
                .padding([.horizontal, .bottom])
                
                ThickDivider()
                    .padding(.bottom)
            }
            
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crewMembers, id: \.astronaut.id) { member in
                        NavigationLink {
                            AstronautView(astronaut: member.astronaut)
                        } label: {
                            AstronautCell(member: member)
                        }

                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct ThickDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    return MissionView(mission: missions.first { $0.launchDate != nil }!, astronauts: astronauts)
        .preferredColorScheme(.dark)
}
