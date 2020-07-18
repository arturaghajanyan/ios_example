//
//  SigninViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/11/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

final class SigninViewModel {
    
    struct Input {
        let checkUserValid = PublishRelay<Void>()
        let selectLoginButton = PublishRelay<Void>()
        let selectCreateAccauntButton = PublishRelay<Void>()
        let selectForgotPasswordButton = PublishRelay<Void>()
        let selectShowPasswordButton = PublishRelay<Void>()
    }
    
    struct Output {
        fileprivate(set) var titleText: Driver<String> = .never()
        fileprivate(set) var signInButtonText: Driver<String> = .never()
        fileprivate(set) var checkUserValid: Signal<Void> = .never()
        fileprivate(set) var showLoginPage: Signal<Void> = .never()
        fileprivate(set) var showSignUpPage: Signal<Void> = .never()
        fileprivate(set) var showForgotPasswordPage: Signal<Void> = .never()
        fileprivate(set) var selectShowPasswordButton: Signal<Void> = .never()
    }
    
    let input: Input = Input()
    private(set) var output: Output = Output()
    
    init(data: SignStructure) {        
        output.titleText = .just(data.title)
        
        output.signInButtonText = .just(data.buttonText)
        
        output.showLoginPage = input.selectLoginButton.asObservable()
            .asSignal(onErrorSignalWith: .never())
        
        output.showSignUpPage = input.selectCreateAccauntButton.asObservable()
            .asSignal(onErrorSignalWith: .never())
        
        output.showForgotPasswordPage = input.selectForgotPasswordButton.asObservable()
            .asSignal(onErrorSignalWith: .never())
        
        output.selectShowPasswordButton = input.selectShowPasswordButton.asObservable()
            .asSignal(onErrorSignalWith: .never())
    }
    
}
