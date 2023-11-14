//
//  DragQueenView.swift
//  Animations
//
//  Created by Lance Paolo Aldeosa on 11/14/23.
//

import SwiftUI

struct DragQueenView: View {
    private let letters = Array("Slay Queeen")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(zip(letters.indices, letters)), id: \.0) { index, letter in
                Text(String(letter))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(index) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

#Preview {
    DragQueenView()
}
