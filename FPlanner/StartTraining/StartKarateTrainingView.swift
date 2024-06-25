//
//  StartKarateTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 19/06/2024.
//

import SwiftUI
import Combine

struct StartKarateTrainingView: View {
    var exercises: [KarateExercise]
    @State private var index: Int = 0
    @State private var buttonState: ButtonState = .Start
    @Environment(\.dismiss) private var dismiss
    
    @State private var timeRemaining: Int = 0
    @State private var trimTo = 0.0
    
    @State private var timerSubscription: Cancellable?
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)

    init(exercises: [KarateExercise]) {
        self.exercises = exercises
    }
    
    enum ButtonState: String {
        case Start
        case Pause
        case Play
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
            .onAppear {
                timeRemaining = (Int(exercises[0].durationInMin) ?? 0) * 60
            }
        }

        Spacer()
        
        
        HStack {
            VStack {
                Button(buttonState.rawValue) {
                    handleMainButtonAction()
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
            }
            
            if index < exercises.count - 1 {
                Button(action: {
                    handleSkipButtonAction()
                }, label: {
                    Text("Skip").fontWeight(.bold).padding()
                })
                .background(Color.yellow)
                .cornerRadius(12)
                .shadow(radius: 10)
            }
        }
    }
    
    private func handleMainButtonAction() {
        switch buttonState {
            case .Start:
                startTimer()
                buttonState = .Pause
            case .Pause:
                cancelTimer()
                buttonState = .Play
            case .Play:
                startTimer()
                buttonState = .Pause
            case .Finish:
                dismiss()
        }
    }
    
    private func handleSkipButtonAction() {
        cancelTimer()
        nextExercise()
    }
    
    private func nextExercise() {
        if index <= exercises.count - 1 {
            index += 1
            timeRemaining = (Int(exercises[index].durationInMin) ?? 0) * 60
            cancelTimer()
            buttonState = .Start
        }
    }
    
    func startTimer() {
        timerSubscription = timer
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    trimTo = 1 - (Double(timeRemaining) / 60)
                } else {
                    nextExercise()
                }
            })
    }
    
    func cancelTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
}

#Preview {
    StartKarateTrainingView(exercises: mockKarateExercises)
}
