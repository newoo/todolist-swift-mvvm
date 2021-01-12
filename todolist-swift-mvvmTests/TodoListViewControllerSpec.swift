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
            struct Constant {
                static let todoList = [Todo(id: 1, title: "TODO"), Todo(id: 2, title: "TODO2")]
            }
            
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
            
            context("with todolist data") {
                beforeEach {
                    todolistViewController.viewModel.todosOutput.onNext(Constant.todoList)
                }
                
                it("show todolist") {
                    let todosCount = todolistViewController.tableView.visibleCells.count
                    expect(todosCount).toEventually(equal(2), timeout: .seconds(3))
                    
                    guard let todoTableViewCell = todolistViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TodoTableViewCell else { 
                        fail()
                        return
                    }

                    let todoTitle = todoTableViewCell.todoTitleLabel.text
                    expect(todoTitle).toEventually(equal(Constant.todoList.first?.title), timeout: .seconds(3))
                }
            }
        }
    }
}
