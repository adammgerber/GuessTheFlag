//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Adam Gerber on 10/23/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var isOverEight = false
    @State private var tapCount = 0
    @State private var gameOverMessage = ""
    @State private var scoreTitle = ""
    @State private var userScore = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    func flagTapped(_ number: Int){
        tapCount += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong: Thats the flag of \(countries[number])"
            userScore -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        userScore = 0
        tapCount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func gameOver(){
        if tapCount == 8{
            isOverEight = true
        }
    }
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.26), location: 0.3),.init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center : .top, startRadius: 200, endRadius: 400).ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            gameOver()
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .alert(scoreTitle, isPresented: $showingScore){
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("Your score is \(userScore)")
                }
                .alert(gameOverMessage, isPresented: $isOverEight){
                    Button("Continue", action: resetGame)
                } message: {
                    Text("GAME OVER: Final Score is \(userScore)")
                }
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            .padding()
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
