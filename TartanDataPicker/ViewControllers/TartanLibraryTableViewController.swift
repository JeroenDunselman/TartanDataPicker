//
//  TartanLibraryTableViewController.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 07/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

import UIKit

class TartanLibraryTableViewController: DrillViewController { //UITableViewController {
    public var model = TartanLibraryViewModel()
    
    let initialNumberOfRows = 4
    var scrollingLocked = false
    //    var drillVC: AssetViewController?
    override func viewDidLoad() {
        super.viewDidLoad()        
        model.client = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.library.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell: TVCell = tableView.dequeueReusableCell(withIdentifier: "TartanCell", for: indexPath) as! TVCell
        let row = indexPath.row

        let entry:Entry = model.indexedEntries[row]
        cell.contentView.backgroundColor = entry.cellBackgroundColor()
        cell.definitionLabel.text = "\(entry.definition.info["definition"] ?? "(definition unavailable)")"
        cell.label.text = "\(entry.title)"
        cell.cellImage!.image = entry.images!.preferredImage()
        
        return cell as TVCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return self.view.frame.size.width / 1.61803 } // }
    //    var navController: UINavigationController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        if let result {drillToAsset(result)}
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // MARK: - timeOut Refresh
    
    public var timeOutTimer: Timer?
    func scrollAction() {
        
        let rows = tableView.numberOfRows(inSection: 0)
        let timeOut: Double = 1
        timeOutTimer = Timer.scheduledTimer(timeInterval: timeOut, target:self, selector: #selector(reenableScrollAction), userInfo: nil, repeats: true)
        
        model.refreshContent()
        print("scroll \(rows) refreshed: \(tableView.numberOfRows(inSection: 0))")
    }
    
    @objc func reenableScrollAction() {
        timeOutTimer?.invalidate()
        timeOutTimer = nil
        
        //        activityIndicatorBottom.isHidden = false
        //        activityIndicatorTop.isHidden = false
    }
    
    // MARK: - scrolling
    func scrollToBottom() { //niu
        DispatchQueue.main.async {
            
            let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollingLocked = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        scrollingLocked = true
    }
}

extension TartanLibraryTableViewController {    
    //    Trigger refresh from pull.
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //    Prevent repeat refresh for same swipe.
        if !(timeOutTimer == nil) {return}
        
        let pullDistance: CGFloat = 100
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        let triggeredForBottomScroll:Bool = distanceFromBottom < height - pullDistance
        let triggeredForTopScroll:Bool =  scrollView.contentOffset.y < -(pullDistance)
        
        if (triggeredForBottomScroll || triggeredForTopScroll) {
            
            if !scrollingLocked {scrollAction()}
        }
    }
    
}
