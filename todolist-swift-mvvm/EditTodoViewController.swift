//
//  EditTodoViewController.swift
//  todolist-swift-mvvm
//
//  Created by law on 2021/01/11.
//  Copyright © 2021 newoo. All rights reserved.
//

import UIKit

class EditTodoViewController: UIViewController {
    lazy var todoTitleTextField: UITextField = {
        let textField = UITextField()
        view.addSubview(textField)
        
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBar()
        setContraints()
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    }
    
    private func setContraints() {
        todoTitleTextField.borderStyle = .roundedRect
        todoTitleTextField.snp.makeConstraints({
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
        })
    }
}
