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
    
    var disposeBag = DisposeBag()
    
    init(todo: Todo? = nil) {
        editedTodoInput = PublishSubject<String>()
        
        editedTodoInput.map({ [weak self] in
                Todo(id: 0, title: $0)
            }).bind(to: editedTodoSubject)
            .disposed(by: disposeBag)
    }
}
