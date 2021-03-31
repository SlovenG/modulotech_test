//
//  DeviceTableViewCell.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 31/03/2021.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    var viewModel: DeviceCellViewModel!{
        didSet {
            nameLabel.text = viewModel.deviceName
            valueLabel.text = viewModel.value
            modeLabel.text = viewModel.mode
        }
    }
    
   lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        
        view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(named: "backgroundCell")
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    lazy var modeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        label.text = viewModel.mode
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(viewModel: DeviceCellViewModel) {
        self.viewModel = viewModel
        
        self.contentView.addSubview(cardView)
        
        self.cardView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9).isActive = true
        self.cardView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8).isActive = true
        self.cardView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.cardView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        self.cardView.addSubview(nameLabel)
        self.cardView.addSubview(valueLabel)
        
        
        nameLabel.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 10).isActive = true
        
        valueLabel.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 10).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: -10).isActive = true

        if let _ = viewModel.mode{
            self.contentView.addSubview(modeLabel)
            
            modeLabel.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -10).isActive = true
            modeLabel.bottomAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: -10).isActive = true
        }
        
    }
    
    
}



