//
//  CardView.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 5/19/24.
//

import SwiftUI

struct CardView: View {
  typealias Card = MemoryGame<String>.Card
  
  let card: Card
  
  init(_ card: Card) {
    self.card = card
  }
  
  var body: some View {
    Pie(endAngle: .degrees(240))
      .opacity(0.4)
      .overlay(
        Text(card.content)
          .font(.system(size: 200))
          .minimumScaleFactor(0.01)
          .multilineTextAlignment(.center)
          .aspectRatio(1, contentMode: .fit)
          .padding(5)
      )
      .padding(5)
      .cardify(isFaceUp: card.isFaceUp)
      .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
  }
}
