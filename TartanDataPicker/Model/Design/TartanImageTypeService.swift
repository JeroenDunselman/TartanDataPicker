//
//  TartanImageTypeService.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 08/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit

enum ImageType:Int, CaseIterable {case tartan = 0, design, colorSet, firstColor }

class TartanImageTypeService {
    var defaultImage:UIImage = UIImage(color:UIColor.clear)!
    var images:[ImageType:UIImage] = [ImageType:UIImage]()
    let client:Entry?
    var layOut:LayOut?
    var tartan:Tartan
    
    init(_ entry: Entry) {
        self.client = entry
        self.tartan = entry.definition.tartan
    }
}

extension TartanImageTypeService {
    
    func preferredImage() -> UIImage {
        for t in ImageType.allCases {
            if let image:UIImage = self.images[t]  {
                print("\(t.rawValue)")
                return image
            }
        }
        
        if let colorMap = self.tartan.colorMap,
            let result:UIImage = colorMap.images[self.tartan.colorTypes[0]] {
            
            self.images[ImageType.firstColor] = result
            
            //launch build of .colorSet image
            DispatchQueue.global(qos: .default).async {
                _ = self.colorSet()
            }
            return preferredImage()
            
        }
        
        print("image failed")
        self.images[ImageType.firstColor] = UIImage(color: UIColor.clear)!
        return preferredImage()
        
    }
    
    func colorSet() -> UIImage {
        let zones:[(Int, UIColor)] = self.tartan.orderedColorCodes
            .enumerated().reduce([]) {ar , e in
                let info:(zoneCount:Int, colorCount:Int) = self.tartan.colorScore[e.element]!
                    return ar + [(info.colorCount, e.element.colorForCode() )] }
        //            .mirror() as! [(Int, UIColor)]
        
//        let colors:Set<ColorCode> = self.tartan.colorTypes.valuedAsSet
//        let zones:[(Int, UIColor)] = colors.enumerated().reduce([]) {ar , el in
//            return ar + [(1, el.element.colorForCode())] }
////            .mirror() as! [(Int, UIColor)]
        
        let result:UIImage = UIImage(zones2:zones)! //zones: [(Int, String)])
        self.images[ImageType.colorSet] = result

        DispatchQueue.global(qos: .default).async {
            _ = self.design()
        }
        return preferredImage()
    }
    
    func design() -> UIImage {
        if let i = self.images[ImageType.design] {
            return i }
        sleep(10)
        self.layOut = LayOut(tartan: self.tartan)
        let zones:[(Int, UIColor)] = (self.layOut?.design.enumerated().reduce([]) {ar, el in
            return ar + [(1, el.element.colorForCode())] })!   //            .mirror()
        
        if zones.count > 0 {
            let result:UIImage = UIImage(zones:zones)!
            //            DispatchQueue.main.async() { () -> Void in
            //                print("sTypes \(self.sTypes)")
            self.images[ImageType.design] = result
            //            }
            //launch build of .tartan image
            //            DispatchQueue.global(qos: .default).async {
            //                _ = self.build()
            //            }
            return preferredImage()
        }
        
        //        return images[ImageType.colorSet]!
        return preferredImage()
    }
    
    func build() -> UIImage? {
        //        image = self.layOut.visualizeTartan()
        return images[ImageType.tartan]
    }
}
extension UIImage {
    
    public convenience init?(zones2: [(Int, UIColor)]) {
        let imgRect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        
        let xy = 100 / zones2.count //* (100 / zones.count)
        
        func runShapeAt(_ at:Int, _ color:UIColor, _ size:Int) {
            
            color.setFill()
            fillShape(current: Coordinate(0, at * xy), width:size)
        }
        
        func fillShape(current: Coordinate, width: Int) {
            //Draw 1 layout shap
            let one:CGFloat = CGFloat(width)
            let rSize = CGSize(width: one, height: CGFloat(xy) )
            
            let rect = CGRect(origin: CGPoint(x:current.x, y:current.y), size: rSize)
            UIRectFill(rect)
        }
        
        UIGraphicsBeginImageContextWithOptions(imgRect.size, false, 0.0)
        
        _ = (0..<zones2.count).map { i in
            //            print("imaging colorShape for.. \()")
            runShapeAt(i, zones2[i].1, zones2[i].0)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
            
        }
        self.init(cgImage: cgImage)
    }
}
extension UIImage {
    
    public convenience init?(zones: [(Int, UIColor)]) {
        let imgRect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        
        let xy = 100 / zones.count //* (100 / zones.count)
        
        func runShapeAt(_ at:Int, _ color:UIColor) {
            
            color.setFill()
            fillShape(current: Coordinate(at * xy, 0))
        }
        
        func fillShape(current: Coordinate) {
            //Draw 1 layout shap
            let one:CGFloat = CGFloat(xy)
            let rSize = CGSize(width: one, height: CGFloat(xy) * CGFloat(zones.count) * CGFloat(0.6108))
            
            let rect = CGRect(origin: CGPoint(x:current.x, y:current.y), size: rSize)
            UIRectFill(rect)
        }
        
        UIGraphicsBeginImageContextWithOptions(imgRect.size, false, 0.0)
        
        _ = (0..<zones.count).map { i in
            //            print("imaging colorShape for.. \()")
            runShapeAt(i, zones[i].1)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
            
        }
        self.init(cgImage: cgImage)
    }
}

