//
//  User.swift
//  ClubsXposApp
//
//  Created by roman on 09.12.2020.
//

import SwiftUI

struct UserDetails: Identifiable, Codable {
    
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
    
    static func currentUser() -> UserDetails? {
        return try? UserDefaults.standard.getObject(forKey: "currentUser", castTo: UserDetails.self)
    }
    
    static func clearCurrentUser() -> Void {
        UserDefaults.standard.set(nil, forKey: "currentUser")
    }
    
    static func hardwareID() -> String {
        return UserDefaults.standard.string(forKey: "hardwareID") ?? ""
    }
}

struct SafeAction: Codable {
    let id: Int
    let name: String
}
