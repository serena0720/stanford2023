//
//  Cardify.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 5/26/24.
//

import SwiftUI

struct Cardify: ViewModifier {
  var isFaceUp: Bool
  
  func body(content: Content) -> some View {
    ZStack {
      let base = RoundedRectangle(cornerRadius: 12)
      base.strokeBorder(lineWidth: 2)
        .background(base.fill(.white))
        .overlay(content)
        .opacity(isFaceUp ? 1 : 0)
      
      base.fill()
        .opacity(isFaceUp ? 0 : 1)
    }
  }
}

extension View {
  func cardify(isFaceUp: Bool) -> some View {
    modifier(Cardify(isFaceUp: isFaceUp))
  }
}
