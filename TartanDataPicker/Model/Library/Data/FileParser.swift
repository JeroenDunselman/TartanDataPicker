//
//  FileParser.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 09/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

class FileParser {
    let result:ParsedTextFile?
    init(file: DataFileInfo) {
        self.result = ParsedTextFile(fileName: file.name, fileType: file.type, numberOfComponentsPerElement: file.elementSize)
    }
}

struct DataFileInfo {
    let name = "tartandefs components as row", type = "rtf", elementSize = 3
    enum Components {
        case title, id, definition
    }
}

struct ParsedTextFile {
    
    var keys:[String] = [], titles:[String] = [], definitions:[String] = []
    var contentsOfTextFile:[(key:String, title: String, description: String)] = []
    
    let why9:Int = 9, why10:Int = 10, why11:Int = 11, why2306:Int = 2306, why2307:Int = 2307, why2308:Int = 2308
    
    init(fileName:String, fileType:String, numberOfComponentsPerElement:Int) {
        guard let contents:NSString = readFromDisk(fileName, fileType) else {return}
        
        //        Separate filecontents by row
        let rowsPerElement = numberOfComponentsPerElement, components = contents.components(separatedBy: "\n");
        
        let tartans:[String] = components.reduce([]) {
            (result, zone) in result +
                [zone.replacingOccurrences(of: "\\", with: "")
                    .replacingOccurrences(of: "\t", with: "")] }
        
        for i in stride(from: why9, through: why2306, by: rowsPerElement) {
            titles.append(tartans[i])
        }
        for i in stride(from: why10, through: why2307, by: rowsPerElement) {
            keys.append(tartans[i])
        }
        for i in stride(from: why11, through: why2308, by: rowsPerElement) {
            definitions.append(tartans[i])
        }
        
        //todo test ar.counts
        contentsOfTextFile = (0..<definitions.count).reduce([]) {ar, i in ar + [(
            key: self.keys[i],
            title: self.titles[i],
            description: self.definitions[i]) ]}
    }
    
    func readFromDisk(_ name:String, _ type:String ) -> NSString? {
        let path = Bundle.main.path(forResource: name, ofType: type)
        let contents:NSString
        
        do {
            contents = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
        } catch _ {
            contents = ""
        }
        return contents
    }
}
