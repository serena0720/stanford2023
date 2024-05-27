//
//  Cardify.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 5/26/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
  var isFaceUp: Bool {
    rotation < 90
  }
  
  var rotation: Double
  
  var animatableData: Double {
    get { rotation }
    set { rotation = newValue }
  }
  
  init(isFaceUp: Bool) {
    self.rotation = isFaceUp ? 0 : 180
  }
  
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
    .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
  }
}

extension View {
  func cardify(isFaceUp: Bool) -> some View {
    modifier(Cardify(isFaceUp: isFaceUp))
  }
}
