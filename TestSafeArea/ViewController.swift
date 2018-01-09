//
//  ViewController.swift
//  TestSafeArea
//
//  Created by matsuda on 2018/01/09.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var barHeightConstraint: NSLayoutConstraint!

    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        log()
        barHeightConstraint.constant = view.safeAreaInsets.bottom + 44
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        log()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        log()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        log()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        log()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        log()
    }
}

