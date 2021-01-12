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
    
    let todosOutput: BehaviorSubject<[Todo]>
    
    init() {
        todosOutput = BehaviorSubject<[Todo]>(value: todos) 
    }
}
