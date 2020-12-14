//
//  UserDetailsViewModel.swift
//  ClubsXposApp
//
//  Created by roman on 09.12.2020.
//

import SwiftUI


class UserDetailsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage = "" {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.errorMessage = ""
            }
        }
    }
    
    func login(username: String, password: String, hardwareId: String, complete: @escaping (UserDetails, Bool) -> Void) {
        
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
                self.isLoading = false
                if let err = err {
                    self.errorMessage = "Ошибка сети: \(err.localizedDescription)"
                    return
                }
                
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.errorMessage = "Ошибка сети: \(statusCode)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "Проверьте соединение"
                    return
                }
                
                do {
                    let user = try JSONDecoder().decode(UserDetails.self, from: data)
                    let isLoggedIn = true
                    
                    complete(user, isLoggedIn)
                    
                } catch {
                    print("Failed to decode JSON", error)
                    self.errorMessage = error.localizedDescription
                }

            }
            
        }.resume()
        
    }
    
}
