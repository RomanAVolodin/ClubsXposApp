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
    @Published var errorMessage = "" {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.errorMessage = ""
            }
        }
    }
    
    func login(username: String, password: String, hardwareId: String, complete: @escaping () -> Void) {
        
        self.isLoading = true
        
        let urlBase = UserDefaults.standard.string(forKey: "serverIP") ?? ""
        let urlString = "http://\(urlBase)/users/auth"
        
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return        
        }

        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "login=\(username)&password=\(password)&hardware_id=\(hardwareId)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            DispatchQueue.main.async {
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Ошибка сети: \(statusCode)"
                    return
                }
                
                guard let data = data else { return }
                
                print(data)
                
                do {
                    self.user = try JSONDecoder().decode(UserDetails.self, from: data)
                    try UserDefaults.standard.setObject(self.user, forKey: "currentUser")
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
