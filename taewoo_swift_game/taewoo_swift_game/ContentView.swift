//
//  ContentView.swift
//  taewoo_swift_game
//
//  Created by 권태우 on 2021/07/09.
//

import SwiftUI


struct ContentView: View {
    let prefix: String
    @ObservedObject var game = MemoryGame()
    @State var showsRestartAlert = false
    @Environment(\.presentationMode) var present
    var body: some View {
        VStack {
            Text("MEMORY..JIK")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .background(Rectangle().fill(Color.white).opacity(0.3))
                .padding()
            GridStack(rows: MemoryGame.rows, columns: MemoryGame.cols) { row, col in
                let card = game.card(row: row, col: col)
                if card.cardState == .removed {
                    Image("removed")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 70, height: 70)
                        .opacity(0.5)
                } else {
                    let gesture = card.cardState == .open ? nil : TapGesture()
                        .onEnded { _ in
                            game.toggle(row: row, col: col)
                            if game.count == 0 {
                                showsRestartAlert = true
                            }
                        }
                    CardView(prefix: prefix, number: card.number, open:     card.cardState == .open)
                        .gesture(gesture)
                }
            }
            .padding(.horizontal)
            .aspectRatio(CGSize(width: MemoryGame.cols, height: MemoryGame.rows), contentMode: ContentMode.fit)
            Text("Flips: \(game.flips)")
//                .background(Rectangle().fill(Color.white).opacity(0.3))
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    present.wrappedValue.dismiss()
                }) {
                    Text("Back")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(Color.white).opacity(0.3))
                }
                Spacer()
                Button(action: { showsRestartAlert = true }) {
                    Text("Restart")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(Color.white).opacity(0.3))
                }
                Spacer()
            }
            Spacer()
        }
        .background(
            Image("bg")
                .resizable(resizingMode: .stretch)
            .edgesIgnoringSafeArea(.all)
        ).alert(isPresented: $showsRestartAlert) {
            Alert(
                title: Text("Restart?"),
                message: Text("You just flipped \(game.flips) times\nDo you want to restart the game?"),
                primaryButton: .default(Text("Restart")) {
                    game.start()
                },
                secondaryButton: .cancel()
            )
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(prefix: "f")
    }
}
