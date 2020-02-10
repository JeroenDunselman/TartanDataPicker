//
//  TartanLibrary.swift
//
//  Created by Jeroen Dunselman on 24/07/2018.
//  Copyright © 2018 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit
enum LibraryError: Error {
    case invalid
}
class TartanLibrary: NSObject {
    static let shared = TartanLibrary()
    
    let input = FileParser(file: DataFileInfo()).result
    let palet = ColorMap()
    var codesOccurring:Set<String> = []
    
    public var contents: [String : Entry] = [:]
    var sizesOccurring: Set<Int> = []
    
    private override init() {
        super.init()
        guard let input = input else { return }
        
        _ = input.contentsOfTextFile.map { contents[$0.key] =
            Entry($0.title, createTartan($0.title, $0.description))}

        print("number of codes occurring in data: \(codesOccurring.count)")
    }
    
    func createTartan(_ title: String, _ tartanDescription:String) -> TartanDefinition {

        let zones = tartanDescription.components(separatedBy: ",")
        let info: [String: Any] = ["title": title,
                                   "definition": tartanDescription,
                                   "zoneCount": zones.count]
        var entry = TartanDefinition(tartan: Tartan(), info: info)
        
        
        //Extract and cast numbers as sizes for each zone ("a1, c3, b1" -> [1, 3, 1])
        guard let sizes:[Int] = (zones.reduce([], { (result, zone) in result +
            [Int(zone.components(separatedBy: CharacterSet.decimalDigits.inverted)
                .joined(separator: ""))]}) as? [Int])
        else { return entry }
        sizesOccurring = sizesOccurring.union(Set(sizes))
        
        //Extract chars as colorCodes for each zone ("a1, c3, b1" -> [a, c, b])
        let colorCodeStrings:[String] = zones.reduce([], {(result, zone) in result +
            [zone.components(separatedBy: CharacterSet.decimalDigits)
                .joined(separator: "")
                .trimmingCharacters(in: .whitespaces)
                .replacingOccurrences(of: "\t", with: "")]})
        codesOccurring = codesOccurring.union(colorCodeStrings)
        
        if colorCodeStrings.count != sizes.count {
            entry.tartan.info["error"] = LibraryError.invalid
        }
        
        let colorCodes = convertToColorCodeEnum(colorCodeStrings)
     
        //Create design
        entry.tartan = Tartan(colorCodes: colorCodes, sizes: sizes, palet: palet)
        entry.tartan.info = entry.info
        return entry
        
    }
    
    func convertToColorCodeEnum(_ input:[String]) -> [ColorCode] {
        return input.reduce([])
        { ar, code in
            guard let existing:ColorCode = ColorCode(rawValue: code) else  {
                return ar + [ColorCode.CLR]
            }
            return ar + [existing]
        }
    }
}


