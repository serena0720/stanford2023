//
//  EmojiMemoryGameView.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 4/10/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  
  private let aspectRatio: CGFloat = 2/3
  
  var body: some View {
    VStack {
      cards
        .animation(.default, value: viewModel.cards)
      Button("Shuffle") {
        viewModel.shuffle()
      }
    }
    .padding()
  }
  
  private var cards: some View {
    AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
      if card.id.last == "b" {
        VStack {
          CardView(card)
            .aspectRatio(2/4, contentMode: .fill)
            .padding(4)
            .onTapGesture {
              viewModel.choose(card)
            }
          Text(card.id)
        }
      }
    }
    .foregroundColor(viewModel.color)
  }
}

#Preview {
  EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
