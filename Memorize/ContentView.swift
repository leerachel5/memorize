//
//  ContentView.swift
//  Memorize
//
//  Created by Rachel Lee on 5/13/24.
//

import SwiftUI

struct ContentView: View {
    @State var theme: Theme = .faces
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            themeSelector
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }
    
    var cards: some View {
        let deck = getDeck(fromTheme: theme)
        
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(deck.indices, id: \.self) { index in
                CardView(content: deck[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func getDeck(fromTheme theme: Theme) -> [String] {
        var uniqueCardValues = Set<String>()
        while uniqueCardValues.count < theme.cardPairsCount {
            uniqueCardValues.insert(theme.emojis.randomElement()!)
        }
        let allCardValues: [String] = Array(uniqueCardValues) + Array(uniqueCardValues)
        return allCardValues.shuffled()
    }
    
    var themeSelector: some View {
        HStack(spacing: 50) {
            VStackLabeledButton(label: "Faces", image: Image(systemName: "face.smiling")) {
                theme = Theme.faces
            }
            VStackLabeledButton(label: "Animals", image: Image(systemName: "hare")) {
                theme = Theme.animals
            }
            VStackLabeledButton(label: "Weather", image: Image(systemName: "sun.max")) {
                theme = Theme.weather
            }
        }
        .font(.largeTitle)
    }
}


enum Theme : String, CaseIterable, Identifiable {
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
    
    var cardPairsCount: Int {
        switch self {
        case .faces:
            return 6
        case .animals:
            return 5
        case .weather:
            return 4
        }
    }
    
    var id: String { self.rawValue }
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
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
