//
//  InterestingCollectionViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/27/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

final class InterestingCollectionViewModel {
    typealias SectionModel = RxDataSources.SectionModel<String, InterestingInfoObjects>

    struct Output {
        fileprivate(set) var sections: Driver<[SectionModel]> = .never()
    }
    
    private(set) var output = Output()

    init(interestingInfoObjects: [InterestingInfoObjects]) {
        output.sections = .just([SectionModel(model:"InterestingInfo", items: interestingInfoObjects)])
    }
    
}
