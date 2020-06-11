//
//  ItemTableViewCell.swift
//  Practical Dependency Inversion
//
//  Created by Hanyu on 2020/6/11.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    private lazy var titleLabel = makeTitleLabel()
    
    private lazy var contentLabel = makeContentLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        //TODO: Layout constraint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutUI(with item: Item) {
        titleLabel.text = item.titleText
        contentLabel.text = item.contentText
    }
}

extension ItemTableViewCell {
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        return label
    }
    
    private func makeContentLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        return label
    }
}
