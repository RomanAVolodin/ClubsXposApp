//
//  Hall.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 10.12.2020.
//

import SwiftUI


struct Hall: Decodable, Identifiable {
    let id: Int
    let name: String
    let show_tables_total, delete_empty_bill, isGuests: Bool
}
