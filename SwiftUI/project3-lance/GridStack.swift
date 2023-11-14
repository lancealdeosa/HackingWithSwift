//
//  GridStack.swift
//  ViewsAndModifiers
//
//  Created by Lance on 10/24/23.
//

import SwiftUI

struct GridStack<Content: View>: View {
  let rows: Int
  let columns: Int
  @ViewBuilder let content: (Int, Int) -> Content
  
  var body: some View {
    VStack {
      ForEach(0..<rows, id: \.self) { row in
        HStack {
          ForEach(0..<columns, id: \.self) { column in
            content(row, column)
          }
        }
      }
    }
  }
}

#Preview {
  GridStack(rows: 4, columns: 4) { row, column in
    let number = row * 4 + column
    Image(systemName: "\(number).circle")
    Text("R\(row) C\(column)")
  }
}
