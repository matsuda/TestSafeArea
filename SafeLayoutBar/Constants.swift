//
//  Constants.swift
//  SafeLayoutBar
//
//  Created by matsuda on 2018/01/09.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import Foundation

struct LayoutGuideAttribute : OptionSet {
    let rawValue: UInt8

    static let none: LayoutGuideAttribute = LayoutGuideAttribute(rawValue: 0)
    static let leading: LayoutGuideAttribute = LayoutGuideAttribute(rawValue: 1 << 0)
    static let trailing: LayoutGuideAttribute = LayoutGuideAttribute(rawValue: 1 << 1)
    static let top: LayoutGuideAttribute = LayoutGuideAttribute(rawValue: 1 << 2)
    static let bottom: LayoutGuideAttribute = LayoutGuideAttribute(rawValue: 1 << 3)
    static let left: LayoutGuideAttribute = LayoutGuideAttribute(rawValue: 1 << 4)
    static let right: LayoutGuideAttribute = LayoutGuideAttribute(rawValue: 1 << 5)
}

import UIKit

func isiPhoneX() -> Bool {
    return UIScreen.main.bounds.size.equalTo(CGSize(width: 375, height: 812))
}
