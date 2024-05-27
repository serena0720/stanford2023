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
    TimelineView(.animation(minimumInterval: 1/10)) { timeline in
      if card.isFaceUp || !card.isMatched {
        Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
          .opacity(0.4)
          .overlay(cardContents.padding(5))
          .padding(5)
          .cardify(isFaceUp: card.isFaceUp)
          .transition(.opacity)
      } else {
        Color.clear
      }
    }
  }
  
  var cardContents: some View {
    Text(card.content)
      .font(.system(size: 200))
      .minimumScaleFactor(0.01)
      .multilineTextAlignment(.center)
      .aspectRatio(1, contentMode: .fit)
      .rotationEffect(.degrees(card.isMatched ? 360 : 0))
      .animation(.spin(duration: 1), value: card.isMatched)
  }
}

extension Animation {
  static func spin(duration: TimeInterval) -> Animation {
    .linear(duration: duration).repeatForever(autoreverses: false)
  }
}
