//
//  GameDetailsView.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 26/05/2022.
//

import SwiftUI

struct GameEditView: View {
            @State var gameEditing: Game
            @EnvironmentObject var viewModel: ListViewModel
            var typeOfGame: [String] = ["Zręcznościowe", "Przygodowe", "Fabularne", "Strategiczne", "Symulacyjne", "Sportowe", "Logiczne", "Edukacyjne"]
            @State private var selectedType = "Przygodowe"
            @State private var gameName = ""
            @State private var gameCompleted = "Ukończona"
            @State private var creator = ""
            @State private var progress = 0.0
    
            @Namespace var animation
            @Environment(\.dismiss) private var dismiss
            @Environment(\.self) var env
            var body: some View {

                VStack(spacing: 12) {
                    Text("Edycja")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Rodzaj gry")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Picker("Wybierz", selection: $selectedType) {
                            ForEach(typeOfGame, id: \.self) {
                                Text($0)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Nazwa gry")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField("", text: $gameName)
                            .frame(maxWidth: .infinity)
                            .padding(5)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        gameName == "" ? Color.black.opacity(0.05) : Color(.gray).opacity(0.2)
                                    )
                            }
                            .padding(.top, 10)
                    }
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Twórca")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField("", text: $creator)
                            .padding(5)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        creator == "" ? Color.black.opacity(0.05) : Color(.gray).opacity(0.2)
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 10)
                            
                        
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Progres")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Slider(value: $progress, in: 1...100, step: 1)
                        HStack {
                        Text(
                            String(format: "%.0f", progress)
                        )
                        Text("%")
                        }
                    }
                    
                    Divider()
                    
                    let gameComp: [String] = ["Ukończona", "Nieukończona"]
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ukończenie")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 12) {
                            ForEach(gameComp, id: \.self) {type in
                                Text(type)
                                    .font(.callout)
                                    .padding(.vertical,8)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(gameCompleted == type ? .white : .black)
                                    .background{
                                        if gameCompleted == type {
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "TYPE", in: animation)
                                        } else {
                                            Capsule()
                                                .strokeBorder(.black)
                                        }
                                    }
                                    .contentShape(Capsule())
                                    .onTapGesture {
                                        withAnimation{gameCompleted = type}
                                    }
                            }
                        }
                        Button(action: {
                            
                            viewModel.editGame(id: gameEditing.id,game_name: gameName, game_completed: gameCompleted == "Ukończona" ? true : false, game_creator: creator, game_type: selectedType, game_progress: progress)
                            dismiss()
                        }, label: {
                            Text("Edytuj")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .foregroundColor(.white)
                                .background{
                                    Capsule()
                                        .fill(.black)
                                }
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .padding(.bottom, 10)
                        })
                            .disabled(gameName == "")
                            .opacity(gameName == "" ? 0.5 : 1)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
                .onAppear {
                    selectedType = gameEditing.type
                    gameName = gameEditing.name
                    gameCompleted = gameEditing.completed ? "Ukończona" : "Nieukończona"
                    creator = gameEditing.creator
                    progress = gameEditing.progress
                }
            }
            
        }

struct GameEditView_Previews: PreviewProvider {
    static var previews: some View {
        let gameEditing = Game(id: "autoId", name: "game_name", progress: 0, completed: true, creator: "game_creator", type: "game_type")
        return
        NavigationView {
            GameEditView(gameEditing: gameEditing)
        }
    }
}
