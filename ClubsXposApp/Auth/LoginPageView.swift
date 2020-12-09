//
//  LoginPageView.swift
//  ClubsXposApp
//
//  Created by roman on 08.12.2020.
//

import SwiftUI

struct LoginPageView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var settingsPassword: String = ""
    @State private var isSettingsShown: Bool = false
    @State private var isPasswordForSettingsShown: Bool = false

    @ObservedObject var vm = UserDetailsViewModel()
    @EnvironmentObject var environment: EnvironmentModel
    
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
                    
                }
                .padding(.top, 32)
                .padding(.horizontal, 24)
                
                if vm.isLoading {
                    ActivityIndicatorFullscreenView()
                }
                
                if !vm.errorMessage.isEmpty {
                    NetworkErrorFullscreenView(errorMessage: vm.errorMessage)        
                }
                
                if isSettingsShown {
                    SettingsView() {
                        isSettingsShown.toggle()
                    }
                }
            
            }.navigationTitle("Xpos clubs")
        }
    }
    
    private func logInToSystem() {
        vm.login(username: login, password: password, hardwareId: UserDetails.hardwareID()) { (user: UserDetails, isLoggedIn: Bool) in
            environment.user = user
            environment.isLoggedIn = isLoggedIn
            environment.terminalId = UserDetails.hardwareID()
        }
    }
}


struct LoginPageView_Previews: PreviewProvider {
    @State var signInSuccess = false
    
    static var previews: some View {
        AppContentView()
    }
}
