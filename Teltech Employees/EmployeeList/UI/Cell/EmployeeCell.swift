//
//  EmployeeCell.swift
//  Teltech Employees
//
//  Created by Josip Marković on 06.03.2023..
//

import Foundation
import SnapKit
import Kingfisher

final class EmployeeCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let introLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = R.color.titleLabelColor()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var avatarImage: UIImageView = {
        
        let view = UIImageView()
        view.roundCorners(radius: 20.0)
        return view
    }()
    
    private let dividerLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = R.color.titleLabelColor()
        return view
    }()
    
    private let initialsLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = R.color.avatarInitialsColor()
        return label
    }()
    
    private lazy var avatarPlaceholderView: UIView = {
       
        let view = UIView()
        view.backgroundColor = R.color.avatarBackground()
        view.roundCorners(radius: 20.0)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        introLabel.text = nil
        avatarImage.image = nil
        avatarPlaceholderView.isHidden = false
    }
    
    private func setupUI() {
        contentView.addSubviews(views: [nameLabel,
                                        introLabel,
                                        avatarImage,
                                        avatarPlaceholderView,
                                        dividerLine])
        avatarPlaceholderView.addSubview(initialsLabel)
        selectionStyle = .none
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        avatarImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(40)
        }
        
        avatarPlaceholderView.snp.makeConstraints { make in
            make.edges.equalTo(avatarImage)
        }
        
        initialsLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(avatarPlaceholderView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(avatarImage.snp.trailing).offset(12)
        }
        
        introLabel.snp.makeConstraints { make in
            make.bottom.equalTo(avatarImage)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(nameLabel)
        }
        
        dividerLine.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(nameLabel)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func configure(item: EmployeeViewItem) {
        
        nameLabel.text = "\(item.name) \(item.surname)"
        introLabel.text = item.intro
        
        setupEmployeeInitialsView(name: item.name, surname: item.surname)
        
        avatarImage.kf.setImage(with: URL(string: item.image)) {[weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.avatarPlaceholderView.isHidden = true
                self.avatarImage.image = image.image
            case .failure:
                self.avatarPlaceholderView.isHidden = false
            }
        }
    }
    
    private func setupEmployeeInitialsView(name: String, surname: String) {
        
        let nameInitial = name.first ?? Character(" ")
        let surnameInitial = surname.first ?? Character(" ")
        
        initialsLabel.text = "\(nameInitial)\(surnameInitial)"
    }
}
