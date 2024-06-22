//
//  StartGymTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 18/06/2024.
//

import SwiftUI


struct StartGymTrainingView: View {
    var exercises: [GymExercise]
    @State private var index: Int = 0
    @State private var buttonState: ButtonState = .Next
    @Environment(\.dismiss) private var dismiss
    
    enum ButtonState: String {
        case Start
        case Next
        case Finish
    }
    
    var body: some View {
        if index < exercises.count {
            VStack {
                Text(exercises[index].name).font(.title2).fontWeight(.bold)
                Text("Max weight: \(exercises[index].maxWeight)kg").font(.title2)
                HStack {
                    Text("Reps: \(exercises[index].numberOfReps)")
                    Text("Sets: \(exercises[index].numberOfSets)")
                }
                .font(.title2)
            }
            .padding(40)
            .background(Color("darkGreen"), alignment: .center)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 12)
        }
        
        Spacer()
        
        Button(buttonState.rawValue) {
            nextExercise()
        }
        .padding(.all, 40)
        .font(.largeTitle).fontWeight(.bold)
        .background(Color("darkGreen"))
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.yellow, lineWidth: 4)
        }
        .shadow(radius: 10)
    }
    
    func nextExercise() {
        switch buttonState {
            case .Start: break
            case .Next:
                if index <= exercises.count - 1 {
                    index += 1
                }
                
                if index == exercises.count - 1 {
                    buttonState = .Finish
                }
            case .Finish: dismiss()
        }
    }
}

#Preview {
    StartGymTrainingView(
        exercises: [
            GymExercise(name: "Exercise1", numberOfReps: "12", numberOfSets: "3", maxWeight: "120"),
            GymExercise(name: "Exercise2", numberOfReps: "12", numberOfSets: "3", maxWeight: "100"),
            GymExercise(name: "Exercise3", numberOfReps: "12", numberOfSets: "3", maxWeight: "90")
        ]
    )
}
