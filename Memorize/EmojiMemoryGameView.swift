//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Rachel Lee on 5/13/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            themes
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
    
    func themeSelector(toTheme newTheme: EmojiMemoryGame.Theme, image: Image) -> some View{
        VStackLabeledButton(label: newTheme.rawValue, image: image) {
            viewModel.changeTheme(to: newTheme)
        }
    }
    
    var themes: some View {
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
            if action != nil {
                action!()
            }
        }, label: {
            VStack {
                if image != nil {
                    image
                }
                Text(label).font(.body)
            }
        })
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
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
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}
























struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
