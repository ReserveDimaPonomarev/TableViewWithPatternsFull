//
//  CustomTableViewCell.swift
//  TableView with sections
//
//  Created by Дмитрий Пономарев on 01.10.2022.
//

import UIKit
import SnapKit

final class CustomTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //  MARK: - UI properties
    
    private let label = UILabel()
    private let image = UIImageView()
    
    //  MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //   MARK: - Public Methods
    
    func configureView(_ model: Model) {
        label.text = model.name
        image.image = model.image
    }
}

//  MARK: - Private methods

private extension CustomTableViewCell {
    
    //  MARK: - Setup
    
    private func setup() {
        addViews()
        makeConstraints()
        setupViews()
    }
    
    //  MARK: - addViews
    
    private func addViews() {
        contentView.addSubview(label)
        contentView.addSubview(image)
    }
    
    //  MARK: - makeConstraints
    
    private func makeConstraints() {
        image.snp.makeConstraints {
            $0 .left.equalTo(20)
            $0 .top.bottom.equalToSuperview().offset(10)
            $0 .width.equalTo(80)
        }
        label.snp.makeConstraints {
            $0 .right.equalToSuperview().inset(20)
            $0 .left.equalTo(image.snp.right).offset(25)
            $0 .centerY.equalToSuperview()
        }
    }
    
    //  MARK: - setupViews
    
    private func setupViews() {
        label.font = .systemFont(ofSize: 20)
    }
}
