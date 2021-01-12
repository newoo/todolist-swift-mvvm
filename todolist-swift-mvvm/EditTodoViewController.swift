//
//  EditTodoViewController.swift
//  todolist-swift-mvvm
//
//  Created by law on 2021/01/11.
//  Copyright © 2021 newoo. All rights reserved.
//

import UIKit
import RxSwift

class EditTodoViewController: UIViewController {
    let textFieldSideMargin = CGFloat(16)
    let textFieldTopMargin = CGFloat(16)
    
    lazy var todoTitleTextField: UITextField = {
        let textField = UITextField()
        view.addSubview(textField)
        
        return textField
    }()
    
    var disposeBag = DisposeBag()
    
    var viewModel: EditTodoViewModel
    
    init(viewModel: EditTodoViewModel = EditTodoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = EditTodoViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBar()
        setContraints()
        setBinding()
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    }
    
    private func setContraints() {
        todoTitleTextField.borderStyle = .roundedRect
        todoTitleTextField.snp.makeConstraints({
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(textFieldSideMargin)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(textFieldTopMargin)
        })
    }
    
    private func setBinding() {
        navigationItem.rightBarButtonItem?.rx.tap
            .compactMap({ [weak self] in self?.todoTitleTextField.text })
            .subscribe(onNext: { [weak self] in
                self?.viewModel.editedTodoInput.onNext($0)
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
