//
//  CitiesInRegionsViewModel.swift
//  Armnature
//
//  Created by Arthur on 7/4/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

final class CitiesInRegionsViewModel {
    typealias SectionModel = RxDataSources.SectionModel<String, CitiesInRegions>

    struct Output {
        fileprivate(set) var sections: Driver<[SectionModel]> = .never()
    }
    
    private(set) var output = Output()

    init(cities: [CitiesInRegions]) {
        output.sections = .just([SectionModel(model:"TITLE", items: cities)])
    }
    
}
