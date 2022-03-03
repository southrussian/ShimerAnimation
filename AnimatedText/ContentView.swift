//
//  ContentView.swift
//  AnimatedText
//
//  Created by Danil Peregorodiev on 03.03.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var multiColor = false
    
    var body: some View {
        
        VStack(spacing: 25) {
            TextShimer(multiColors: $multiColor, text: "South.Russian")
            
            Toggle(isOn: $multiColor, label: {
                Text("Разноцветный режим")
                .font(.title3)
                .fontWeight(.bold)
            })
            .padding()
                
        }
        .preferredColorScheme(.dark)
    }
}

struct TextShimer: View {
    @State var animation: Bool = false
    @Binding var multiColors: Bool
    var text: String
    var body: some View {
        
        ZStack {
            Text(text)
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(Color.white.opacity(0.25))
            
            HStack(spacing: 0) {
                ForEach(0..<text.count, id: \.self) { index in
                    
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .foregroundColor(multiColors ? randomColor() : Color.white)
                }
            }
            .mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: .init(colors:[Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.init(degrees: 70))
                    .padding(20)
                    .offset(x: 250)
                    .offset(x: animation ? 500 : 0)
            )
            .onAppear(perform: {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    
                    animation.toggle()
                }
            })
        }
    }
    func randomColor()->Color {
        let color = UIColor(red: 1, green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        return Color(color)
    }
}
