//
//  libraryAppApp.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 17/05/2022.
//

import SwiftUI
import Firebase
@main
struct libraryAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
