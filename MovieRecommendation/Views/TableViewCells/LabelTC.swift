//
//  LabelTC.swift
//  MovieRecommendation
//
//  Created by mac1707 on 29/06/24.
//

import Foundation
import UIKit

class LabelTC: UITableViewCell{
    
    lazy var rowLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        addSubview(rowLabel)
        rowLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        rowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        rowLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        rowLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
}
