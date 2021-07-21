//
//  ImageAssetHelper.swift
//  taewoo_swift_game
//
//  Created by 권태우 on 2021/07/09.
//

import Foundation
import UIKit

struct ImageAssetHelper {
    static func count(prefix:String, number:Int) -> Int {
        var count = 0
        while true {
            let imageName = String(format: "%@_%02d_%02d", prefix, number, count + 1)
            if UIImage(named: imageName) == nil {
                break
            }
            count += 1
        }
        return count
    }
}
