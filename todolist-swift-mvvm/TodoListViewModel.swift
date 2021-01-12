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
    }
}
