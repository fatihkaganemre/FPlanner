//
//  StartGymTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 18/06/2024.
//

import SwiftUI

struct StartGymTrainingView: View {
    @StateObject var viewModel: StartGymTrainingViewModel
    @Environment(\.dismiss) private var dismiss
    
    enum ButtonState: String {
        case Next, Finish
    }
    
    var body: some View {
        if viewModel.index < viewModel.exercises.count {
            let exercise = viewModel.exercises[viewModel.index]
            VStack {
                Text(exercise.name).font(.title2).fontWeight(.bold)
                Text("Max weight: \(exercise.maxWeight)kg").font(.title2)
                HStack {
                    Text("Reps: \(exercise.numberOfReps)")
                    Text("Sets: \(exercise.numberOfSets)")
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
        HStack {
            if viewModel.index > 0 {
                BackButton()
            }
            StartButton()
        }
    }
    
    @ViewBuilder
    private func StartButton() -> some View {
        Button(viewModel.buttonState.rawValue) {
            withAnimation {
                nextExercise()
            }
        }
        .padding(.all, 40)
        .font(.title).fontWeight(.bold)
        .background(Color("darkGreen"))
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.yellow, lineWidth: 4)
        }
        .shadow(radius: 10)
    }
    
    @ViewBuilder
    private func BackButton() -> some View {
        Button(action: {
            withAnimation {
                viewModel.handleBackButtonAction()
            }
        }, label: {
            Text("Back").fontWeight(.bold).padding()
        })
        .foregroundColor(.white)
        .background(Color.black)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    
    private func nextExercise() {
        switch viewModel.buttonState {
            case .Next: viewModel.nextExercise()
            case .Finish: dismiss()
        }
    }
}

#Preview {
    StartGymTrainingView(viewModel: .init(exercises: mockGymExercises))
}
