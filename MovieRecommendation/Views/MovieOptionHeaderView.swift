//
//  MovieOptionHeaderView.swift
//  MovieRecommendation
//
//  Created by mac1707 on 29/06/24.
//

import Foundation
import UIKit

class MovieOptionHeaderView: UIView {
    
    lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = .black
        return imageview
    }()
    
    fileprivate lazy var buttonContainer: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [buttonLabel, buttonIcon])
        stackview.distribution = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView(){
        backgroundColor = .white
        addSubview(buttonContainer)
        addSubview(lineView)
        
        buttonContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        buttonContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        buttonContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        lineView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        buttonLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        buttonIcon.heightAnchor.constraint(equalToConstant: 48).isActive = true
        buttonIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
