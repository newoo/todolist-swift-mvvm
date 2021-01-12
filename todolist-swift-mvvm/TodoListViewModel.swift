//
//  TodoListViewModel.swift
//  todolist-swift-mvvm
//
//  Created by law on 2021/01/12.
//  Copyright © 2021 newoo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TodoListViewModel {
    var todos = [Todo]()
    
    var disposeBag = DisposeBag()
    
    let todosOutput: BehaviorSubject<[Todo]>
    let selectedTodoOutput: PublishSubject<Todo>
    
    let selectedIndexInput: PublishSubject<Int>
    let deletedIndexInput: PublishSubject<Int>
    
    init() {
        todosOutput = BehaviorSubject<[Todo]>(value: todos)
        selectedTodoOutput = PublishSubject<Todo>()
        
        selectedIndexInput = PublishSubject<Int>()
        deletedIndexInput = PublishSubject<Int>()
        
        deletedIndexInput.subscribe(onNext: { [weak self] in
            self?.todos.remove(at: $0)
            
            if let todos = self?.todos {
                self?.todosOutput.onNext(todos)
            }
        }).disposed(by: disposeBag)
        
        selectedIndexInput.compactMap({ [weak self] in
            if let count = self?.todos.count, count > $0 {
                return self?.todos[$0]
            }
            
            return nil
        }).bind(to: selectedTodoOutput)
        .disposed(by: disposeBag)
        
        editedTodoSubject.map({ [weak self] editedTodo in
            if editedTodo.id == 0 {
                var editedTodo = editedTodo
                editedTodo.id = (self?.todos.count ?? 0) + 1
                self?.todos.append(editedTodo)
                return self?.todos ?? []
            }
            
            return self?.todos.map({
                editedTodo.id == $0.id ? editedTodo : $0
            }) ?? []
        }).bind(to: todosOutput)
        .disposed(by: disposeBag)
    }
}
