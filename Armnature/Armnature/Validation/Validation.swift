//
//  Validation.swift
//  Armnature
//
//  Created by Arthur on 5/31/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation

class Validation {

    enum Constants {
            static let password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
            static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            static let text = "^\\w{3,18}$"
    }
  
      public func validate(textInInput: String, regex: String) -> Bool {
          let passRegEx = regex == "email" ? Constants.email : regex == "password" ? Constants.password : Constants.text
          let trimmedString = textInInput.trimmingCharacters(in: .whitespaces)
          let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
          let isvalidatePass = validatePassord.evaluate(with: trimmedString)
          return isvalidatePass
      }
     
}
