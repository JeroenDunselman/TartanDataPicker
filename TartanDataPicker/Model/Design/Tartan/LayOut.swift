//
//  LayOut.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 08/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//


import Foundation
import UIKit
typealias Coordinate = (x: Int, y: Int)

public class LayOut {
    var images: [String:Any] = [:], tartan: Tartan?
    var cells: [[Int]] = [], colorShapes: [Int:[Coordinate]] = [:],
        design:[ColorCode] = [ColorCode]() //, colorZones: [Int]
    var rowStore:[Int:Any] = [:], shapeStore:[Int:[Coordinate]] = [:]
    var zFactor = 3
    
    init(tartan: Tartan) {
        self.tartan = tartan
        self.design = self.tartan!.createDesign()
        print("self.design \(self.design.count)")
    }
    
    public func build() -> UIImage {
        self.tartan?.sett = self.tartan?.createStructure() ?? []
        return visualizeTartan()
    }
    
}

extension LayOut {
    
    func visualizeTartan() -> UIImage {
        layoutTartan()
        self.images["initial"] = self.createImage()
        return self.images["initial"] as! UIImage
    }
    
    func layoutTartan() {
        guard let sett = self.tartan?.sett, sett.count > 0,
            let colors = self.tartan?.colorSet else { return }
        
        
        //todo prevent unequally defined imgs,  if zFactor == 1 {img.collage(3*3)};ffact = zPat? zPat/2
        if (sett.count) % (self.tartan?.zPattern.length)! != 0 { self.zFactor = 3 }
        
        create2D(sett)
        createColorShapes(colors)
    }
    
    func create2D(_ sett:[Int]) {
        //turn colorstructure 2d
        self.createSquareFromDefinition(sett)
        while rowStore.count < sett.count {
            sleep(1)
            print("bg thread not finished rowStore")
        }
        _ = (0..<rowStore.count).map { index in
            guard let row:[Int] = rowStore[index] as? [Int] else {
                print("error")
                return
            }
            self.cells.append( row )
        }
    }
    func createSquareFromDefinition(_ definition: [Int?]){
        //determine color for coord according zPattern and store
        guard let pattern = self.tartan?.zPattern else { return }
        //todo: issue high def loosing columns
        let size = definition.count*zFactor
        
        _ = (0..<size).map { x in var column:[Int] = []
            //Larger size  exceeds maximum number of these available?
            DispatchQueue.global(qos: .default).async {
                
                _ = (0..<size).map { y in
                    let c:Coordinate = Coordinate(x:x, y:y)
                    //alternate colorsource orientation using zPat
                    let orientation:Bool = pattern.z(x: c.x, y: c.y)
                    let source:Int = orientation ? x : y
                    if let resultColor:Int = definition[source % definition.count] {
                        column.append(resultColor)
                        //                        self.liveView.addCell([c.x, c.y, resultColor])
                        //                        DispatchQueue.main.async() { () -> Void in self.liveView.setNeedsDisplay()}
                    }
                }
//                DispatchQueue.main.async() { () -> Void in
                    self.rowStore[x] = column
                    //                    print("row \(x) finished as \(self.store.count) in \(size)")
//                }
            }
        }
    }
    
    
    func createColorShapes(_ colorSet:Set<Int>) {
        //group cells by color into clrShapes
        self.createColorShapesForSet(colorSet ) //trtn!.colorSetNumeric!)
        while shapeStore.count < colorSet.count {
            sleep(1)
            print("bg thread not finished shapeStore")
        }
        colorShapes = shapeStore
    }
    
    func createColorShapesForSet(_ colorSet: Set<Int>) {
        let colors:[Int] = colorSet.reduce([]) {ar, el  in return ar + [el]}
        print("colors: \(colors)")
        //create shapes by gathering coordinates for each color
        _ = colors.map { current in
            //            DispatchQueue.global(qos: .default).async {
            var shape: [Coordinate] = []
            _ = self.cells.enumerated().map { (x, row) in
                _ = row.enumerated().map  { (y, cell) in
                    if (cell == current) {
                        //cellValue represents a paletPos
                        let coordinate = Coordinate(x: x, y: y)
                        shape.append(coordinate)
                    }
                }
                
            }
     
            self.shapeStore[current] = shape
        }
    }
    
    func createImage() -> UIImage {
        //        //turn colorstructure 2d
        //        createSquareFromDefinition(self.tartan?.sett ?? [])
        
        //group cells by color into clrShapes
        //        createShapesfromCells(colorSet: (tartan?.colorSet)! )
        
        //set imgsize to repeats of defsize
        let repeatSize = 4 * zFactor
        let definitionSize = self.tartan?.weight
        let imageSize = repeatSize*definitionSize!
        
        //Draw colorShapes into image
        if let imageTartan:UIImage = UIImage(
            size: CGSize(width: imageSize, height: imageSize),
            dictShapes: colorShapes, map: self.tartan?.colorMap ?? ColorMap()) { return imageTartan }
        
        return UIImage(color: UIColor.darkGray)!
    }
}


