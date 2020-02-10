//
//  DrillViewController.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 07/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit

class DrillViewController: UITableViewController {
    var drillVC: AssetViewController?
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    var navController: UINavigationController?
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    func drillToAsset(_ asset: Asset){
        if drillVC == nil {
            drillVC = (storyboard!.instantiateViewController(withIdentifier: "AssetTVC") as! AssetViewController)}
        
        if let vc = drillVC {
            vc.asset = asset //assets?.assets.reversed()[indexPath.row] //assets?.boards[indexPath.row]
            vc.navigationItem.title = "hatseflats"
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.done, target: self, action: #selector(goBack))
            navController = UINavigationController(rootViewController: vc)
            presentDetail(navController!)
        }
    }
}
