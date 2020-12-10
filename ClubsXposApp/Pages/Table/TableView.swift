//
//  TableView.swift
//  ClubsXposApp
//
//  Created by Roman Vol on 10.12.2020.
//

import SwiftUI

struct TableView: View {
    let table: Table
    init(forTable table: Table) {
        self.table = table
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(String(table.number))
                Spacer()
                Text("Стол")
            }
            Divider()
            
            ForEach(table.bills) { bill in
                BillInTableView(bill: bill)
                    .asTile()
            }
            
            HStack {
                Text(table.total)
                    .foregroundColor(Color(#colorLiteral(red: 0.5209687352, green: 0.3359449208, blue: 0.7861967683, alpha: 1)))
                Spacer()
                
                Button(action: {}, label: {
                    ZStack(alignment: .center) {
                        Color(#colorLiteral(red: 0.5209687352, green: 0.3359449208, blue: 0.7861967683, alpha: 1))
                            .frame(width: 48, height: 48)
                            .cornerRadius(100)
                            .shadow(radius: 4)
                        
                        Image(systemName: "doc.badge.plus")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                })
            }
        }
       
            .padding()
            .asTile()
    }
}

struct BillInTableView: View {
    @EnvironmentObject var environment: EnvironmentModel
    let bill: TableBill
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Счет № \(bill.number)")
                    .font(.system(size: 14, weight: .semibold))
                
                if bill.editingHardwareID > 0, let openedBy = String(bill.editingHardwareID) {
                    Text("открыт на \(openedBy)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.primary)
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            
            Text(bill.personalName ?? "")
                .font(.system(size: 14, weight: .regular))
                .padding(8)
            
            HStack {
                Image("waiter")
                    .resizable()
                    .frame(width: 64, height: 80)
                    .scaledToFit()
                Spacer()
                Text(bill.clientsName ?? "")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding(8)
                Spacer()
            }
        }
        .padding(.top, 8)
        .background(bill.editingHardwareID == 0 ? Color(#colorLiteral(red: 0.7588848472, green: 0.8678822517, blue: 0.9461668134, alpha: 1)) : Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0.7894476232)))
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(forTable: .init(id: 123794, number: 227, total: "330,00 ₽", bills: [
            .init(id: 1, isPrinted: false, guests: 4, isOpened: true, editingHardwareID: 0, number: 24, total: "456 000", personalName: "Roman volodin", personal_id: 12234, clientsName: "Alex Pushkin", clientsGroup: "Hunter 15", total_discount: "124000", total_payment: "123 000", opened: "12-12-2020")
        ]))
    }
}
