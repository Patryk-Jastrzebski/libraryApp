//
//  SettingsView.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 26/05/2022.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    @State var userEmail: String? = Auth.auth().currentUser?.email
    var body: some View {
        Form {
            Section(header: Text("Użytkownik: \(userEmail!)")) {
                Button(action: {
                    try? Auth.auth().signOut()
                    logStatus = false
                }, label: {
                    Text("Wyloguj")
                        .foregroundColor(.red)
                })
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }.navigationTitle("Ustawienia")
    }
}
