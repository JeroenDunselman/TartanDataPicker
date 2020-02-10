//
//  TartanLibraryViewModel.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 07/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.

import Foundation

class TartanLibraryViewModel {
    let library: [String:Entry] = LibraryContents.shared.publicContents
    var indexedEntries:[Entry] = [Entry]()
    public var client: TartanLibraryTableViewController?
    
    init() {
        indexedEntries = Array(library.values.makeIterator())
    }
    
    func resetClientData() {
        self.client?.scrollingLocked = true
        self.client?.tableView.reloadData()
        print("reloadData()")
    }
    
    public func refreshContent() {
    }


}

