//
//  HomeDataBuilder.swift
//  Armnature
//
//  Created by Arthur on 6/22/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation

final class HomeDataBuilder {
    
    static func createProvincesForHome() -> ProvincesForHome {
       return ProvincesForHome(province: ProvinceResources(headlineText: "Armenian Nature", provinceResources: ProvincesDataBuilder.createProvincesObject()))
    }
    
    static func createRegionsObject() -> Regions {
       return Regions(province: ProvinceResources(headlineText: "Armenian Nature", provinceResources: ProvincesDataBuilder.createProvincesObject()))
    }
    
    static func createBaseObjectForHome() -> HomeData {
        
        let infotext: [String] = ["Carpet is a traditional Armenian craft which has a history thousands of years", "We present most beautiful Armenian girls and women" ,"Traditional national dress of Armenia  <Taraz>", "Armenia is a real museum for gifts.", "Armenia stands proudly, attracting everyone who has ever visited this marvelous place", "Ararat Mountain, knowing that the mountain is not in the territory of Armenia", "Yell Extreme Park is the first extreme amusement park in Armenia", "Armenia is one of the most hospitable and generous nations", "Are you interested in History?", "Armenia still keeps some traditions that are weird for others", "Being a land of stones and rocks", "Armenia has a rich cultural heritage which passed on to our generation from our ancestors.", "Lake Sevan is like a piece of blue sky between the mountains which came down from the sky", "Aragats is a four-peaked volcano massif (4090 m level) and the highest point of Armenia"]
        
        let imageUrl: [String] = ["https://d31qtdfy11mjj9.cloudfront.net/articles/209/image-armenian-carpets.jpg", "https://d31qtdfy11mjj9.cloudfront.net/articles/187/image-armenian-women.jpg" ,"https://d31qtdfy11mjj9.cloudfront.net/articles/154/image-armenian-national-clothing-taraz.jpg" ,"https://d31qtdfy11mjj9.cloudfront.net/articles/152/image-shopping-in-yerevan-armenia.png" ,"https://d31qtdfy11mjj9.cloudfront.net/articles/17/image-the-wings-of-tatev.jpg" ,"https://d31qtdfy11mjj9.cloudfront.net/articles/90/image-the-ararat-mountain.jpg" ,"https://d31qtdfy11mjj9.cloudfront.net/articles/15/image-yell-extreme-park.jpg" ,"https://d31qtdfy11mjj9.cloudfront.net/articles/18/image-what-to-eat-in-armenia.jpg", "https://d31qtdfy11mjj9.cloudfront.net/articles/19/image-the-marashlyan-atelier.jpg", "https://d31qtdfy11mjj9.cloudfront.net/articles/24/image-the-weirdest-facts-about-armenians.jpg", "https://d31qtdfy11mjj9.cloudfront.net/articles/22/image-the-strongest-armenians.jpg", "https://d31qtdfy11mjj9.cloudfront.net/articles/20/image-the-famous-museums.jpg", "https://d31qtdfy11mjj9.cloudfront.net/articles/91/image-lake-sevan.png", "https://d31qtdfy11mjj9.cloudfront.net/articles/16/image-mount-aragats.jpg"]
        
        var interestingArr: [InterestingInfoObjects] = []
        
        for i in 0...13 {
            let temp = InterestingInfoObjects(image: URL(string: imageUrl[i])!, title: nil, description: infotext[i])
            interestingArr.append(temp)
        }
                
        let titleTextForVisit: [String] = ["First Christian Country", "Nature & Wildlife", "National Food & Drinks", "Armenian people"]
        
        let descriptionTextForVisit: [String] = ["Did you know that Armenia was the first country in the world that officially adopted Christianity as a state religion? It happened in 301 AD with the assistance of Gregory the Illuminator and Armenian famous king Trdat III....", "Armenia displays stunning natural diversity of landscape, flora and fauna. Blooming Ararat valley, dramatic sceneries of volcanic highlands, marvelous mountain Lake Sevan with its crystal clear water, valleys of fast flowing.", "National cuisine is the real pride of the Armenian people, one of the oldest cuisines of Asia and the oldest in Caucasus. Despite the huge Armenian Diaspora around the world which cooks most of Armenian national dishes, some .", "Armenians are the heirs of a branch of the Indo-Europeans. As an ethnic group, they emerged as a result of the breakup of the Indo-European common language. The earliest attestations of the name Armenia date around."]
        
        let imageUrlForVisit: [String] = ["https://d31qtdfy11mjj9.cloudfront.net/img/z.jpg", "https://d31qtdfy11mjj9.cloudfront.net/img/nature_wildlife.jpg", "https://d31qtdfy11mjj9.cloudfront.net/img/como-montar-um-disk-churrasco.jpg", "https://d31qtdfy11mjj9.cloudfront.net/img/Genealogy.jpg"]
        
        var interestingArrForVisit: [InterestingInfoObjects] = []
        
        for i in 0...3 {
            let temp = InterestingInfoObjects(image: URL(string: imageUrlForVisit[i])!, title: titleTextForVisit[i], description: descriptionTextForVisit[i])
            interestingArrForVisit.append(temp)
        }
                
        let pieceOfArmeniaImages: [String] = ["https://d31qtdfy11mjj9.cloudfront.net/gallery/thumb/400/1541585741472092542.jpg", "https://d31qtdfy11mjj9.cloudfront.net/gallery/thumb/400/1541585746549283431.jpg", "https://d31qtdfy11mjj9.cloudfront.net/gallery/thumb/400/1541585744585285229.jpg", "https://d31qtdfy11mjj9.cloudfront.net/gallery/thumb/400/1541585748427874764.jpg", "https://d31qtdfy11mjj9.cloudfront.net/gallery/thumb/400/1541585745754510211.jpg", "https://d31qtdfy11mjj9.cloudfront.net/gallery/thumb/400/154158575028602486.jpg"]
        
        var arrayForImage: [URL] = []
        for i in 0...5 {
            arrayForImage.append(URL(string: pieceOfArmeniaImages[i])!)
        }
        
        return HomeData(title: "Armenian Discovery", videoLooperUrl: URL(string: "https://media.gettyimages.com/videos/commercial-airplane-landing-country-armenia-video-id1018607418")!, interestingInfoComponent: InterestingInfo(headlineText: "The most interesting things about Armenia", interesting: interestingArr), visitToArmenianComponent: VisitToArmenia(headlineText: "Why Visit Armenia", description: "Holidays in Armenia can be the most unforgettable vacation of your life. Our small country is so diverse and beautiful. Here, you will be the witness to a 'telling' story, new technologies, and unique inventions. Traveling to Armenia will make you feel like a bird. Because, here is the longest cableway and the longest zipline in the world. Here you will meet the most hospitable people, discover the delicious Armenian cuisine, and drink the finest Armenian wine. Our tours throughout Armenia will make you look at the world with different eyes. Armenia is a paradise on earth, and if you want to see the wonderland, then you are in the right place.", interesting: interestingArrForVisit), pieceOfArmeniaWithYouComponent: PieceOfArmeniaWithYou(title: "A Piece of Armenia with You", images: arrayForImage ))
    }
    
}
