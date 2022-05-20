//
//  LoginView.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 17/05/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State var loginView: Bool = false
    @State var registerView: Bool = false
    
    var body: some View {
        let width = UIScreen.main.bounds.width
        ZStack {
            backgroundStyle()
            VStack {
                Text("Witaj w Bibliotece pełnej wrażeń.")
                    .font(.system(size: 40, weight: .bold))
                
                Text("Dodawaj i oceniaj gry w które już zagrałeś. Udostępniaj swoją opinię innym.")
                    .fontWeight(.semibold)
                    .padding(.top)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: width / 1.4, height: 270)
                        .padding(.top)
                    
                    Image("games")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.35)
                        .shadow(radius: 90)
                }
                Spacer()
                    .frame(height: 20)
                
                Button(action: {
                    loginView = true
                }, label: {
                    Text("Zaloguj")
                        .font(.title3.bold())
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(
                            Color.blue
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        )
                })
                    .padding(.horizontal, 50)
                    .padding(.vertical, 20)
                
                
                Button(action: {
                    registerView = true
                }, label: {
                    Text("Nie posiadasz konta? Zarejestruj się.")
                        .font(.footnote.bold())
                })
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .sheet(isPresented: $loginView, content: {LoginView()})
            .sheet(isPresented: $registerView, content: {RegisterView()})
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            
    }
}

struct backgroundStyle: View {
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [Color("BG1"),Color("BG2")],
                startPoint: .top,
                endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                Circle()
                    .fill(Color("Purple"))
                    .padding(50)
                    .blur(radius: 120)
                    .offset(x: -size.width / 1.8, y: -size.height / 5)
                
                Circle()
                    .fill(Color("LightBlue"))
                    .padding(50)
                    .blur(radius: 120)
                    .offset(x: size.width / 1.8, y: -size.height / 2)
                
                Circle()
                    .fill(Color("LightBlue"))
                    .padding(100)
                    .blur(radius: 110)
                    .offset(x: size.width / 1.8, y: size.height / 2)
            }
        }

    }
}
