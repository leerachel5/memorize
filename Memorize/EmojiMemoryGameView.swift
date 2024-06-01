//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Rachel Lee on 5/13/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            title
            cards
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
            themes
        }
        .padding()
    }
    
    private var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.orange)
    }
    
    private func themeSelector(toTheme newTheme: EmojiMemoryGame.Theme, image: Image) -> some View{
        VStackLabeledButton(label: newTheme.rawValue, image: image) {
            viewModel.changeTheme(to: newTheme)
        }
    }
    
    private var themes: some View {
        HStack(spacing: 50) {
            themeSelector(toTheme: .faces, image: Image(systemName: "face.smiling"))
            themeSelector(toTheme: .animals, image: Image(systemName: "hare"))
            themeSelector(toTheme: .weather, image: Image(systemName: "sun.max"))
        }
        .font(.largeTitle)
    }
}

struct VStackLabeledButton: View {
    let label: String
    let image: Image?
    let action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            if let buttonAction = action {
                buttonAction()
            }
        }, label: {
            VStack {
                if let buttonImage = image {
                    buttonImage
                }
                Text(label).font(.body)
            }
        })
    }
}

struct CardView: View {
    private let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
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
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
























struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
