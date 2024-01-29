//
//  GuessTheFlag.swift
//  WeSplit
//
//  Created by Lance Paolo Aldeosa on 9/26/23.
//

import SwiftUI

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct GuessTheFlag: View {
    
    @State private var questionsShown = 0
    @State private var score = 0
    @State private var isCorrect = false
    @State private var tappedFlag = ""
    
    @State private var isScoreShown = false
    @State private var isResetGameShown = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    private var scoreTitle: String { isCorrect ? "Correct" : "Wrong" }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                Gradient.Stop(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                Gradient.Stop(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .largeWhiteTitleStyle()
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { index in
                        Button {
                            flagTapped(index: index)
                        } label: {
                            FlagImage(country: countries[index])
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $isScoreShown) {
            Button("OK", action: askQuestion)
        } message: {
            let alertMessage = isCorrect ? "You chose the right flag!" : "Sorry, that's the flag of \(tappedFlag)"
            Text(alertMessage)
        }
        .alert("Game Over!", isPresented: $isResetGameShown) {
            Button("Reset") {
                reset()
            }
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func flagTapped(index: Int) {
        questionsShown += 1
        isCorrect = index == correctAnswer
        if isCorrect {
            score += 1
        }
        tappedFlag = countries[index]
        
        if questionsShown >= 3 {
            isResetGameShown = true
        } else {
            isScoreShown = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        questionsShown = 0
        score = 0
        isCorrect = false
        tappedFlag = ""
        askQuestion()
    }
}

struct LargeWhiteTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func largeWhiteTitleStyle() -> some View {
        modifier(LargeWhiteTitle())
    }
}

struct GuessTheFlag_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag()
    }
}
