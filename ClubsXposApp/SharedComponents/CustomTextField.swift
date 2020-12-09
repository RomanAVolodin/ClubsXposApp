//
//  CustomTextField.swift
//  ClubsXposApp
//
//  Created by roman on 08.12.2020.
//

import SwiftUI

enum TypeOfCustomTextfield {
    case big, small
}

struct CustomTextField: View {
    let iconName,placeholder: String
    let bindableVariable: Binding<String>
    let isSecured: Bool
    let typeOfInput: TypeOfCustomTextfield
    
    init(iconName: String, placeholder: String, bindableVariable: Binding<String>, isSecured: Bool = false, typeOfInput: TypeOfCustomTextfield = .big) {
        self.iconName = iconName
        self.placeholder = placeholder
        self.bindableVariable = bindableVariable
        self.isSecured = isSecured
        self.typeOfInput = typeOfInput
    }
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
            if isSecured  {
                SecureField(placeholder, text: bindableVariable)
            } else {
                TextField(placeholder, text: bindableVariable)
            }
            Spacer()
        }.font(.system(size: typeOfInput == .big ? 24 : 16, weight: .regular))
        .multilineTextAlignment(.trailing)
        .autocapitalization(.none)
        .padding(typeOfInput == .big ? 16 : 8)
        .background(Color(.init(white: 1, alpha: 0.7)))
        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
        .cornerRadius(12)
    }
}
