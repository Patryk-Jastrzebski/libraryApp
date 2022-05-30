//
//  GameRowView.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 26/05/2022.
//

import SwiftUI

struct GameRowView: View {
    
    @EnvironmentObject private var viewModel: ListViewModel
    
    let game: Game
    
    var body: some View {
        NavigationLink(destination: GameEditView(gameEditing: game)) {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(game.name)
                        .font(.system(size:20.0, weight: .bold, design: .rounded))
                    Text(game.creator)
                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
                    HStack(alignment: .center) {
                        Image(systemName: "link")
                        Text(game.type)
                    }
                    .font(.system(size: 16.0, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                }
                Spacer()
                Text("\(String(Int(game.progress)))%")
                    .font(.system(size: 26.0, weight: .bold, design: .rounded))
                
            }
            Text(game.completed ? "Ukończone" : "Nieukończone")
                .foregroundColor(game.completed ? .green : .red)
        }
        }}
}
