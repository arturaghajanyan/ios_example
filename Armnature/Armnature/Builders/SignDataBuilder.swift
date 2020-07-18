//
//  SignDataBuilder.swift
//  Armnature
//
//  Created by Arthur on 5/26/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation

final class SignDataBuilder {

    static func createSignInPageData() -> SignStructure {
        let title = "Log In"
        let buttontext = "Log in"
        return SignStructure(
            title: title,
            buttonText: buttontext)
    }
    
    static func createSignUpPageData() -> SignStructure {
        let title = "Sign Up"
        let buttontext = "Sign up"
        return SignStructure(
            title: title,
            buttonText: buttontext)
    }
    
    static func createForgotPasswordPageData() -> SignStructure {
           let title = "Forgot Password"
           let buttontext = "Send Message"
           return SignStructure(
               title: title,
               buttonText: buttontext)
    }

}
