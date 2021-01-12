//
//  TodoListViewControllerSpec.swift
//  TodoListViewControllerSpec
//
//  Created by law on 2021/01/10.
//  Copyright © 2021 newoo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import todolist_swift_mvvm

class TodoListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("TodoListViewController") {
            struct Constant {
                static let todoList = [Todo(id: 1, title: "TODO"), Todo(id: 2, title: "TODO2")]
                static let newTodo = Todo(id: 3, title: "TODO3")
            }
            
            class MockTodoListViewController: TodoListViewController {
                var isCalledMoveToEditTodoView = false
                
                override func moveToEditTodoView(with todo: Todo? = nil) {
                    isCalledMoveToEditTodoView = true
                    super.moveToEditTodoView(with: todo)
                }
            }
            
            var todolistViewController: MockTodoListViewController!
            
            beforeEach {
                let navigationViewController = UINavigationController()
                todolistViewController = MockTodoListViewController()
                navigationViewController.addChild(todolistViewController)
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = navigationViewController
                
                todolistViewController.beginAppearanceTransition(true, animated: false)
                todolistViewController.endAppearanceTransition()
                
                todolistViewController.isCalledMoveToEditTodoView = false
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
            
            context("when tap add button") {
                it("move to EditTodoViewController") {
                    todolistViewController.navigationItem.rightBarButtonItem?.sendAction()
                    
                    expect(todolistViewController.isCalledMoveToEditTodoView).toEventually(beTrue(), timeout: .seconds(3))
                    expect(todolistViewController.navigationController?.viewControllers.count).toEventually(equal(2), timeout: .seconds(3))
                    expect(todolistViewController.navigationController?.viewControllers.last is EditTodoViewController)
                        .toEventually(beTrue(), timeout: .seconds(3))
                }
            }
            
            context("with todolist data") {
                beforeEach {
                    todolistViewController.viewModel.todos = Constant.todoList
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
                
                context("with new todo") {
                    it("show new todo with old todos") {
                        var todoList = Constant.todoList
                        todoList.append(Constant.newTodo)
                        todolistViewController.viewModel.todosOutput.onNext(todoList)
                        
                        let todosCount = todolistViewController.tableView.visibleCells.count
                        expect(todosCount).toEventually(equal(3), timeout: .seconds(3))
                        
                        guard let todoTableViewCell = todolistViewController.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? TodoTableViewCell else {
                            fail()
                            return
                        }

                        let todoTitle = todoTableViewCell.todoTitleLabel.text
                        expect(todoTitle).toEventually(equal(Constant.newTodo.title), timeout: .seconds(3))
                    }
                }
                
                context("when delete todo") {
                    it("does not show deleted todo") {
                        todolistViewController.tableView.dataSource?.tableView?(todolistViewController.tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))

                        let todosCount = todolistViewController.tableView.visibleCells.count
                        expect(todosCount).toEventually(equal(1), timeout: .seconds(3))

                        guard let todoTableViewCell = todolistViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TodoTableViewCell else {
                            fail()
                            return
                        }

                        let todoTitle = todoTableViewCell.todoTitleLabel.text
                        expect(todoTitle).toEventually(equal(Constant.todoList[1].title), timeout: .seconds(3))
                    }
                }
                
                context("when tap UITableViewCell") {
                    it("get selected todo data and move EditTodoViewController") {
                        var todo: Todo?
                        
                        let disposeBag = DisposeBag()
                        
                        var resultIndexPath: IndexPath? = nil
                        
                        todolistViewController.tableView.rx.itemSelected
                            .subscribe(onNext: {
                                resultIndexPath = $0
                            }).disposed(by: disposeBag)
                        
                        todolistViewController.viewModel.selectedTodoOutput
                            .subscribe(onNext: {
                                todo = $0
                            }).disposed(by: disposeBag)
                        
                        todolistViewController.tableView.delegate?.tableView?(todolistViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        
                        expect(resultIndexPath).toEventually(equal(IndexPath(row: 0, section: 0)), timeout: .seconds(3))
                        expect(todo?.title).toEventually(equal(Constant.todoList.first?.title), timeout: .seconds(3))
                        expect(todolistViewController.navigationController?.viewControllers.last is EditTodoViewController)
                            .toEventually(beTrue(), timeout: .seconds(3))
                    }
                }
            }
        }
    }
}
