//
//  SettingsView.swift
//  ClubsXposApp
//
//  Created by roman on 09.12.2020.
//

import SwiftUI

struct SettingsView: View {
    
    var complete: () -> ()
    
    @State public var serverIP: String = UserDefaults.standard.string(forKey: "serverIP") ?? ""
    @State public var hardwareID: String = UserDefaults.standard.string(forKey: "hardwareID") ?? ""
    @State public var secondsTillFade: String = UserDefaults.standard.string(forKey: "secondsTillFade") ?? "60"
    @State public var clubName: String = UserDefaults.standard.string(forKey: "clubName") ?? ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            CustomTextField(iconName: "gear", placeholder: "Адрес сервера", bindableVariable: $serverIP)
                .padding(.horizontal)
                .padding(.top)
            CustomTextField(iconName: "ellipsis.circle", placeholder: "ID терминала", bindableVariable: $hardwareID)
                .padding(.horizontal)
            CustomTextField(iconName: "timer", placeholder: "Время до отключения, сек", bindableVariable: $secondsTillFade)
                .padding(.horizontal)
            Picker("TEST", selection: $clubName) {
                Text("Penthouse").tag("penthouse")
                Text("Hunter").tag("hunter")
                Text("Loft").tag("loft")
                Text("Aurora").tag("aurora")
                Text("Orl911").tag("orlenok")
            }.pickerStyle(SegmentedPickerStyle())
            .padding()
                .padding(.horizontal)
                .padding(.bottom)
            
            HStack {
                Button(action: {
                    complete()
                }, label: {
                    Text("Отмена")
                        .padding()
                }).background(Color(white: 0.8))
                .foregroundColor(.black)
                .cornerRadius(5)
                .shadow(radius: 3)
                
                Spacer()
                
                Button(action: {
                    saveSettings()
                }, label: {
                    Text("Запомнить")
                        .padding()
                }).background(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 3)
                
            }.padding(.bottom)
            .padding(.horizontal)
        }
        .background(Color(white: 0.85))
        .cornerRadius(12)
        .shadow(radius: 5)
        .animation(.easeInOut)
        .transition(.move(edge: .leading))
    }
    
    private func saveSettings() {
        UserDefaults.standard.set(serverIP, forKey: "serverIP")
        UserDefaults.standard.set(hardwareID, forKey: "hardwareID")
        UserDefaults.standard.set(secondsTillFade, forKey: "secondsTillFade")
        UserDefaults.standard.set(clubName, forKey: "clubName")
        UserDefaults.standard.set(serverIP, forKey: "serverIP")
        
        complete()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView() {
            print(123)
        }
    }
}
