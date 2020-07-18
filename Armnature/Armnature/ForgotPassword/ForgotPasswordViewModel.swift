//
//  ForgotPasswordViewModel.swift
//  Armnature
//
//  Created by Arthur on 5/26/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

final class ForgotPasswordViewModel {
    
    struct Input {
        let selectBackIcon = PublishRelay<Void>()
    }
    
    struct Output {
        fileprivate(set) var titleText: Driver<String> = .never()
        fileprivate(set) var sendMessageButtonText: Driver<String> = .never()
        fileprivate(set) var showSignInPage: Signal<Void> = .never()
    }
    
    let input: Input = Input()
    private(set) var output: Output = Output()
    
    init(data: SignStructure) {
        output.titleText = .just(data.title)
        output.sendMessageButtonText = .just(data.buttonText)
        output.showSignInPage = input.selectBackIcon.asObservable()
            .asSignal(onErrorSignalWith: .never())
    }
    
}
