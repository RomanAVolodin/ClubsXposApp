//
//  Table.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 10.12.2020.
//

import SwiftUI

struct Table: Decodable, Identifiable {
    let id: Int
    let number: Int
    let total: String
    let bills: [TableBill]
}

struct TableBill: Decodable, Identifiable {
    let id: Int
    let isPrinted: Bool
    let guests: Int
    let isOpened: Bool
    let editingHardwareID: Int
    let number: Int
    let total: String?
    let personalName: String?
    let personal_id: Int?
    let clientsName: String?
    let clientsGroup: String?
    let total_discount: String?
    let total_payment: String?
    let opened: String?
}

