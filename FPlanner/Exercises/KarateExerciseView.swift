//
//  KarateExerciseView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 06/06/2024.
//

import SwiftUI

struct KarateExerciseView: View {
    @State private var exercise: KarateExercise = .init()
    @Binding var exerciseList: [KarateExercise]
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    @State private var second: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField("Name", text: $exercise.name)
                .font(.headline)
            TextField("Description", text: $exercise.description)
                .font(.subheadline)
                .padding(.bottom, 5)
            Divider()
            VStack(spacing: 5) {
                Picker("Hour", selection: $hour) {
                    ForEach(0...5, id: \.self) {
                        Text("\($0)")
                    }
                }
                Picker("Min", selection: $minute) {
                    ForEach(0...59, id: \.self) {
                        Text("\($0)")
                    }
                }
                Picker("Sec", selection: $second) {
                    ForEach(0...59, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
            Divider()
            Button("Add Exercise") {
                withAnimation {
                    addExercise()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(canAddExercise())
            .padding(.top, 5)
        }
    }
    
    private func canAddExercise() -> Bool {
        exercise.name.isEmpty
        || exercise.description.isEmpty
        || (hour == 0 && minute == 0 && second == 0)
    }
    
    private func addExercise() {
        let durationInSeconds = (hour * 360) + (minute * 60) + second
        exercise.durationInSec = durationInSeconds
        exerciseList.append(exercise)
        resetData()
    }
    
    private func resetData() {
        hour = 0
        minute = 0
        second = 0
        exercise = .init()
    }
}

#Preview {
    KarateExerciseView(exerciseList: .constant([]))
}
