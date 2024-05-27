//
//  EmojiMemoryGameView.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 4/10/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  typealias Card = MemoryGame<String>.Card
  
  @ObservedObject var viewModel: EmojiMemoryGame
  @State private var lastScoreChange = (0, causedByCardId: "")
  @State private var dealt = Set<Card.ID>()
  @Namespace private var dealingNamespace
  
  private let aspectRatio: CGFloat = 2/3
  private let deckWidth: CGFloat = 50
  
  var body: some View {
    VStack {
      cards
        .animation(.default, value: viewModel.cards)
        .foregroundColor(viewModel.color)
      HStack {
        score
        Spacer()
        deck
          .foregroundColor(viewModel.color)
        Spacer()
        shuffle
      }
      .font(.largeTitle)
    }
    .padding()
  }
  
  private var score: some View {
    Text("Score: \(viewModel.score)")
      .animation(nil)
  }
  
  private var shuffle: some View {
    Button("Shuffle") {
      withAnimation(.easeInOut(duration: 2)) {
        viewModel.shuffle()
      }
    }
  }
  
  private var cards: some View {
    AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
      if isDealt(card) {
        CardView(card)
          .matchedGeometryEffect(id: card.id, in: dealingNamespace)
          .transition(.asymmetric(insertion: .identity, removal: .identity))
          .aspectRatio(2/4, contentMode: .fill)
          .padding(4)
          .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
          .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
          .onTapGesture {
            choose(card)
          }
      }
    }
  }
  
  private func isDealt(_ card: Card) -> Bool {
    dealt.contains(card.id)
  }
  
  private var undealtCards: [Card] {
    viewModel.cards.filter { !isDealt($0) }
  }
  
  private var deck: some View {
    ZStack {
      ForEach(undealtCards) { card in
        CardView(card)
          .matchedGeometryEffect(id: card.id, in: dealingNamespace)
          .transition(.asymmetric(insertion: .identity, removal: .identity))
      }
    }
    .frame(width: deckWidth, height: deckWidth / aspectRatio)
    .onTapGesture {
      deal()
    }
  }
  
  private func deal() {
    var delay: TimeInterval = 0
    
    for card in viewModel.cards {
      withAnimation(.easeInOut(duration: 1).delay(delay)) {
        _ = dealt.insert(card.id)
      }
      delay += 0.15
    }
  }
  
  private func choose(_ card: Card) {
    withAnimation {
      let scoreBeforeChoosing = viewModel.score
      
      viewModel.choose(card)
      
      let scoreChange = viewModel.score - scoreBeforeChoosing
      
      lastScoreChange = (scoreChange, causedByCardId: card.id)
    }
  }
  
  private func scoreChange(causedBy card: Card) -> Int {
    let (amount, id) = lastScoreChange
    return card.id == id ? amount : 0
  }
}

#Preview {
  EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
