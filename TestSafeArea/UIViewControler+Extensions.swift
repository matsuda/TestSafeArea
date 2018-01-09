//
//  UIViewControler+Extensions.swift
//  TestSafeArea
//
//  Created by matsuda on 2018/01/09.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import UIKit

extension UIViewController {
    func log(_ function: String = #function) {
        if #available(iOS 11.0, *) {
            print(function, ":", view.safeAreaInsets)
        } else {
            print(function)
        }
    }
}

