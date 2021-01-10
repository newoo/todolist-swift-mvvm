//
//  EditTodoViewControllerSpec.swift
//  todolist-swift-mvvmTests
//
//  Created by law on 2021/01/11.
//  Copyright © 2021 newoo. All rights reserved.
//

import Quick
import Nimble
@testable import todolist_swift_mvvm

class EditTodoViewControllerSpec: QuickSpec {
    override func spec() {
        describe("EditTodoViewController") {
            var editTodoViewController: EditTodoViewController!
            
            beforeEach {
                editTodoViewController = EditTodoViewController()
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = editTodoViewController
                
                editTodoViewController.beginAppearanceTransition(true, animated: false)
                editTodoViewController.endAppearanceTransition()
            }
            
            context("when be loaded") {
                it("has textfield to edit todo title and done button") {
                    let hasTextField = editTodoViewController.view.subviews.contains(where: { $0 is UITextField })
                    expect(hasTextField).to(beTrue())
                    
                    let hasButton = editTodoViewController.navigationItem.rightBarButtonItems?.count == 1
                    expect(hasButton).to(beTrue())
                }
            }
        }
    }
}
