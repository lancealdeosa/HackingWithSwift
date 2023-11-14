//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Lance on 10/24/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)

      Button("Hello, world!") {
        print(type(of: self.body))
      }
      .foregroundStyle(.white)
      .frame(width: 200, height: 200)
      .background(.red)
      
      Text("Hello, world!")
          .padding()
          .background(.red)
          .padding()
          .background(.blue)
          .padding()
          .background(.green)
          .padding()
          .background(.yellow)
      
      Text("This is a title")
        .titleStyle()
      
      Color.blue
        .frame(width: 300, height: 200)
        .watermarked(with: "hello there")
    }
    // .frame(maxWidth: .infinity, maxHeight: .infinity)
    // .background(.red)
  }
}

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundStyle(.white)
      .padding()
      .background(.blue)
      .clipShape(.rect(cornerRadius: 10))
  }
}

struct Watermark: ViewModifier {
  let text: String
  
  func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing) {
      content
      Text(text)
        .font(.caption)
        .foregroundStyle(.white)
        .padding(5)
        .background(.black)
    }
  }
}

extension View {
  func titleStyle() -> some View {
    modifier(Title())
  }
  
  func watermarked(with text: String) -> some View {
    modifier(Watermark(text: text))
  }
}


#Preview {
  ContentView()
}
