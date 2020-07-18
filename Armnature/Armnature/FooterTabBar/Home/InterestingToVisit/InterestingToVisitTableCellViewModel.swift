//
//  InterestingToVisitTableCellViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

final class InterestingToVisitTableCellViewModel {
    
    typealias SectionModel = RxDataSources.SectionModel<String, InterestingInfoObjects>

    struct Output {
        fileprivate(set) var sections: Driver<[SectionModel]> = .never()
        fileprivate(set) var descriptionText: Driver<String> = .never()
    }
    
    private(set) var output = Output()

    init(visitToInfo: VisitToArmenia, isSeeAllEnabled: Bool = true) {
        output.descriptionText = .just(visitToInfo.description)
        output.sections = .just([SectionModel(model: "", items: visitToInfo.interesting)])
    }
    
}
