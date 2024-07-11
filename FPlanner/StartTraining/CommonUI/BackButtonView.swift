//
//  BackButtonView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 10/07/2024.
//

import SwiftUI

struct BackButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text("Back").fontWeight(.bold).padding()
        })
        .foregroundColor(.white)
        .background(Color.black)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

#Preview {
    BackButtonView(action: {})
}
