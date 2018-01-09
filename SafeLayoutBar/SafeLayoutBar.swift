//
//  SafeLayoutBar.swift
//  SafeLayoutBar
//
//  Created by matsuda on 2018/01/09.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import UIKit

class SafeLayoutBar: UIView {
    private lazy var bgView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(bgView)
    }

    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        sendSubview(toBack: bgView)
    }

    @available(iOS 11.0, *)
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSafeAreaIfNeeded()
    }

    var layoutGuideAttribute: LayoutGuideAttribute {
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        var attr: LayoutGuideAttribute = .none
        superview?.constraints.forEach {
            if let first = $0.firstItem as? UIView, first == self {
                print("constraints >>>>>>>>", $0)
                if let _ = $0.secondItem as? UILayoutSupport {
                    print("firstAttribute >>>", $0.firstAttribute.rawValue)
                    print("secondAttribute >>>", $0.secondAttribute.rawValue)
                    switch $0.firstAttribute {
                    case .leading: attr.insert(.leading)
                    case .trailing: attr.insert(.trailing)
                    case .top: attr.insert(.top)
                    case .bottom: attr.insert(.bottom)
                    default: break
                    }
                }
                if #available(iOS 9.0, *) {
                    if let _ = $0.secondItem as? UILayoutGuide {
                        print("secondAttribute >>>", $0.secondAttribute.rawValue)
                        switch $0.secondAttribute {
                        case .leading: attr.insert(.leading)
                        case .trailing: attr.insert(.trailing)
                        case .top: attr.insert(.top)
                        case .bottom: attr.insert(.bottom)
                        default: break
                        }
                    }
                }
            } else if let second = $0.secondItem as? UIView, second == self {
                print("constraints >>>>>>>>", $0)
                if let _ = $0.firstItem as? UILayoutSupport {
                    print("firstAttribute >>>", $0.firstAttribute.rawValue)
                    print("secondAttribute >>>", $0.secondAttribute.rawValue)
                    switch $0.secondAttribute {
                    case .leading: attr.insert(.leading)
                    case .trailing: attr.insert(.trailing)
                    case .top: attr.insert(.top)
                    case .bottom: attr.insert(.bottom)
                    default: break
                    }
                }
                if #available(iOS 9.0, *) {
                    if let _ = $0.firstItem as? UILayoutGuide {
                        print("firstAttribute >>>", $0.firstAttribute.rawValue)
                        switch $0.firstAttribute {
                        case .leading: attr.insert(.leading)
                        case .trailing: attr.insert(.trailing)
                        case .top: attr.insert(.top)
                        case .bottom: attr.insert(.bottom)
                        default: break
                        }
                    }
                }
            }
        }
        print("top >>>>", attr.contains(.top))
        print("bottom >>>>", attr.contains(.bottom))
        print("leading >>>>", attr.contains(.leading))
        print("trailing >>>>", attr.contains(.trailing))
        return attr
    }
}

extension SafeLayoutBar {
    func layoutSafeAreaIfNeeded() {
        var f = self.bounds
        if isiPhoneX() {
            if #available(iOS 11.0, *) {
                let guide = layoutGuideAttribute
                print("LayoutGuideAttribute >>>", layoutGuideAttribute)
                if let superview = superview {
                    if guide.contains(.top) {
                        let delta = superview.safeAreaInsets.top
                        f.origin.y -= delta
                        f.size.height += delta
                    }
                    if guide.contains(.bottom) {
                        f.size.height += superview.safeAreaInsets.bottom
                    }
                }
            }
            bgView.backgroundColor = self.backgroundColor
            bgView.alpha = self.alpha
        } else {
            /*
            superview?.constraints.forEach {
                if let first = $0.firstItem as? UIView, first == self {
                    if let second = $0.secondItem as? UILayoutSupport {
                        switch $0.firstAttribute {
                        case .top:
                            let delta = second.length
                            f.origin.y -= delta
                            f.size.height += delta
                        case .bottom:
                            f.size.height += second.length
                        default: break
                        }
                    }
                } else if let second = $0.secondItem as? UIView, second == self {
                    if let first = $0.firstItem as? UILayoutSupport {
                        switch $0.secondAttribute {
                        case .top:
                            let delta = first.length
                            f.origin.y -= delta
                            f.size.height += delta
                        case .bottom:
                            f.size.height += first.length
                        default: break
                        }
                    }
                }
            }
             */
            bgView.backgroundColor = .clear
            bgView.alpha = 0
        }
        bgView.frame = f
    }
}
