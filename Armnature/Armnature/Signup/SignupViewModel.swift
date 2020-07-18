//
//  SignupViewModel.swift
//  Armnature
//
//  Created by Arthur on 5/26/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

final class SignupViewModel {
    
    struct Input {
        let selectSignUpButton = PublishRelay<Void>()
        let selectShowPasswordButton = PublishRelay<Void>()
        let selectBackIcon = PublishRelay<Void>()
    }
    
    struct Output {
        fileprivate(set) var titleText: Driver<String> = .never()
        fileprivate(set) var signUpButtonText: Driver<String> = .never()
        fileprivate(set) var selectSignUpButton: Signal<Void> = .never()
        fileprivate(set) var selectShowPasswordButton: Signal<Void> = .never()
        fileprivate(set) var showSignInPage: Signal<Void> = .never()
    }
    
    let input: Input = Input()
    private(set) var output: Output = Output()
    
    init(data: SignStructure) {        
        output.titleText = .just(data.title)
        
        output.signUpButtonText = .just(data.buttonText)
        
        output.selectSignUpButton = input.selectSignUpButton.asObservable()
            .asSignal(onErrorSignalWith: .never())
        
        output.selectShowPasswordButton = input.selectShowPasswordButton.asObservable()
            .asSignal(onErrorSignalWith: .never())
        
        output.showSignInPage = input.selectBackIcon.asObservable()
            .asSignal(onErrorSignalWith: .never())
    }
    
}
