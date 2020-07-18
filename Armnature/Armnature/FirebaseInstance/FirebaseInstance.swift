//
//  FirebaseInstance.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

final class FirebaseInstance {
    var ref: DatabaseReference!
    
    public func getCurrentUserData() -> UserData {
        var carUser: UserData!
        if let user = Auth.auth().currentUser {
            let uuu = user.uid
            ref = Database.database().reference()
            ref.child("users").child(uuu).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                carUser = UserData(email: value?["email"] as? String ?? "", password: value?["password"] as? String ?? "", firstName: value?["firstName"] as? String ?? "", lastName: value?["lastName"] as? String ?? "", city: value?["city"] as? String ?? "")
                }
            )
        }
        return carUser
    }
    
}
