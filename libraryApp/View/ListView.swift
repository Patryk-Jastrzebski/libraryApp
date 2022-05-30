//
//  ListView.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 26/05/2022.
//

import SwiftUI
import Firebase

struct ListView: View {
    
    @AppStorage("log_status") var logStatus: Bool = false
    @State var userName: String? = Auth.auth().currentUser?.email
    @State var addGame: Bool = false
    @EnvironmentObject private var viewModel: ListViewModel
    
    var body: some View {
            /*Button("Wyloguj") {
                try? Auth.auth().signOut()
                logStatus = false
            }*/
    
        NavigationView {
        ZStack {
            VStack{
                HStack {
                    NavigationLink(destination: SettingsView(), label: {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 20.0, weight: .bold))
                    })
                    Spacer()
                    Text("Biblioteka")
                        .font(.system(size: 20.0, weight: .bold))
                    Spacer()
                    Button(action: {
                        addGame = true }, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20.0, weight: .bold))
                    })
                }
                .padding(.horizontal, 15.0)
                List {
                    ForEach(viewModel.games, id: \.id) { game in
                        GameRowView(game: game)
                    }.onDelete(perform: deleteRow)
                }.animation(.default)
                    .task {
                        viewModel.initListener()
                    }
            }
        }.hiddenNavigationBarStyle()
                .navigationBarHidden(true)
            .sheet(isPresented: $addGame, content: { AddRowView() })}
        
        
    }
    private func deleteRow(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let rowId = viewModel.games[index].id
        viewModel.remove(id: rowId)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
