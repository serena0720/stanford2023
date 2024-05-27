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
  
  private let aspectRatio: CGFloat = 2/3
  
  var body: some View {
    VStack {
      cards
        .animation(.default, value: viewModel.cards)
      HStack {
        score
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
      //      if card.id.last == "b" {
      VStack {
        CardView(card)
          .aspectRatio(2/4, contentMode: .fill)
          .padding(4)
          .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
          .onTapGesture {
            withAnimation {
              viewModel.choose(card)
            }
          }
        //          Text(card.id)
      }
      //      }
    }
//    .foregroundColor(viewModel.color)
  }
  
  private func scoreChange(causedBy card: Card) -> Int {
    0
  }
}

#Preview {
  EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
