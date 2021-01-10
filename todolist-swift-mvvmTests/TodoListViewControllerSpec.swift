//
//  TodoListViewControllerSpec.swift
//  TodoListViewControllerSpec
//
//  Created by law on 2021/01/10.
//  Copyright © 2021 newoo. All rights reserved.
//

import Quick
import Nimble
@testable import todolist_swift_mvvm

class TodoListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("TodoListViewController") {
            var todolistViewController: TodoListViewController!
            
            beforeEach {
                todolistViewController = TodoListViewController()
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = todolistViewController
                
                todolistViewController.beginAppearanceTransition(true, animated: false)
                todolistViewController.endAppearanceTransition()
            }
            
            context("when be loaded") {
                it("has todolist by UITableView") {
                    let hasTableView = todolistViewController.view.subviews.contains(where: { $0 is UITableView })
                    expect(hasTableView).to(beTrue())
                }
                
                it("has add button on navigation bar") {
                    let hasOneRightBarItem = todolistViewController.navigationItem.rightBarButtonItems?.count == 1
                    expect(hasOneRightBarItem).to(beTrue())
                }
            }
        }
    }
}
