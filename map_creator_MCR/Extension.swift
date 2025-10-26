//
//  Extension.swift
//  map_creator_MCR
//
//  Created by Evgeni Rozkov on 26.08.25.
//

import Foundation

extension CGPoint {
    func rounded(decimals: Int) -> CGPoint {
        let factor = pow(10.0, Double(decimals))
        return CGPoint(
            x: (x * factor).rounded() / factor,
            y: (y * factor).rounded() / factor
        )
    }
}

extension CGFloat {
    func rounded(decimals: Int) -> CGFloat {
        let factor = pow(10.0, Double(decimals))
        return CGFloat((self * factor).rounded() / factor
        )
    }
}

extension Double {
    func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
