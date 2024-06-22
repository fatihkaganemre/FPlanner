//
//  StartCustomTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 19/06/2024.
//

import SwiftUI

struct StartCustomTrainingView: View {
    var exercises: [CustomExercise]
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
                Text(exercises[index].description).font(.title2)
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
    StartCustomTrainingView(exercises: mockCustomExercises)
}
