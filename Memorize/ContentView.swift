//
//  ContentView.swift
//  Memorize
//
//  Created by Rachel Lee on 5/13/24.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount: Int = 4
    @State var theme: Theme = .halloween
    
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: theme.emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var themeSelector: some View {
        VStack(spacing: 0) {
            Text("Select Theme: ")
            Picker(selection: $theme, label: Text("Theme")) {
                ForEach(Theme.allCases) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
        }
    }
}


enum Theme : String, CaseIterable, Identifiable {
    case halloween = "Halloween"
    case christmas = "Christmas"
    case easter = "Easter"
    
    var emojis: [String] {
        switch self {
        case .halloween:
            return ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
        case .christmas:
            return ["🎄", "🎅", "🇨🇽", "🦌", "⛄️", "❄️", "🏂", "🍧", "🌨️", "🎁", "🤶", "🎿"]
        case .easter:
            return ["🥚", "🐰", "🐇", "🧺", "🧆", "🥙", "🐤", "🐣", "🐥", "🏃", "👀", "🕵️"]
        }
    }
    
    var id: String { self.rawValue }
}


struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
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
