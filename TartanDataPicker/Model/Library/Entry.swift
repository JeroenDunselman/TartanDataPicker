//
//  Entry.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 08/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit

class Entry:Equatable {
    var title: String, definition: TartanDefinition
    var images:TartanImageTypeService?
   
    init(_ title: String, _ definition: TartanDefinition) {
        self.title = title
        self.definition = definition
        self.images = TartanImageTypeService(self)
    }
}

extension Entry:Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

extension Entry { //:Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.definition == rhs.definition
    }
}

