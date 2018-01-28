//
//  SafeAutoLayoutBar.swift
//  SafeLayoutBar
//
//  Created by matsuda on 2018/01/11.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import UIKit

open class SafeAutoLayoutBar: UIView {
    open override var backgroundColor: UIColor? {
        get {
            return _bgView.backgroundColor
        }
        set {
            _bgView.backgroundColor = newValue
        }
    }

    private lazy var _bgView: UIView = UIView()
    private var _bgViewTopConstraint: NSLayoutConstraint?
    private var _bgViewBottomConstraint: NSLayoutConstraint?
    private var _layoutGuideAttribute: LayoutGuideAttribute = .none

    @available(iOS 11.0, *)
    var layoutGuideAttribute: LayoutGuideAttribute {
        return _layoutGuideAttribute
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        _prepareBgView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _prepareBgView()
    }

    open override func updateConstraints() {
        if #available(iOS 11.0, *) {
            _scanLayoutGuideAttribute()
            if isiPhoneX() {
                if layoutGuideAttribute.contains(.top) {
                    _bgViewTopConstraint?.constant = -(superview?.safeAreaInsets.top ?? 0)
                }
                if layoutGuideAttribute.contains(.bottom) {
                    _bgViewBottomConstraint?.constant = -(superview?.safeAreaInsets.bottom ?? 0)
                }
            }
        }
        super.updateConstraints()
    }
}

extension SafeAutoLayoutBar {
    private func _prepareBgView() {
        clipsToBounds = false
        addSubview(_bgView)
        sendSubview(toBack: _bgView)
        _bgView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            let leading = _bgView.leadingAnchor.constraint(equalTo: leadingAnchor)
            let trailing = trailingAnchor.constraint(equalTo: _bgView.trailingAnchor)
            _bgViewTopConstraint = _bgView.topAnchor.constraint(equalTo: topAnchor)
            _bgViewBottomConstraint = bottomAnchor.constraint(equalTo: _bgView.bottomAnchor)
            NSLayoutConstraint.activate([leading, trailing, _bgViewTopConstraint!, _bgViewBottomConstraint!])
        } else {
            let leading = NSLayoutConstraint(item: _bgView, attribute: .leading, relatedBy: .equal,
                                             toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal,
                                              toItem: _bgView, attribute: .trailing, multiplier: 1, constant: 0)
            _bgViewTopConstraint = NSLayoutConstraint(item: _bgView, attribute: .top, relatedBy: .equal,
                                                      toItem: self, attribute: .top, multiplier: 1, constant: 0)
            _bgViewBottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                                                         toItem: _bgView, attribute: .bottom, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([leading, trailing, _bgViewTopConstraint!, _bgViewBottomConstraint!])
        }
    }
}

extension SafeAutoLayoutBar {

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
