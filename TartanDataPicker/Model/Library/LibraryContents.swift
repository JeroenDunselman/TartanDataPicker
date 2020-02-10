//
//  LibraryContents.swift
//  Tartanize
//
//  Created by Jeroen Dunselman on 05/04/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation

class LibraryContents: NSObject {
    static let shared = LibraryContents()
    
    public let library: [String : Entry] = TartanLibrary.shared.contents
    public var publicContents: [String : Entry] = [:]
    public var publicTitles: [String] = []
    
    func checkOutPublicContents() {
        publicContents = library.filter({($0.value.definition.tartan.colors.count) < 5 })
        //.filter({($0.value.title == "Stewart Old")})
    }
    
    override init() {
        super.init()
        self.checkOutPublicContents() 
    }
    
    var patternCollection: Set<String> = []
    var patterns: [String:Int] = [:]
}

