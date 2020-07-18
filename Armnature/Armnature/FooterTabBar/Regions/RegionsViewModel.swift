//
//  RegionsViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/21/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class RegionsViewModel {
    typealias Section = AnimatableSectionModel<String, Row>

    enum Row: Equatable, IdentifiableType {
        static func == (lhs: RegionsViewModel.Row, rhs: RegionsViewModel.Row) -> Bool {
            true
        }
        case province(obj: Province)
        var identity: String {
            String(describing: self)
        }
    }
    
    struct Output {
        fileprivate(set) var titleText: Driver<String> = .never()
        fileprivate(set) var sections: Driver<[Section]> = .never()
        fileprivate(set) var showResourcePreview: Signal<Province> = .never()
    }
    
    struct Input {
        let selectRow = PublishRelay<Row>()
    }
    
    let input: Input = Input()
    private(set) var output: Output = Output()

    init(provinces: Regions) {
        output.titleText = .just(provinces.province!.headlineText)
        output.sections = Driver.just(provinces)
            .map { _ in
                var sections: [Section] = []
                var rows: [RegionsViewModel.Row] = []
                if let pr = provinces.province {
                    let resourceRows = pr.provinceResources.map { Row.province(obj: $0) }
                    rows.append(contentsOf: resourceRows)
                }
                sections.append(Section(model: "", items: rows))
                return sections
            }
        configureSelectRow()
    }
    
    private func configureSelectRow() {
        output.showResourcePreview = input.selectRow
            .compactMap { row in
                switch row {
                case .province(let province):
                    return province
                }
            }
            .asSignal(onErrorSignalWith: .never())
    }
    
}
