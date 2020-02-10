//
//  extensions.swift
//  Tartanize
//
//  Created by Jeroen Dunselman on 11/08/2018.
//  Copyright © 2018 Jeroen Dunselman. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

public extension UIImage {
    internal convenience init?( size: CGSize = CGSize(width: 1, height: 1),
                                dictShapes: [Int:[Coordinate]] = [:],
                                map: ColorMap) {
        
        let palet = map.palet 
        let imgRect = CGRect(origin: .zero, size: size)
        
        func runShapeFor(key: Int, shape: [Coordinate]) {
            let index:Int = key % palet.count
            let shapeColor:UIColor = palet[index]
            shapeColor.setFill()
            _ = shape.map{cell in fillShape(current: cell) }
        }
        
        func fillShape(current: Coordinate) {
            //Draw 1 layout cell in four quadrants
            let one:CGFloat = 1
            let half:CGFloat = CGFloat(one / 2)
            let rSize = CGSize(width: one, height: one)
            
            var rect = CGRect(origin: CGPoint(x:current.x, y:current.y), size: rSize)
            UIRectFill(rect)
            
            let newX:Int = (current.x + Int(size.width * half))
            rect = CGRect(origin: CGPoint(x:newX, y:current.y), size: rSize)
            UIRectFill(rect)
            
            let newY:Int = (current.y + Int(size.width * half))
            rect = CGRect(origin: CGPoint(x:current.x, y:newY), size: rSize)
            UIRectFill(rect)
            
            rect = CGRect(origin: CGPoint(x:newX, y:newY), size: rSize)
            UIRectFill(rect)
            
        }
        
        UIGraphicsBeginImageContextWithOptions(imgRect.size, false, 0.0)
//        print("imaging colorShape for..")
        _ = dictShapes.map { colorShape in
            runShapeFor(key: colorShape.key, shape: colorShape.value)            
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
extension Int {
    
    //    minimum size to collage toPrime
    func toPrime() -> Int {
        var result = self
        while result % 2 == 0 {
            result = result / 2
        }
        return result
    }
    
    func colorPattern() -> [Int] {
        let seqs:[[Int]] = [[0], [0], [0, 1, 1], [0, 1, 2, 2], [0, 1, 2, 2, 3, 3, 3]]
        if self < seqs.count { return seqs[self]}
        return seqs[0]
    }
    
    func randomFib() -> Int {
        var fibonacci:Int = 0
        
        while fibonacci < 1 {
            
            let n = Double(self.asMaxRandom())
            fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) /
                2.23606).rounded())
        }
        return fibonacci
    }
    
    func asMaxRandom() -> Int {
        if self == 0 {return 0}
        let maximum = self
        return Int({Int(arc4random_uniform(UInt32(maximum)))}())
    }
    
    func testIntExtension() {
        2.times {print("Hello, world")}
        //        2.down(to: 1) {i in print("\(i)..") }
        //        let isEven : Bool = 2.even(num: 3) print(isEven)
        //        4.up(to: 8) {  i in print("\(i)..")
    }
    
    func times (iterator: () -> Void) {
        for _ in 0..<self {iterator()}
    }
    
    func down (to : Int, iterator: (Int) -> Void) {
        var num : Int = self
        while num != to - 1 {
            iterator(num)
            num -= 1
        }
    }
    
    func up (to : Int, iterator: (Int) -> Void) {
        var num : Int = self
        while num != to + 1 {
            iterator(num)
            num += 1
        }
    }
    
    func even (num: Int) -> Bool {
        return self == num
    }
    
    func next () -> Int {
        return self + 1
    }
    
    func pred () -> Int {
        return self - 1
    }
    
}

extension Array {
    func mirror() -> [Any] {
        let reversedArray = self.reversed()
        let arrayMirror = self + reversedArray
        return arrayMirror
    }
}

extension Array where Element: Hashable {
    var valuedAsSet: Set<Element> {
        return Set<Element>(self)
    }
}

extension Array {
    func decompose() -> (Iterator.Element, [Iterator.Element])? {
        guard let x = first else { return nil }
        return (x, Array(self[1..<count]))
    }
}


