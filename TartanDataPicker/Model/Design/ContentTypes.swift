//
//  ContentTypes.swift
//  Tartanize
//
//  Created by Jeroen Dunselman on 30/01/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

struct TartanDefinition {
    var tartan:Tartan
    var info:[String:Any]
}
extension TartanDefinition:Equatable {
    static func ==(lhs: TartanDefinition, rhs: TartanDefinition) -> Bool {
        return lhs.tartan.colors == rhs.tartan.colors && lhs.tartan.sizes == rhs.tartan.sizes
    }
}

extension TartanDefinition {
    func hash(into hasher: inout Hasher) {
        hasher.combine(tartan.colors)
        hasher.combine(tartan.sizes)
    }
}
struct EnumMap<Enum: CaseIterable & Hashable, Value> {
//    private
    let values: [Enum : Value]
    
    init(resolver: (Enum) -> Value) {
        var values = [Enum : Value]()
        
        for key in Enum.allCases {
            values[key] = resolver(key)
        }
        
        self.values = values
    }
    
    subscript(key: Enum) -> Value {
        //        https://www.swiftbysundell.com/articles/enum-iterations-in-swift-42/
        // Here we have to force-unwrap, since there's no way
        // of telling the compiler that a value will always exist
        // for any given key. However, since it's kept private
        // it should be fine - and we can always add tests to
        // make sure things stay safe.
        return values[key]!
    }
}
