//
//  Game.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 26/05/2022.
//

import SwiftUI

struct Game: Identifiable, Codable{
    var id: String
    var name: String
    var progress: Double
    var completed: Bool
    var creator: String
    var type: String
}
