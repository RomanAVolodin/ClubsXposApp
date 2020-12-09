//
//  HallsListView.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 09.12.2020.
//

import SwiftUI

struct HallsListView: View {
    @EnvironmentObject var environment: EnvironmentModel
    
    @ObservedObject var vm = HallsListViewModel()
    
    init(userId: Int) {
        self.vm.load(forUserWithId: userId)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .center)
                     .ignoresSafeArea()
                
                ScrollView {
                    ForEach(vm.halls) { hall in
                        HStack {
                            Spacer()
                            Text(hall.name)
                            Spacer()
                        }
                            .padding()
                            .asTile()
                    }
                  
                }
                .padding()
            }
            .navigationBarTitle("\(environment.user?.username ?? ""). \(environment.user?.hardware_name ?? "")", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        UserDetails.clearCurrentUser()
                                        environment.user = nil
                                    }, label: {
                                        Image(systemName: "person.crop.circle.badge.xmark")
                                        Text("Выход")
                                    })
                                    .foregroundColor(Color(.purple))
            )
        }
    }
}

class HallsListViewModel: ObservableObject {
    @Published var halls = [Hall]()
    @Published var isLoading = false
    @Published var errorMessage = "" {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.errorMessage = ""
            }
        }
    }
    
    func load(forUserWithId: Int) {
        self.isLoading = true
        
        let urlBase = UserDefaults.standard.string(forKey: "serverIP") ?? ""
        let urlString = "http://\(urlBase)/halls?user_id=\(forUserWithId)"
        
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        print(urlString)
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            DispatchQueue.main.async {
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Ошибка сети: \(statusCode)"
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    self.halls = try JSONDecoder().decode([Hall].self, from: data)
                } catch {
                    print("Failed to decode JSON", error)
                    self.errorMessage = error.localizedDescription
                }
                
                self.isLoading = false
            }
            
        }.resume()
        
    }
    
}
