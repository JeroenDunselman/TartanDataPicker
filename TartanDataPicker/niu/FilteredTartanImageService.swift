//
//  FilteredTartanImageService.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 07/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit

class FilteredTartanImageService: NSObject {
//    var imageService: TartanImageService?
    var colorFilter = ColorFilteredTitleService()
    //    Mode
    
    override init() {
        super.init()
//        self.imageService = TartanImageService(client: self) //
//        self.colorFilter = ColorFilteredTitleService(client: self)
    }
    
    func assetTitlesForColorFilter() -> [String] {
//        
//        if let result: [String] = (imageService?.assetService.content
//            .filter({asset in colorFilter.titlesInColorSet.contains(asset.entry.title)}) //
//            .reduce([], {ar, el in return ar + [el.entry.title] }) ),
//            result.count > 0 {
//            //            print("assetTitles: \(imageService?.assetService.content.count ?? 0), ForCurrentColorFilter: \(result.count)")
//            return result
//        }
//        
//        //        print("NO assetTitles colorSet: \(self.colorFilter.colorSet)")
        return []
    }
    
    public func serveFreshTitleForColorFilter() -> String? {
//        //        colorFilter.shuffleTitles()
//
//        //        if let result = colorFilter.titlesInColorSet.first(where: {filteredTitle in
//        //            !(self.imageService?.assetService.content
//        //                .compactMap({return $0.entry.title})
//        //                .contains(where: { $0 == filteredTitle}))!
//        //        }) { return result}
//
//        if let result = colorFilter.titlesInColorSet.first(where: {filteredTitle in
//            !(self.imageService?.assetService.contentTitles
//                .compactMap({return $0 })
//                .contains(where: { $0 == filteredTitle}))!
//        }) { return result}
        
        return nil
    }
    
//    func similarDefinition(from phrase: [Int]) -> Asset {
//
//        if phrase.count == 1 {
//            let tartan: Tartan = Tartan(randomSizesFor: [phrase[0], Palet.shared.indexOfColor(color: UIColor.clear)!])
//            let tartanDefinition: TartanDefinition = (tartan: tartan, info: ["info_htseflutsch": 1])
//            let e: Entry = (title: "htseflutsch", definition: tartanDefinition)
//            let r = ImageRequest(LayOut(tartan: tartan))
//            let asset: Asset = (entry: e, request: r)
//            //            return LayOut(tartan: tartan)
//            return asset
//        }
//
//        //get sizes from library definitions similar to current phrase
//        let similarEntries: [Entry?] = (library.filter({$0.definition?.tartan.colors.count == phrase.count}))
//
//        if similarEntries.count > 0, let similar: Entry = similarEntries.randomElement()! {
//
//            //            similarEntries[similarEntries.ran .count.asMaxRandom()] {
//
//            let pattern: Tartan = Tartan(colors: phrase, sizes: (similar.definition?.tartan.sizes)!)
//            pattern.createColorPattern()
//
//            let verySimilarEntries: [Entry?] = similarEntries
//                .filter({$0!.definition?.tartan.colorSetCompact.sortString == pattern.colorSetCompact.sortString})
//
//            if verySimilarEntries.count > 0, let verySimilar = verySimilarEntries[verySimilarEntries.count.asMaxRandom()] {
//                let verySimilarTartan = Tartan(colors: phrase, sizes: (verySimilar.definition?.tartan.sizes)!)
//                //                let layOut = LayOut(tartan: verySimilarTartan)
//
//                print("returning verySimilar \(verySimilar.title)")
//
//                let tartanDefinition: TartanDefinition = (tartan: verySimilarTartan, info: ["info_htseflutsch": "verySimilar"])
//                let e: Entry = (title: "htseflutsch", definition: tartanDefinition)
//                let r = ImageRequest(LayOut(tartan: verySimilarTartan))
//                let asset: Asset = (entry: e, request: r)
//
//                return asset
//                //                return layOut
//            }
//
//
//            print("returning similar \(similar.title)")
//
//            let tartanDefinition: TartanDefinition = (tartan: pattern, info: ["info_htseflutsch": "similar"])
//            let e: Entry = (title: "htseflutsch", definition: tartanDefinition)
//            let r = ImageRequest(LayOut(tartan: pattern))
//            let asset: Asset = (entry: e, request: r)
//
//            return asset
//            //            return LayOut(tartan: pattern)
//        }
//
//        let tartanDefinition: TartanDefinition = (tartan: Tartan(randomSizesFor: phrase), info: ["info_htseflutsch": "randomSizesFor"])
//        let e: Entry = (title: "htseflutsch", definition: tartanDefinition)
//        let r = ImageRequest(LayOut(tartan: Tartan(randomSizesFor: phrase)))
//        let asset: Asset = (entry: e, request: r)
//        return asset
//        //        return LayOut(tartan: Tartan(randomSizesFor: phrase))
//
//    }
}


