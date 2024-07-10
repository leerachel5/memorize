//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rachel Lee on 5/13/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame(fromTheme theme: Theme) -> MemoryGame<String> {
        let game = MemoryGame(numberOfPairsOfCards: 2) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
        return game
    }
    
    
    @Published private var model: MemoryGame<String>
    
    init(theme: Theme = Theme.faces) {
        model = EmojiMemoryGame.createMemoryGame(fromTheme: theme)
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        .orange
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
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
            case .faces: return ["😃", "☹️", "🥹", "😂", "😉", "😘", "🤩", "😏", "😏", "😱", "😡", "😭"]
            case .animals: return ["🐶", "🐱", "🐭", "🐰", "🐸", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"]
            case .weather: return ["🌩️", "🌨️", "🌤️", "☀️", "⛅️", "☁️", "🌧️", "🌦️", "⛈️"]
            }
        }
    }
}
