//
//  StartKarateTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 19/06/2024.
//

import SwiftUI

struct StartKarateTrainingView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: StartKarateTrainingViewModel
    
    var body: some View {
        if viewModel.index < viewModel.exercises.count {
            let exercise = viewModel.exercises[viewModel.index]
            VStack {
                Text(exercise.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(exercise.description)
                    .font(.title2)
                    .padding(.top, 5)
            }
            .padding(40)
            .background(Color("darkGreen"), alignment: .center)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 12)
            .onReceive(viewModel.timer) { _ in
                withAnimation {
                    viewModel.timerUpdate()
                }
            }
            .onAppear {
                viewModel.setRemainingTimeOnAppear()
            }
        }

        Spacer()
        HStack {
            if viewModel.index > 0 {
                BackButtonView {
                    withAnimation {
                        viewModel.handleBackButtonAction()
                    }
                }
            }
            VStack(alignment: .center) {
                Text("\(viewModel.timeRemaining)").font(.title)
                StartButton()
            }
            if viewModel.index < viewModel.exercises.count - 1 {
                SkipButton()
            }
        }
    }
    
    @ViewBuilder
    private func StartButton() -> some View {
        Button(viewModel.buttonState.rawValue) {
            if viewModel.buttonState == .Finish {
                dismiss()
            } else {
                viewModel.handleMainButtonAction()
            }
        }
        .padding(.all, 40)
        .font(.title).fontWeight(.bold)
        .background(Color("darkGreen"))
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay {
            Circle()
                .trim(from: 0, to: viewModel.trimTo)
                .stroke(.yellow, lineWidth: 5)
        }
        .shadow(radius: 10)
    }
    
    @ViewBuilder
    private func SkipButton() -> some View {
        Button(action: {
            withAnimation {
                viewModel.handleSkipButtonAction()
            }
        }, label: {
            Text("Skip").fontWeight(.bold).padding()
        })
        .background(Color.yellow)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

#Preview {
    StartKarateTrainingView(viewModel: .init(exercises: mockKarateExercises))
}
