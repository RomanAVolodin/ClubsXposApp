//
//  User.swift
//  ClubsXposApp
//
//  Created by roman on 09.12.2020.
//

import SwiftUI

struct UserDetails: Identifiable, Decodable {
    let id: Int
    let username, dolzhnost_name, hardware_name: String
    let safe_actions: [SafeAction]
    
    func isActionAllowed(actionId: Int) -> Bool {
        for act in safe_actions {
            if act.id == actionId {
                return true
            }
        }
        return false
    }
}

struct SafeAction: Decodable {
    let id: Int
    let name: String
}
