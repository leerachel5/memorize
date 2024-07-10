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
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            title
            cards
                .foregroundColor(viewModel.color)
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
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
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




















struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
