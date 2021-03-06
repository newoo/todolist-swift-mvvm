//
//  EditTodoViewControllerSpec.swift
//  todolist-swift-mvvmTests
//
//  Created by law on 2021/01/11.
//  Copyright © 2021 newoo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
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
            
            context("with todo data") {
                it("show todo title") {
                    let viewModel = EditTodoViewModel(todo: Todo(id: 0, title: "TODO"))
                    editTodoViewController = EditTodoViewController(viewModel: viewModel)
                    
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    window.makeKeyAndVisible()
                    window.rootViewController = editTodoViewController
                    
                    editTodoViewController.beginAppearanceTransition(true, animated: false)
                    editTodoViewController.endAppearanceTransition()
                    
                    let todoTitle = editTodoViewController.todoTitleTextField.text
                    
                    expect(todoTitle).to(equal("TODO"))
                }
            }
            
            context("when tapped done button") {
                it("editedTodoInput observable emit event") {
                    var isDoneButtonTappedCount = 0
                    
                    editTodoViewController.todoTitleTextField.text = "todo"
                    var expectedTodoTitle = ""

                    let disposeBag = DisposeBag()

                    editTodoViewController.navigationItem.rightBarButtonItem?.rx.tap
                        .subscribe(onNext: {
                            isDoneButtonTappedCount = isDoneButtonTappedCount + 1
                        }).disposed(by: disposeBag)
                    
                    editTodoViewController.viewModel.editedTodoInput
                        .subscribe(onNext: {
                            expectedTodoTitle = $0
                        }).disposed(by: disposeBag)

                    editTodoViewController.navigationItem.rightBarButtonItem?.sendAction()

                    expect(isDoneButtonTappedCount).toEventually(equal(1), timeout: .seconds(3))
                    expect(expectedTodoTitle).toEventually(equal("todo"), timeout: .seconds(3))
                }
            }
        }
    }
}
