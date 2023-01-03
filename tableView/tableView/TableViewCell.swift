//
//  TableViewCell.swift
//  tableView
//
//  Created by 노영재 on 2023/01/03.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let label : UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
