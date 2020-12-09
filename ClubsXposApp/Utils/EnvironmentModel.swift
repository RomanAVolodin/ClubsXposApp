//
//  Environment.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 09.12.2020.
//

import SwiftUI

class EnvironmentModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var user: UserDetails?
    @Published var terminalId: String?
    @Published var hallId: String?
}
