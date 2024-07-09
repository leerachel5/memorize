//
//  CardView.swift
//  Memorize
//
//  Created by Rachel Lee on 7/8/24.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    private let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}




struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card(isFaceUp: true, content: "🐼", id: "1a"))
                CardView(Card(content: "🐼", id: "1a"))
            }
            HStack {
                CardView(Card(isFaceUp: true, isMatched: true, content: "This is a very long string and I really hope it fits inside this card.", id: "1a"))
                CardView(Card(  isMatched: true, content: "🐼", id: "1a"))
            }
        }
        .padding()
        .foregroundStyle(.orange)
    }
}
