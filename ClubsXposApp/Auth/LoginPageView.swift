//
//  LoginPageView.swift
//  ClubsXposApp
//
//  Created by roman on 08.12.2020.
//

import SwiftUI

struct LoginPageView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.lightText
        ]
    }
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var settingsPassword: String = ""
    @State private var isSettingsShown: Bool = false
    @State private var isPasswordForSettingsShown: Bool = false
    
    
    @ObservedObject var vm = UserDetailsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue, Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]), startPoint: .top, endPoint: .trailing)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 16) {
                    CustomTextField(iconName: "person.circle", placeholder: "Имя пользователя", bindableVariable: $login)
           
                    CustomTextField(iconName: "lock", placeholder: "Пароль", bindableVariable: $password, isSecured: true)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            logInToSystem()
                        }, label: {
                            Text("Войти в систему")
                                .padding()
                        }).background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(100)
                        .shadow(radius: 8)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            isPasswordForSettingsShown.toggle()
                        }, label: {
                            Image(systemName: "gear")
                                .font(.system(size: 24, weight: .semibold))
                                .padding()
                        }).background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(100)
                        .shadow(radius: 8)
                        
                        if isPasswordForSettingsShown && !isSettingsShown {
                            CustomTextField(iconName: "lock.shield", placeholder: "пароль для настроек", bindableVariable: $settingsPassword, isSecured: true, typeOfInput: .small)
                                .animation(.easeInOut)
                                .transition(.move(edge: .trailing))
                                .onChange(of: settingsPassword, perform: { value in
                                    if value == "17112000" {
                                        isSettingsShown = true
                                        settingsPassword = ""
                                        isPasswordForSettingsShown = false
                                    }
                                })
                        }
                    
                    }
                    
                    if vm.isLoading {
                        VStack {
                            ActivityIndicatorView()
                            Text("Loading...")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(8)
                    }
                    
                    if !vm.errorMessage.isEmpty {
                        VStack {
                            Image(systemName: "xmark.octagon")
                                .font(.system(size: 64, weight: .semibold))
                                .foregroundColor(.red)
                                .padding()
                            Text(vm.errorMessage)
                        }
                    }
                    
                }
                .padding(.top, 32)
                .padding(.horizontal, 24)
                
                if isSettingsShown {
                    SettingsView() {
                        isSettingsShown.toggle()
                    }
                }
            
            }.navigationTitle("Xpos clubs")
        }
    }
    
    private func logInToSystem() {
        print("fetching start")
        vm.login() {
            print("fetching comlete")
        }
        
    }
    
}


struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
