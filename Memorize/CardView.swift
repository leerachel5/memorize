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
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay (
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor: CGFloat = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
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
