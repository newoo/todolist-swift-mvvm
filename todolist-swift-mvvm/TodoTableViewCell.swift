//
//  TodoTableViewCell.swift
//  todolist-swift-mvvm
//
//  Created by law on 2021/01/12.
//  Copyright © 2021 newoo. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class TodoTableViewCell: UITableViewCell {
    static let identifier = "todoTableViewCell"
    
    struct Constant {
        static let margin: CGFloat = 16
    }
    
    lazy var todoTitleLabel: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        
        return label
    }()
    
    let todoInput = PublishSubject<String>()
    var cellDisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TodoTableViewCell.identifier)
        setContraints()
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        cellDisposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setContraints()
        setBinding()
    }
    
    private func setContraints() {
        todoTitleLabel.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(Constant.margin)
            $0.centerY.equalToSuperview()
        })
    }
    
    private func setBinding() {
        todoInput.observeOn(MainScheduler.instance)
            .bind(to: todoTitleLabel.rx.text)
            .disposed(by: cellDisposeBag)
    }
}
