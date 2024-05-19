//
//  StanfordLectureApp.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 4/10/24.
//

import SwiftUI

@main
struct StanfordLectureApp: App {
  @StateObject var game = EmojiMemoryGame()
  
  var body: some Scene {
    WindowGroup {
      EmojiMemoryGameView(viewModel: game)
    }
  }
}
