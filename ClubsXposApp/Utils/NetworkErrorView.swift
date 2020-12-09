//
//  NetworkErrorView.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 09.12.2020.
//

import SwiftUI

struct NetworkErrorFullscreenView: View {
    let errorMessage: String
    
    init(errorMessage: String = "Ошибка сети") {
        self.errorMessage = errorMessage
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.init(white: 0.8, alpha: 0.6))
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    NetworkErrorView(errorMessage: errorMessage)
                    Spacer()
                }
                Spacer()
            }
    
        }
    }
}

struct NetworkErrorView: View {
    var errorMessage: String
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .font(.system(size: 64, weight: .semibold))
                .foregroundColor(.red)
                .padding()
            Text(errorMessage)
        }
    }
}

struct NetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkErrorFullscreenView()
    }
}
