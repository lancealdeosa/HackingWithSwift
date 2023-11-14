//
//  ContentView.swift
//  WordScramble
//
//  Created by Lance Paolo Aldeosa on 11/14/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var errorShown = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                Section("Score") {
                    Text("\(score)")
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New Game") {
                        resetGame()
                    }
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $errorShown) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }

        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !answer.isEmpty else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word already used", message: "Be more original.")
            return
        }
        
        guard isLongEnough(word: answer) else {
            wordError(title: "Word too short", message: "Answer something longer.")
            return
        }
        
        guard isNotJustTheSameRootWord(word: answer) else {
            wordError(title: "Word is just the same", message: "Try something else.")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \(rootWord).")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "That's not a real word?")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        score += 1
        newWord = ""
    }
    
    func resetGame() {
        usedWords = []
        newWord = ""
        score = 0
        startGame()
    }
    
    func startGame() {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsURL) else {
            fatalError("Could not load start.txt from bundle.")
        }
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
    }
    
    func isLongEnough(word: String) -> Bool {
        return word.count >= 3
    }
    
    func isNotJustTheSameRootWord(word: String) -> Bool {
        return word != rootWord
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let index = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        errorShown = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
