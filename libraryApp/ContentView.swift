//
//  ContentView.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 17/05/2022.
//

import SwiftUI
import Firebase
struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        VStack {
            if logStatus {
                Text("Zostałeś zalogowany poprawnie")
                
                Button("Wyloguj") {
                    try? Auth.auth().signOut()
                    logStatus = false
                }
            } else {
                HomeView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
