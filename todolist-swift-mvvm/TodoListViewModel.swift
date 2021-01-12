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
    
    let deletedIndexInput: PublishSubject<Int>
    
    init() {
        todosOutput = BehaviorSubject<[Todo]>(value: todos)
        
        deletedIndexInput = PublishSubject<Int>()
        
        deletedIndexInput.subscribe(onNext: { [weak self] in
            self?.todos.remove(at: $0)
            
            if let todos = self?.todos {
                self?.todosOutput.onNext(todos)
            }
        }).disposed(by: disposeBag)
    }
}
