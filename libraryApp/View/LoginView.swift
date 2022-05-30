//
//  LoginView.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 19/05/2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("Hej, \nzaloguj się")
                .frame(maxWidth: .infinity ,alignment: .leading)
                .font(.largeTitle.bold())
            
            TextField("Login", text: $loginModel.email)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.email == "" ? Color.black.opacity(0.05) : Color(.gray).opacity(0.2)
                        )
                }.textInputAutocapitalization(.never)
                .padding(.top, 20)
            
            SecureField("Hasło", text: $loginModel.password)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.password == "" ? Color.black.opacity(0.05) : Color(.gray).opacity(0.2)
                        )
                }.textInputAutocapitalization(.never)
                .padding(.top, 15)
            
            Button {
                Task {
                    do {
                        try await loginModel.loginUser()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Zaloguj")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                    }
            }.padding(.top)
                .disabled(loginModel.email == "" || loginModel.password == "")
                .opacity(loginModel.email == "" || loginModel.password == "" ? 0.5 : 1)
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
