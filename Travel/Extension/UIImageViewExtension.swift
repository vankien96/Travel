//
//  UIImageViewExtension.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/16/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

extension UIImageView {
    func tintImageColor(color : UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}
