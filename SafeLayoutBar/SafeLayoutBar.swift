//
//  SafeLayoutBar.swift
//  SafeLayoutBar
//
//  Created by matsuda on 2018/01/09.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import UIKit

open class SafeLayoutBar: UIView {
    open override var backgroundColor: UIColor? {
        get {
            return _bgView.backgroundColor
        }
        set {
            _bgView.backgroundColor = newValue
        }
    }

    private lazy var _bgView: UIView = UIView()
    private var _layoutGuideAttribute: LayoutGuideAttribute = .none

    @available(iOS 11.0, *)
    var layoutGuideAttribute: LayoutGuideAttribute {
        return _layoutGuideAttribute
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(_bgView)
        sendSubview(toBack: _bgView)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(_bgView)
        sendSubview(toBack: _bgView)
    }

    open override func updateConstraints() {
        if #available(iOS 11.0, *) {
            _scanLayoutGuideAttribute()
        }
        super.updateConstraints()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11.0, *) {
            layoutSafeAreaIfNeeded()
        }
    }
}

extension SafeLayoutBar {

    @available(iOS 11.0, *)
    private func layoutSafeAreaIfNeeded() {
        var rect = bounds
        if isiPhoneX() {
            let guide = layoutGuideAttribute
            print("LayoutGuideAttribute >>>", layoutGuideAttribute)
            if let superview = superview {
                if guide.contains(.top) {
                    let margin = superview.safeAreaInsets.top
                    rect.origin.y -= margin
                    rect.size.height += margin
                }
                if guide.contains(.bottom) {
                    rect.size.height += superview.safeAreaInsets.bottom
                }
            }
        } else {
            /*
            superview?.constraints.forEach {
                if let first = $0.firstItem as? UIView, first == self {
                    if let second = $0.secondItem as? UILayoutSupport {
                        switch $0.firstAttribute {
                        case .top:
                            let delta = second.length
                            rect.origin.y -= delta
                            rect.size.height += delta
                        case .bottom:
                            rect.size.height += second.length
                        default: break
                        }
                    }
                } else if let second = $0.secondItem as? UIView, second == self {
                    if let first = $0.firstItem as? UILayoutSupport {
                        switch $0.secondAttribute {
                        case .top:
                            let delta = first.length
                            rect.origin.y -= delta
                            rect.size.height += delta
                        case .bottom:
                            rect.size.height += first.length
                        default: break
                        }
                    }
                }
            }
             */
        }
        _bgView.frame = rect
    }

    @available(iOS 11.0, *)
    private func _scanLayoutGuideAttribute() {
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
        print("top >>>>", attr.contains(.top))
        print("bottom >>>>", attr.contains(.bottom))
        print("leading >>>>", attr.contains(.leading))
        print("trailing >>>>", attr.contains(.trailing))
        _layoutGuideAttribute = attr
    }
}
