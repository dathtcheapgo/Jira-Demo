//
//  StringExtension.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/20/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

extension String {
    func flag() -> String? {
        let base : UInt32 = 127397
        var s = ""
        for v in self.unicodeScalars {
            if let scalars = UnicodeScalar(base + v.value) {
                s.unicodeScalars.append(scalars)
            } else { return nil }
        }
        return String(s)
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    subscript (i: Int) -> String {
        let startIndex = index(from: i)
        let endIndex = index(from: i+1)
        return substring(with: startIndex..<endIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
