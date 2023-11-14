//
//  ContentView.swift
//  Animations
//
//  Created by Lance Paolo Aldeosa on 11/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var isShowingRect = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)
                if isShowingRect {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture {
                withAnimation {
                    isShowingRect.toggle()
                }
            }
            
            
//            // Multiple animations
//            Button("Tap Me") {
//                enabled.toggle()
//                isShowingRect.toggle()
//            }
//            .frame(width: 100, height: 100)
//            .background(enabled ? .blue : .red)
//            .animation(.default, value: enabled)
//            .foregroundStyle(.white)
//            .clipShape(.rect(cornerRadius: enabled ? 40 : 0))
//            .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
//            
//            // Transitions
//            Group { // Hack to make transitions work on preview
//                if isShowingRect {
//                    Rectangle()
//                        .fill(.yellow)
//                        .frame(width: 100, height: 100)
//                        // .transition(.scale)
//                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
//                }
//            }
//            .animation(.default, value: isShowingRect)
   
            
//            // Explicit
//            AnimatingButton {
//                withAnimation {
//                    animationAmount += 72
//                }
//            }
//            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0.0, y: 1.0, z: 0.0))
        
            
//            // Animating bindings
//            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
//            Spacer()
//            AnimatingButton(animationAmount: $animationAmount, backgroundColor: .red) {
//                animationAmount += 1
//            }
//            .scaleEffect(animationAmount)
            
            
//            // Infinitely repeating
//            AnimatingButton()
//                .overlay {
//                    Circle()
//                        .stroke(.red)
//                        .scaleEffect(animationAmount)
//                        .opacity(2 - animationAmount)
//                        .animation(
//                            .easeInOut(duration: 0.5)
//                                .repeatForever(autoreverses: false),
//                            value: animationAmount
//                        )
//                }
//                .onAppear {
//                    animationAmount = 2
//                }
            
            
//            // Manually adjusted
//            AnimatingButton() {
//                animationAmount += 1
//            }
//            .scaleEffect(animationAmount)
//            .blur(radius: (animationAmount - 1) * 3)
//            .animation(.spring(duration: 1.0, bounce: 0.9), value: animationAmount)
//            .animation(.default, value: animationAmount)
//            .animation(
//                .easeInOut(duration: 0.5)
//                    .delay(1)
//                    .repeatCount(2, autoreverses: true),
//                value: animationAmount
//            )
        }
        .padding()
    }
}

struct AnimatingButton: View {
    var action: (() -> Void)?
    
    var body: some View {
        Button("Tap Me", action: action ?? { })
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(Circle())
    }
    
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
