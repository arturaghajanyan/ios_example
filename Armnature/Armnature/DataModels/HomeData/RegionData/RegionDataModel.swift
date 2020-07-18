//
//  RegionDataModel.swift
//  Armnature
//
//  Created by Arthur on 6/22/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation

struct Province: Codable {
    let name: String
    let capital: String
    let area: String
    let population: String
    let image: URL?
    let cities: [CitiesInRegions]
}

struct CitiesInRegions: Codable {
    let name: String
    let image: URL?
}

struct ProvincesForHome: Equatable {
    let province: ProvinceResources?
}

struct Regions: Equatable {
    let province: ProvinceResources?
}

struct ProvinceResources: Equatable {
    static func == (lhs: ProvinceResources, rhs: ProvinceResources) -> Bool {
        true
    }
    let headlineText: String
    let provinceResources: [Province]
}
