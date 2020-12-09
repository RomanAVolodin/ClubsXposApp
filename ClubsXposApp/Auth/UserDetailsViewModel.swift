//
//  UserDetailsViewModel.swift
//  ClubsXposApp
//
//  Created by roman on 09.12.2020.
//

import SwiftUI


class UserDetailsViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var user: UserDetails?
    @Published var errorMessage = ""
    
    func login(complete: @escaping () -> Void) {
        
        self.isLoading = true
        
        let urlBase = UserDefaults.standard.string(forKey: "serverIP") ?? ""
        let urlString = "http://\(urlBase)/auth/user"
        
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return
            
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Bad Status: \(statusCode)"
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    self.user = try JSONDecoder().decode(UserDetails.self, from: data)
                } catch {
                    print("Failed to decode JSON", error)
                    self.errorMessage = error.localizedDescription
                }
                
                self.isLoading = false
                
                complete()
            }
            
        }.resume()
        
    }
    
}
