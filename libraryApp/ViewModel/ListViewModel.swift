//
//  ListViewModel.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 26/05/2022.
//

import Combine
import Firebase
import FirebaseDatabaseSwift

import Foundation

class ListViewModel: ObservableObject {
    @Published var games = [Game]()
    @Published var editGame: Game?
    private let ref = Database.database(url: "https://libraryapp-81b15-default-rtdb.europe-west1.firebasedatabase.app").reference()
    private let dbPath = "games"
    
    init() {
        initListener()
    }
    
    func initListener() {
        let userID: String? = Auth.auth().currentUser?.uid
        if userID == nil { return }
        ref.child(dbPath).child(userID!).observe(.value) { snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            self.games = children.compactMap { snapshot in
                        return try? snapshot.data(as: Game.self)
            }
        }
    }
    
    func addGame(game_name: String, game_completed: Bool, game_creator: String, game_type: String, game_progress: Double) {
        let userID: String? = Auth.auth().currentUser?.uid
        guard let autoId = ref.child(dbPath).child(userID!).childByAutoId().key else {
            return
        }
        
        let game = Game(id: autoId, name: game_name, progress: game_progress, completed: game_completed, creator: game_creator, type: game_type)
        
        do {
            try ref.child("\(dbPath)/\(userID!)/\(game.id)")
                .setValue(from: game)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func editGame(id: String, game_name: String, game_completed: Bool, game_creator: String, game_type: String, game_progress: Double) {
        let userID: String? = Auth.auth().currentUser?.uid
        ref.child("\(dbPath)/\(userID!)/\(id)")
            .updateChildValues([
                "completed": game_completed,
                "creator": game_creator,
                "name": game_name,
                "progress": game_progress,
                "type": game_type
            ])
    }
    
    func remove(id: String) {
        let userID: String? = Auth.auth().currentUser?.uid
        ref.child("\(dbPath)/\(userID!)/\(id)").setValue(nil)
    }
    
    
}
