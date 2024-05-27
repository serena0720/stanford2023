//
//  FlyingNumber.swift
//  StanfordLecture
//
//  Created by Hyun A Song on 5/27/24.
//

import SwiftUI

struct FlyingNumber: View {
  let number: Int
  
  @State private var offset: CGFloat = -50
  
  var body: some View {
    if number != 0 {
      Text(number, format: .number.sign(strategy: .always()))
        .font(.largeTitle)
        .foregroundColor(number < 0 ? .red : .mint)
        .shadow(color: .black, radius: 1.5, x: 1, y: 1)
        .offset(x: 0, y: offset)
//        .opacity(offset != 0 ? 0 : 1)
        .opacity(offset != 0 ? 1 : 0) // ????????????????
        .onAppear {
          withAnimation(.easeIn(duration: 1)) {
            offset = number < 0 ? 200 : -200
          }
        }
        .onDisappear {
          offset = 0
        }
    }
  }
}
