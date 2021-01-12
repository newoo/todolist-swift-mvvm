//
//  EditTodoViewModel.swift
//  todolist-swift-mvvm
//
//  Created by law on 2021/01/12.
//  Copyright © 2021 newoo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EditTodoViewModel {
    let editedTodoInput: PublishSubject<String>
    let todoOutput: BehaviorRelay<String>
    
    let todoId: Int
    
    var disposeBag = DisposeBag()
    
    init(todo: Todo? = nil) {
        todoId = todo?.id ?? 0
        
        editedTodoInput = PublishSubject<String>()
        todoOutput = BehaviorRelay<String>(value: todo?.title ?? "")
        
        editedTodoInput.map({ [weak self] in
                Todo(id: self?.todoId ?? 0, title: $0)
            }).bind(to: editedTodoSubject)
            .disposed(by: disposeBag)
    }
}
