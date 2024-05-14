//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rachel Lee on 5/13/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static func createMemoryGame(fromTheme theme: Theme) -> MemoryGame<String> {
        var game = MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
        game.shuffle()
        return game
    }
    
    
    @Published private var model: MemoryGame<String>
    
    init(theme: Theme = Theme.faces) {
        model = EmojiMemoryGame.createMemoryGame(fromTheme: theme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func changeTheme(to newTheme: Theme) {
        model = EmojiMemoryGame.createMemoryGame(fromTheme: newTheme)
    }
    
    enum Theme: String {
        case faces = "Faces"
        case animals = "Animals"
        case weather = "Weather"
        
        var emojis: [String] {
            switch self {
            case .faces:
                return ["😃", "☹️", "🥹", "😂", "😉", "😘", "🤩", "😏", "😏", "😱", "😡", "😭"]
            case .animals:
                return ["🐶", "🐱", "🐭", "🐰", "🐸", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"]
            case .weather:
                return ["🌩️", "🌨️", "🌤️", "☀️", "⛅️", "☁️", "🌧️", "🌦️", "⛈️"]
            }
        }
    }
}
