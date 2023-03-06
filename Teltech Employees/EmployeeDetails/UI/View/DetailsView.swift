//
//  DetailsView.swift
//  Teltech Employees
//
//  Created by Josip Marković on 06.03.2023..
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

final class DetailsView: UIView {
    
    private lazy var avatarImage: UIImageView = {
       
        let view = UIImageView()
        view.roundCorners(radius: 40.0)
        return view
    }()
    
    private let nameLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let teamLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = R.color.titleLabelColor()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let descriptionLabel: UITextView = {
       
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14.0, weight: .regular)
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    private let initialsLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 28.0, weight: .bold)
        label.textColor = R.color.avatarInitialsColor()
        return label
    }()
    
    private lazy var avatarPlaceholderView: UIView = {
       
        let view = UIView()
        view.backgroundColor = R.color.avatarBackground()
        view.roundCorners(radius: 40.0)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(views: [avatarImage, nameLabel, titleLabel, descriptionLabel, teamLabel, avatarPlaceholderView])
        avatarPlaceholderView.addSubview(initialsLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        avatarImage.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16.0)
            make.height.width.equalTo(80.0)
        }
        
        avatarPlaceholderView.snp.makeConstraints { make in
            make.edges.equalTo(avatarImage)
        }
        
        initialsLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage)
            make.leading.equalTo(avatarImage.snp.trailing).offset(12.0)
            make.trailing.equalToSuperview().inset(16.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8.0)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        teamLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImage)
            make.top.equalTo(avatarImage.snp.bottom).offset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImage)
            make.trailing.bottom.equalToSuperview().inset(16.0)
            make.top.equalTo(teamLabel.snp.bottom).offset(8.0)
        }
    }
        
    func configure(with item: EmployeeViewItem) {
        
        nameLabel.text = "\(item.name) \(item.surname)"
        teamLabel.text = item.teamTitle.capitalized
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        
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
