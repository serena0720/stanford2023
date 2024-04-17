//
//  EmojiMemoryGame.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 4/17/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["❤️","🌈","⭐️","🍎","🍀","💙","🔥","✨","☀️","🌼","🌸"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(
            numberOfPairsOfCards: 4) { pairIndex in
                if emojis.indices.contains(pairIndex) {
                    emojis[pairIndex]
                } else {
                    "problem"
                }
            }
    }
    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
