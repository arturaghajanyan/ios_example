//
//  SettingsViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class SettingsViewModel {
    typealias Section = AnimatableSectionModel<String, Row>

    enum Row: Equatable, IdentifiableType {
        static func == (lhs: SettingsViewModel.Row, rhs: SettingsViewModel.Row) -> Bool {
            true
        }
        case infoField(field: String, info: String)
        
        var identity: String {
            String(describing: self)
        }
    }
    
    struct Output {
        fileprivate(set) var sections: Driver<[Section]> = .never()
    }
    
    private(set) var output: Output = Output()

    init(settingsData: UserData) {
        
        output.sections = Driver.just(settingsData)
            .map { _ in
                var sections: [Section] = []
                var rows: [SettingsViewModel.Row] = []
                rows.append(Row.infoField(field: "Name", info: settingsData.firstName))
                rows.append(Row.infoField(field: "Last name", info: settingsData.lastName))
                rows.append(Row.infoField(field: "City", info: settingsData.city))
                rows.append(Row.infoField(field: "Email", info: settingsData.email))
                sections.append(Section(model: "", items: rows))
                return sections
            }
    }
}
