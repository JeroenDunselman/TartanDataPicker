import Foundation
import UIKit

class ColorMap {
    var palet: [UIColor] = [UIColor]()
    var images: [ColorCode:UIImage] = [ColorCode:UIImage]()
    var colorIndexLookUp: [String : (index:Int, color:UIColor)] = [:]
//    var codingValues:ColorCoding?
    
    init() {    //        self.init(coding: TartanColorCoding.shared)
        buildPalet()
    }

    func buildPalet() {
        self.palet = ColorCode.allCases.reduce([]) {result, c in
            return result + [c.colorForCode()]
        }
        let mappedDictionary = EnumMap<ColorCode, UIImage> { type in
            switch type { default: return type.imageForColorCode()}
        }
        self.images = mappedDictionary.values
        print("buildPaletimages.count \(self.images.count) p.count \(self.palet.count)")
    }

    //    init(coding: ColorCoding) {
    //        codingValues = coding
    //        buildPalet()
    //    }
}

extension UIImage {
    public convenience init?(zones: [(Int, Int)]) {
        let p = ColorMap().palet //coding: TartanColorCoding.shared).palet //init
        let rect = CGRect(origin: .zero, size: CGSize(width: 10, height: 10))
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        _ = zones.map( { _ in
            p[zones[0].1].setFill()
            UIRectFill(rect)
        })
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    public convenience init?(color: UIColor) {
            self.init(color: color, size: CGSize(width: 20, height: 20))
    }
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
}
