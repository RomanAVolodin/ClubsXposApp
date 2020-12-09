//
//  AppContentView.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 09.12.2020.
//

import SwiftUI

struct AppContentView: View {

    @EnvironmentObject var environment: EnvironmentModel
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(white: 0.3, alpha: 1)
        ]
    }
    
    var body: some View {
        if let userId = environment.user?.id {
            HallsListView(userId: userId)
        }
        else {
            LoginPageView()
        }
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
    }
}
