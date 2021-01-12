//
//  UIBarButtonItem+Extension.swift
//  todolist-swift-mvvmTests
//
//  Created by law on 2021/01/12.
//  Copyright © 2021 newoo. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    func sendAction() {
        guard let myTarget = target else { return }
        guard let myAction = action else { return }
        let control: UIControl = UIControl()
        control.sendAction(myAction, to: myTarget, for: nil)
    }
}
