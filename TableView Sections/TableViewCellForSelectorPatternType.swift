//
//  TableViewCellForSelector.swift
//  TableView with sections
//
//  Created by Дмитрий Пономарев on 01.10.2022.
//

import UIKit
import SnapKit



final class TableViewCellForSelectorPatternType: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //  MARK: - UI properties
    
    private let label = UILabel()
    
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
        label.text = "\(model.pattern.rawValue)"
    }
}

//  MARK: - Private methods

private extension TableViewCellForSelectorPatternType {
    
    //  MARK: - Setup
    
    private func setup() {
        addViews()
        makeConstraints()
        setupViews()
    }
    
    //  MARK: - addViews
    
    private func addViews() {
        contentView.addSubview(label)
    }
    
    //  MARK: - makeConstraints
    
    private func makeConstraints() {
        label.snp.makeConstraints {
            $0 .centerX.equalToSuperview()
            $0 .top.bottom.equalToSuperview().inset(5)
        }
    }
    
    //  MARK: - setupViews
    
    private func setupViews() {
        label.font = .systemFont(ofSize: 20)
    }
}
