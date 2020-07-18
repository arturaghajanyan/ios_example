//
//  SettingsTableCellViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

final class SettingsTableCellViewModel {
    
    struct Output {
        fileprivate(set) var infoText: Driver<String> = .never()
        fileprivate(set) var fieldText: Driver<String> = .never()
    }

    private(set) var output = Output()

    init(text: String, field: String) {
        output.fieldText = .just(field)
        output.infoText = .just(text)
    }
}
