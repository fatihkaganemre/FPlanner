//
//  StartKarateTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 19/06/2024.
//

import SwiftUI

struct StartKarateTrainingView: View {
    var exercises: [KarateExercise]
    @State private var index: Int = 0
    @State private var buttonState: ButtonState = .Start
    @Environment(\.dismiss) private var dismiss
    @State private var count = 0
    
    @State private var timeRemaining: Int = 0
    @State private var trimTo = 0.0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(exercises: [KarateExercise]) {
        self.exercises = exercises
        timeRemaining = (Int(exercises[0].durationInMin) ?? 0) * 60
    }
    
    enum ButtonState: String {
        case Start
        case Pause
        case CountDown
        case Finish
    }
    
    var body: some View {
        if index < exercises.count {
            VStack {
                Text(exercises[index].name).font(.title2).fontWeight(.bold)
                Text(exercises[index].description).font(.title2)
            }
            .padding(40)
            .background(Color("darkGreen"), alignment: .center)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 12)
            .onReceive(timer) { input in
                withAnimation {
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        trimTo = 1 - (Double(timeRemaining) / 60)
                    }
                }
            }
        }
        
        Spacer()
        
        HStack {
            Button("", systemImage: "pause.fill") {
                
            }
            .padding()
            .background(Color.yellow)
            .cornerRadius(12)
            .shadow(radius: 10)
            
            
            Button(buttonState.rawValue) {
                nextExercise()
            }
            .padding(.all, 40)
            .font(.largeTitle).fontWeight(.bold)
            .background(Color("darkGreen"))
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .trim(from: 0, to: trimTo)
                    .stroke(.yellow, lineWidth: 5)
            }
            .shadow(radius: 10)
            
            Button(action: {
                
            }, label: {
                Text("Skip").fontWeight(.bold).padding()
            })
            .background(Color.yellow)
            .cornerRadius(12)
            .shadow(radius: 10)
        }
    }
    
    func handleButtonAction() {
        switch buttonState {
            case .Start: break
                
            case .Pause: break
            case .CountDown: break
            case .Finish: 
                dismiss()
        }
    }
    
    func nextExercise() {
        if index <= exercises.count - 1 {
            index += 1
            timeRemaining = (Int(exercises[index].durationInMin) ?? 0) * 60
        }
        
        if index == exercises.count - 1 {
            buttonState = .Finish
        }
    }
}

#Preview {
    StartKarateTrainingView(exercises: mockKarateExercises)
}
