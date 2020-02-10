//
//  AssetViewController.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 07/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.

//  AssetViewController.swift
//  Tartanize
//
//  Created by Jeroen Dunselman on 06/04/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.

import UIKit
import Foundation

class AssetViewController: UITableViewController {
    var asset: Asset?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 //assets.rowTitles.count //numberOfRows
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: TVCell = tableView.dequeueReusableCell(withIdentifier: "TartanCell", for: indexPath) as! TVCell
        let row = indexPath.row
        var imgType = "initial"
        if row == 0 {imgType = "initial"}
        if row == 1 {imgType = "noir"}
        if row == 2 {imgType = "freaky"}
        if row == 3 {imgType = "sepia"}

//        if let img = asset?.request.layOut.images[imgType] as? UIImage {
            cell.cellImage!.image = UIImage(color: UIColor.red) //as? UIImage
        cell.label.text = "htsflts"
//        }
        cell.activityIndicatorView.isHidden = true
        //        return cell
        return cell as TVCell
    }

    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1
    //    }
}
