//
//  RegisterView.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 20/05/2022.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    @State var retypePassword: String = ""
    
    var body: some View {
        VStack {
            Text("Dzień dobry, \nzarejestruj się teraz.")
                .frame(maxWidth: .infinity ,alignment: .leading)
                .font(.largeTitle.bold())
            
            TextField("Login", text: $loginModel.email)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.email == "" ? Color.black.opacity(0.05) : Color(.gray).opacity(0.5)
                        )
                }.textInputAutocapitalization(.never)
                .padding(.top, 20)
            
            SecureField("Hasło", text: $loginModel.password)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.password == "" ? Color.black.opacity(0.05) : Color(.gray).opacity(0.5)
                        )
                }.textInputAutocapitalization(.never)
                .padding(.top, 15)
            
            SecureField("Powtórz hasło", text: $retypePassword)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            retypePassword == "" ? Color.black.opacity(0.05) : Color(.gray).opacity(0.5)
                        )
                }.textInputAutocapitalization(.never)
                .padding(.top, 15)
            
            Button {
                Task {
                    do {
                        try await loginModel.registerUser()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Zarejestruj")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                    }
            }.padding(.top)
                .disabled(loginModel.email == "" || loginModel.password != retypePassword)
                .opacity(loginModel.email == "" || loginModel.password == "" ? 0.5 : 1)
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
        
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
