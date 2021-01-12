//
//  TodoListViewController.swift
//  todolist-swift-mvvm
//
//  Created by law on 2021/01/10.
//  Copyright © 2021 newoo. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class TodoListViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        view.addSubview(tableView)
        
        return tableView
    }()
    
    var viewModel: TodoListViewModel
    var disposeBag = DisposeBag()
    
    init(viewModel: TodoListViewModel = TodoListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = TodoListViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setContraints()
        setBindings()
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }

    private func setContraints() {
        tableView.snp.makeConstraints({
            $0.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    private func setBindings() {
        viewModel.todosOutput
            .bind(to: tableView.rx.items(
                cellIdentifier: TodoTableViewCell.identifier,
                cellType: TodoTableViewCell.self
            )) { _, item, cell in
                cell.todoInput.onNext(item.title)
            }.disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .map({ $0.row })
            .bind(to: viewModel.deletedIndexInput)
            .disposed(by: disposeBag)
    }
}

