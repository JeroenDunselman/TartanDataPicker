//
//  TartanColorCoding.swift
//  TartanDataPicker
//
//  Created by Jeroen Dunselman on 05/02/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit

enum ColorCode: String, CaseIterable { //B R, K B,
    typealias RawValue = String
    case Y, A, DB, K, B, R, G, N, P, T, W, C, S, CLR, E, AA, H, DR, LR, OG, LC, O, D, LN, GC, WR, L, DN, RB, RG, M, LP, NB, BR, LB, LG, U, LDR, DW, DT, LT, DBG, DH, DG, CL, LV
}

extension ColorCode {

    func imageForColorCode() -> UIImage {
        guard let result = UIImage(color: self.colorForCode()) else {
            return UIImage(color: ColorCode.CLR.colorForCode())!
        }
        return result
    }

    func colorForCode() -> UIColor  {
        //        = EnumMap<ColorCode, UIColor> { code in
        //        let result:UIColor = {
        switch self {
        case .Y: return UIColor.magenta
        case .A: return UIColor.yellow
        case .DB: return UIColor.orange
        case .K: return UIColor.black
        case .B: return UIColor.blue
        case .R: return UIColor.red
        case .G: return UIColor.green
        case .N: return UIColor.gray
        case .P: return UIColor.purple
        case .T: return UIColor.brown
        case .W: return UIColor.white
        case .C: return UIColor.lightGray
        case .S: return UIColor.cyan
            //            case .RB: return UIColor.black
            //            case .DG: return UIColor.blue
            //            case .LR: return UIColor.red
            //            case .LN: return UIColor.green
            //            case .DN: return UIColor.gray
        //            case .XL: return UIColor.purple
        case .CLR: return UIColor.clear
        default: return UIColor.clear
        }
    }
    
   
}
protocol ColorCoding {
    //    var listing:Set<String> { get } //enum ColorCode:
    //    var colors:[String:UIColor] { get }
}
struct TartanColorCoding: ColorCoding {
    static let shared = TartanColorCoding()
//    var listing:Set<String> = ["E", "C", "AA", "A", "H", "K", "DR", "LR", "G", "B R", "OG", "LC", "O", "D", "Y", "T", "B", "LN", "GC", "WR", "S", "L", "DB", "K B", "DN", "RB", "RG", "M", "W", "LP", "NB", "BR", "LB", "P", "LG", "U", "N", "LDR", "DW", "DT", "LT", "DBG", "R", "DH", "DG", "CL", "LV"] //48?
}
