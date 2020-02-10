//
//  Tartan.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 08/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit

class Tartan {
    var colors:[Int] = [Int](), sizes:[Int] = [Int]()
    var colorMap:ColorMap?
    var e: Set<String> = []

    var zPattern: ZPattern = ZPattern(length:3)
    var sett:[Int] = []
    
    var info:[String:Any] = [String:Any]()
    public var sumSizes: Int = 0
    
    public var colorSet:Set<Int> = []
    public var colorSetCompact:(layOut:[Int], sortString:String) = ([], "")
    
    var colorCodes:[String] = []
    var colorTypes:[ColorCode] = []
    
    init() {}

    convenience init(colorCodes: [ColorCode], sizes: [Int], palet:ColorMap) {
        self.init()
        
//        self.colorTypes = convertToColorCodeEnum(colorCodes)
        self.colorTypes = colorCodes
        self.colorMap = palet
        
        self.sizes = sizes
        self.sumSizes = self.sizes.map { $0 }.reduce(0, +)
//        print("zones/size: \(self.sumSizes)/\(sizes.count)")
    }

    init(colors:[Int], sizes:[Int]) {
        self.colors = colors
        self.createColorPattern()
        
        self.sizes = sizes
        self.sumSizes = self.sizes.map { $0 }.reduce(0, +)
        //        self.createColorPattern()
    }
    
    init(sett:[Int]) { //[intThreadColor]
        self.colorSet = sett.valuedAsSet
        //        self.randomizeColorSet()
        
        self.sumSizes = sett.count
        self.sett = sett.mirror() as! [Int] //mirrorStructure(definition:sett)
    }
    
    convenience init(randomSizesFor colors:[Int]) {
        let theColors = colors
        let sizes: [Int] = theColors.reduce([]) {(ar, el) in ar + [11.randomFib()]}
        self.init(colors: theColors, sizes: sizes)
    }
}

extension Tartan {
    
    func createColorPattern() {
        
        self.colorSet = self.colors.valuedAsSet
        
        let colorSetPattern = self.colors
            .reduce([]) {(ar, el) in ar + (!ar.contains(el) ? [el] : [] )}
        let layOut:[Int] = colors.reduce([]) {(ar, el) in ar + [colorSetPattern.index(of: el)!]}
        
        //make comparable by sortString
        self.colorSetCompact = ( layOut: layOut,
                            sortString: layOut.reduce("") { ar, el in "\(ar)\(el)"})
    }
}

extension Tartan {
    
    func createDesign() -> [ColorCode] {
        var definition:[ColorCode] = []

        for i in (0..<self.colorTypes.count) {
            var zone:[ColorCode] = [ColorCode]()
            for _ in (0..<self.sizes[i]) {
                zone = zone + [colorTypes[i]]
            }
            
            definition = definition + zone
        }
        
        return definition //.mirror() as! [ColorCode]   //.mirror() 
    }
    
    func createStructure() -> [Int] {
        
        var definition: [Int] = []
        //get sett
        _ = (0..<self.sizes.count).map { i in
            definition += Array(repeatElement(self.colors[i], count: (self.sizes[i])))}
        return definition.mirror() as! [Int]
    }
    
}

//please document this
//definition += Array(repeatElement(self.colors[i], count: (self.sizes[i] / divider)))
//
//        var allEven = true
//        _ = (0..<self.sizes.count).map({if ($0 % 2 != 0){ allEven = false } })
//        let divider = allEven ? 2 : 1
//        print("divider: \(divider)")

    //    convenience init(sizes:[Int]){
    //        var colors:[Int] = []
    //
    //        //colors from palet enumeration with random offset
    //        let offSet = colormap?.palet.count.asMaxRandom()
    //        _ = (0..<sizes.count).map({colors.append($0 + offSet!)})
    //
    //        self.init(colors: colors, sizes: sizes)
    //
    //    }
//    convenience init(colors: [Int], sizes: [Int], errors: Set<String>) {
//
//        self.init(colors: colors, sizes: sizes)
//        self.e = errors
//    }

//    convenience init(colorCodes: [String], sizes: [Int]) {
//        self.init()
//
//        colorTypes = colorCodes.reduce([])
//        { ar, code in
//            guard let existing:ColorCode = ColorCode(rawValue: code) else  {
//                return ar + [ColorCode.CLR]}
//
//            return ar + [existing]
//        }
//    }
    


//        //map colorCodes to index of palet
//        let colorPositions:[Int] = colorCodes.reduce([]) { ar, code in
//
//            for i:ColorCode in ColorCode.allCases {
//                if i.rawValue == code {
////print("init clrs \(code), i.rawValue \(i.rawValue) i: \(i), i.positionForCode(): \(i.positionForCode())")
//                    return ar + [i.positionForCode()]
//                }
//            }
//
//            return ar + [13]
//        }
//        var errors: Set<String> = []
//        var erroring:[String] = []
//        _ = erroring.map {code in errors.insert(code)}
////        print("init clrs \(colorPositions)")
//        self.init(colors: colorPositions, sizes: sizes, errors: errors)
//        self.colorCodes = colorCodes
//        self.colorMap = palet
//        if erroring.count > 1 {
//            if let d = self.info["definition"] {
//                print(info["title"] ?? "") //?? errors
//                print(d)
//            }
//        }
//    }


