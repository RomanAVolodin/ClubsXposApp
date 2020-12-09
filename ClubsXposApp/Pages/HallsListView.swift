//
//  HallsListView.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 09.12.2020.
//

import SwiftUI

struct HallsListView: View {
    @Binding var signInSuccess: Bool
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .center)
                     .ignoresSafeArea()
                
                ScrollView {
                    HStack {
                        Spacer()
                        Text("Halls list View")
                        Spacer()
                    }
                        .padding()
                        .asTile()
                }
                .padding()
            }
            .navigationBarTitle("Welcome")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        UserDetails.clearCurrentUser()
                                        signInSuccess = false
                                    }, label: {
                                        Image(systemName: "person.crop.circle.badge.xmark")
                                        Text("Выход")
                                    })
                                    .foregroundColor(Color(.darkGray))
            )
        }
    }
}

struct HallsListView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
    }
}
