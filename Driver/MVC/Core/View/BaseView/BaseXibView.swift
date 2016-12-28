//
//  BaseXibView.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/12/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

class BaseXibView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initControl()
    }
    
    func initControl() {
        fatalError("Implement \(self) initControl")
    }
}
