//
//  TrainingCellView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 11/06/2024.
//

import SwiftUI

struct TrainingCellView: View {
    var training: Training
    
    var body: some View {
        NavigationLink(value: training) {
            VStack(alignment: .leading) {
                Text(training.name).font(.title)
                Text("Scheduled at: \(training.scheduledAt.formatted(date: .abbreviated, time: .shortened))")
            }
        }
    }
}

#Preview {
    TrainingCellView(training: .init(name: "Karate training", type: .karate))
}
