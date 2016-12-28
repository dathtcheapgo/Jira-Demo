//
//  Created by Đinh Anh Huy on 10/19/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

extension UIColor {
    static func RGB(red: CGFloat, green: CGFloat,
                    blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
