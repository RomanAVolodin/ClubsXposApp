//
//  ActivityIndicatorView.swift
//  ClubsXposApp
//
//  Created by roman on 09.12.2020.
//

import SwiftUI

struct ActivityIndicatorFullscreenView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.init(white: 0.8, alpha: 0.6))
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    VStack {
                        ActivityIndicatorView()
                        Text("Загрузка...")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
                    Spacer()
                }
                Spacer()
            }
    
        }
    }
}

struct ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.startAnimating()
        aiv.color = .white
        return aiv
    }
    
    typealias UIViewType = UIActivityIndicatorView
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorFullscreenView()
    }
}
