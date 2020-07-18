//
//  TitleCellViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

final class TitleCellViewModel {
    
    struct Output {
        fileprivate(set) var titleText: Driver<String> = .never()
    }

    private(set) var output = Output()

    init(text: String) {
        output.titleText = .just(text)
    }
}
