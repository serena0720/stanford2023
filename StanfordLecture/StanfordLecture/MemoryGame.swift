//
//  MemoryGame.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 4/17/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  private(set) var score = 0
  
  init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
    cards = []
    for pairIndex in 0..<max(2,numberOfPairsOfCards) {
      let content: CardContent = cardContentFactory(pairIndex)
      cards.append(Card(content: content, id: "\(pairIndex+1)a"))
      cards.append(Card(content: content, id: "\(pairIndex+1)b"))
    }
  }
  
  var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get {
      cards.indices.filter { cards[$0].isFaceUp }.only
    }
    set {
      cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
    }
  }
  
  mutating func choose(_ card: Card) {
    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
      if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
          if cards[chosenIndex].content == cards[potentialMatchIndex].content {
            cards[chosenIndex].isMatched = true
            cards[potentialMatchIndex].isMatched = true
            score += 2 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
          } else {
            if cards[chosenIndex].hasBeenSeen {
              score -= 1
            }
            if cards[potentialMatchIndex].hasBeenSeen {
              score -= 1
            }
          }
        } else {
          indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        cards[chosenIndex].isFaceUp = true
        
      }
    }
  }
  
  private func index(of card: Card) -> Int? {
    for index in cards.indices {
      if cards[index].id == card.id {
        return index
      }
    }
    return nil
  }
  
  mutating func shuffle() {
    cards.shuffle()
  }
  
  struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
    var isFaceUp: Bool = false {
      didSet {
        if isFaceUp {
          startUsingBonusTime()
        } else {
          stopUsingBonusTime()
        }
        if oldValue && !isFaceUp {
          hasBeenSeen = true
        }
      }
    }
    var hasBeenSeen: Bool = false
    var isMatched: Bool = false {
      didSet {
        if isMatched {
          stopUsingBonusTime()
        }
      }
    }
    let content: CardContent
    var id: String
    
    var debugDescription: String {
      "\(id): \(content)"
    }
    
    // MARK: - BonusTime
    private mutating func startUsingBonusTime() {
      if isFaceUp && !isMatched && bonusPercentRemaining > 0,
         lastFaceUpDate == nil {
        lastFaceUpDate = Date()
      }
    }
    
    private mutating func stopUsingBonusTime() {
      pastFaceUpTime = faceUpTime
      lastFaceUpDate = nil
    }
    
    var bonus: Int {
      Int(bonusTimeLimit * bonusPercentRemaining)
    }
    
    var bonusPercentRemaining: Double {
      bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
    }
    
    var faceUpTime: TimeInterval {
      if let lastFaceUpDate {
        pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      } else {
        pastFaceUpTime
      }
    }
    
    var bonusTimeLimit: TimeInterval = 6
    var lastFaceUpDate: Date?
    var pastFaceUpTime: TimeInterval = 0
  }
}
