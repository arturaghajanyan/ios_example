//
//  SignPageDataModel.swift
//  Armnature
//
//  Created by Arthur on 5/26/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

struct SignStructure {
    let title: String
    let buttonText: String
}

struct UserData: Codable {
    
    static var currentUser: UserData!
    
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let city: String
    
    static func getCurrentUser() -> UserData? {
        return currentUser
    }
    
    static func setCurrentUser(user: UserData) {
        if currentUser == nil {
            currentUser = UserData(email: user.email, password: user.password, firstName: user.firstName, lastName: user.lastName, city: user.city)
        }
    }
    
    static func clearCurrentUser() {
        currentUser = nil
    }
    
}
