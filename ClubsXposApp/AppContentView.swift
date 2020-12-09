//
//  AppContentView.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 09.12.2020.
//

import SwiftUI

struct AppContentView: View {
    
    @State var signInSuccess = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.lightText
        ]
    }
    
    var body: some View {
        return Group {
            if signInSuccess {
                HallsListView(signInSuccess: $signInSuccess)
            }
            else {
                LoginPageView(signInSuccess: $signInSuccess)
            }
        }
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
    }
}
