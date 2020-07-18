//
//  ProvincesDataBuilder.swift
//  Armnature
//
//  Created by Arthur on 6/16/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation

final class ProvincesDataBuilder {
    static func createProvincesObject() -> [Province] {
        var provinces: [Province] = []
        let name: [String] = ["Yerevan", "Aragatsotn", "Ararat", "Armavir", "Gegharkunik", "Kotayk", "Lori", "Shirak", "Syunik", "Tavush", "Vayots Dzor", "Artsakh"]
        let capital: [String] = ["", "Ashtarak", "Artashat", "Armavir", "Gavar", "Hrazdan", "Vanadzor", "Gyumri", "Kapan", "Ijevan", "Yeghegnadzor", "Stepanakert"]
        let area: [String] = ["223 km²", "2,756 km²", "2,090 km²", "1,242 km²", "5,349 km²", "2,086 km²", "3,799 km²", "2,680 km²", "4,506 km²", "2,70 km²", "2,308 km²", "11,458 km2"]
        let population: [String] = ["1,060,138", "132,925", "260,367", "265,770", "235,075", "254,397", "235,537", "251,941", "141,771", "128,609", "52,324", "150,932"]
        let image: [String] = ["https://d31qtdfy11mjj9.cloudfront.net/places/1509361956761346367.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509362037715647172.jpg" ,"https://d31qtdfy11mjj9.cloudfront.net/places/1509362262639618044.jpg" ,"https://d31qtdfy11mjj9.cloudfront.net/places/1509377577946595546.jpg" ,"https://d31qtdfy11mjj9.cloudfront.net/places/1509438055876694218.png" ,"https://d31qtdfy11mjj9.cloudfront.net/places/1509438175554286793.png" ,"https://vestnikkavkaza.net/upload2/2018-02-15/15187032795a8592af430433.85716224.jpg" ,"https://ak.picdn.net/shutterstock/videos/32539897/thumb/1.jpg" ,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWWqaXP4-7W-vXMENIeXoWo6CDEsLnZ1yevWas_huDx6qPxRqY&usqp=CAU" ,"https://d31qtdfy11mjj9.cloudfront.net/places/1509443556584695270.png" ,"https://d31qtdfy11mjj9.cloudfront.net/places/1509443882816678379.jpg"
            ,"https://d31qtdfy11mjj9.cloudfront.net/places/1509446734896389454.png"]
        
        let citiesName: [[ String ]] = [["Yerevan"], ["Ashtarak", "Aparan", "Talin"], ["Artashat", "Ararat", "Masis", "Vedi"], ["Etchmiadzin", "Armavir", "Metsamor"], ["Gavar", "Sevan", "Martuni", "Vardenis", "Chambarak"], ["Abovyan", "Hrazdan", "Charentsavan", "Yeghvard", "Byureghavan", "Nor Hachn", "Tsaghkadzor"], ["Vanadzor", "Alaverdi", "Stepanavan", "Spitak", "Tashir", "Akhtala", "Tumanyan", "Shamlugh"], ["Gyumri", "Artik", "Maralik"], ["Kapan", "Goris", "Sisian", "Kajaran", "Meghri", "Dastakert"], ["Ijevan", "Dilijan", "Berd", "Noyemberyan", "Ayrum"], ["Yeghegnadzor", "Vayk", "Jermuk"], ["Stepanakert"]]
        
        let citiesUrl: [[ String ]] = [["https://d31qtdfy11mjj9.cloudfront.net/places/1509361956761346367.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1509362551867828205.jpg", "https://d31qtdfy11mjj9.cloudfront.net/places/1509362656747043609.jpg", "https://d31qtdfy11mjj9.cloudfront.net/places/1509363101869366925.jpg"], ["https://d31qtdfy11mjj9.cloudfront.net/places/150936390787909264.jpg", "https://d31qtdfy11mjj9.cloudfront.net/places/1509366131409531167.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1503140989.jpg", "https://d31qtdfy11mjj9.cloudfront.net/places/1509377537472904102.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1509377674277720310.jpg", "https://d31qtdfy11mjj9.cloudfront.net/places/1509377707111332607.jpg", "https://d31qtdfy11mjj9.cloudfront.net/places/1509378552854213394.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1509447697433173914.png", "https://d31qtdfy11mjj9.cloudfront.net/places/150944796194947004.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509449197233296599.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509449889607352185.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509451471401299150.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1509451906315341551.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509451976759410019.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509453005653824322.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509453688580857708.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509453749942075179.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509453776488122256.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509453817189786624.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1509454040304598736.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509454085646948654.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509454765119037979.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509455136712532427.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509455768861745589.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509455849581844576.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509455958145803294.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509456056139005083.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1503141718.jpg", "https://d31qtdfy11mjj9.cloudfront.net/places/1509456426347035951.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509456759508446307.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1509456955186708382.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509457086289896531.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509457250339696145.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509457419436398780.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509458413451853117.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509458881178223694.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1509459106223933160.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509459343624448846.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509459589853840800.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509459821328649776.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509460924231357954.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1509461020179995643.png", "https://d31qtdfy11mjj9.cloudfront.net/places/150946269098370845.png", "https://d31qtdfy11mjj9.cloudfront.net/places/1509462911296722343.png"], ["https://d31qtdfy11mjj9.cloudfront.net/places/1509463087515044076.png"]]
        
        for i in 0...11 {
            var temp: [CitiesInRegions] = []
            for j in 0...citiesName[i].count-1 {
                temp.append(CitiesInRegions(name: citiesName[i][j], image: URL(string: citiesUrl[i][j])!))
            }
            let tempObj = Province(name: name[i], capital: capital[i], area: area[i], population: population[i], image: URL(string: image[i])!, cities: temp)
            provinces.append(tempObj)
        }
        return provinces
    }
    
    static func createProvincesForHome() -> ProvincesForHome {
       return ProvincesForHome(province: ProvinceResources(headlineText: "Armenian Nature", provinceResources: ProvincesDataBuilder.createProvincesObject()))
    }
    
    static func createRegionsObject() -> Regions {
       return Regions(province: ProvinceResources(headlineText: "Armenian Nature", provinceResources: ProvincesDataBuilder.createProvincesObject()))
    }
    
}
