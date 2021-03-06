//
//  AppCollectionViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 01/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import SnapKit
import Awesome


class AppCollectionViewCell: UICollectionViewCell, Presentable {
    
    let iconView = UIImageView()
    let nameLabel = UILabel()
    let uploadedLabel = UILabel()
    let infoLabel = UILabel()
    
    let installButton = UIButton()
    
    var didTapActionButton: ((_ sender: UIButton)->())?
    
    
    // MARK: Layout
    
    private func layoutElements() {
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(Env.cellSpacing)
            make.top.equalTo(Env.cellSpacing)
            make.bottom.equalTo(-Env.cellSpacing)
            make.width.equalTo(iconView.snp.height)
        }
        
        installButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-Env.cellSpacing)
            make.height.equalTo(Env.actionButtonHeight)
            make.width.equalTo(installButton.imageView!.image!.size.width)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(Env.cellSpacing)
            make.top.equalTo(iconView)
            make.right.equalTo(installButton.snp.left).offset(-Env.cellSpacing)
        }
    }
    
    // MARK: Configuration
    
    private func configureIconView() {
        iconView.backgroundColor = .red
        iconView.layer.cornerRadius = 10
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)
    }
    
    private func configureLabels() {
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.numberOfLines = 2
        contentView.addSubview(nameLabel)
    }
    
    private func configureButtons() {
        installButton.setImage(Awesome.light.cloudDownload.asImage(size: 34, color: installButton.tintColor), for: .normal)
        installButton.addTarget(self, action: #selector(didTapInstallButton(_:)), for: .touchUpInside)
        contentView.addSubview(installButton)
    }
    
    private func configureStaticElements() {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        contentView.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func configureElements() {
        configureIconView()
        configureLabels()
        configureButtons()
        configureStaticElements()
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        
        configureElements()
        layoutElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc func didTapInstallButton(_ sender: UIButton) {
        didTapActionButton?(sender)
    }
    
}


class AppCollectionViewCellPresenter: SelectablePresenter {
    
    var presentable: Presentable.Type = AppCollectionViewCell.self
    
    var configure: ((Presentable) -> ())?
    
    var didSelectCell: (()->())?
    
}
