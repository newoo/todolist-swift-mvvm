//
//  TodoListViewController.swift
//  todolist-swift-mvvm
//
//  Created by law on 2021/01/10.
//  Copyright © 2021 newoo. All rights reserved.
//

import UIKit
import SnapKit

class TodoListViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        
        return tableView
    }()

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

