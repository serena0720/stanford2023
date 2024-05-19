//
//  EmojiMemoryGame.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 4/17/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  typealias Card = MemoryGame<String>.Card
  
  private static let emojis = ["❤️","🌈","⭐️","🍎","🍀","💙","🔥","✨","☀️","🌼","🌸"]
  
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(
      numberOfPairsOfCards: 2) { pairIndex in
        if emojis.indices.contains(pairIndex) {
          emojis[pairIndex]
        } else {
          "problem"
        }
      }
  }
  
  @Published private var model = EmojiMemoryGame.createMemoryGame()
  
  var cards: Array<Card> {
    model.cards
  }
  
  var color: Color {
    return .orange
  }
  
  // MARK: - Intents
  func shuffle() {
    model.shuffle()
  }
  
  func choose(_ card: Card) {
    model.choose(card)
  }
}
