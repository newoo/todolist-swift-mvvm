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
        view.addSubview(tableView)
        
        return tableView
    }()
    
    var viewModel: TodoListViewViewModel
    var disposeBag = DisposeBag()
    
    init(viewModel: TodoListViewViewModel = TodoListViewViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = TodoListViewViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setContraints()
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }

    private func setContraints() {
        tableView.snp.makeConstraints({
            $0.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
}

