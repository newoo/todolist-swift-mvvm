//
//  TodoTableViewCell.swift
//  todolist-swift-mvvm
//
//  Created by law on 2021/01/12.
//  Copyright © 2021 newoo. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    static let identifier = "todoTableViewCell"
    
    lazy var todoTitleLabel: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
