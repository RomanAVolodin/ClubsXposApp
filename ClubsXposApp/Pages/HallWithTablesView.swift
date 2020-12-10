//
//  HallWithTablesView.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 10.12.2020.
//

import SwiftUI

struct HallWithTablesView: View {
    let hall: Hall
    
    @EnvironmentObject var environment: EnvironmentModel
    @ObservedObject var vm: HallsWithTablesViewModel
    
    init(hall: Hall, userId: Int) {
        self.hall = hall
        self.vm = HallsWithTablesViewModel()
        self.vm.load(forUserWithId: userId, andHallId: hall.id)
    }
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.2341042757, green: 0.8307061791, blue: 0.9462192655, alpha: 0.7357229313)).ignoresSafeArea()
            
            ScrollView {
                ForEach(vm.tables) { table in
                    TableView(forTable: table)
                        .padding()
                }
            }
        }
        .navigationTitle(hall.name)
        .onDisappear {
            self.vm.gameTimer?.invalidate()
        }
    }
}


class HallsWithTablesViewModel: ObservableObject {
    @Published var tables = [Table]()
    @Published var isLoading = false
    @Published var errorMessage = "" {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.errorMessage = ""
            }
        }
    }
    
    @Published var gameTimer: Timer?
    
    @objc fileprivate func fetchTablesFromServer(_ request: URLRequest, _ urlString: String) {
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            DispatchQueue.main.async {
                print("Loaded from url", urlString)
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Ошибка сети: \(statusCode)"
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    self.tables = try JSONDecoder().decode([Table].self, from: data)
                } catch {
                    print("Failed to decode JSON", error)
                    self.errorMessage = error.localizedDescription
                }
                
                self.isLoading = false
            }
        }.resume()
    }
    
    func load(forUserWithId: Int, andHallId hallId: Int) {
        
        self.isLoading = true
        
        let urlBase = UserDefaults.standard.string(forKey: "serverIP") ?? ""
        let urlString = "http://\(urlBase)/halls/tables-in-hall?personal_id=\(forUserWithId)&hall_id=\(hallId)"
        
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        
        fetchTablesFromServer(request, urlString)
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.fetchTablesFromServer(request, urlString)
        })
    
    }
}

struct HallWithTablesView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
        
        HallWithTablesView(hall: .init(id: 111409, name: "My Hall", show_tables_total: true, delete_empty_bill: true, isGuests: true), userId: 85321)
    }
}
