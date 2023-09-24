//
//  DetailViewController.swift
//  TableView with sections
//
//  Created by Дмитрий Пономарев on 01.10.2022.
//
//

import UIKit
import SnapKit

final class TappedImageViewController: UIViewController {
    
    //  MARK: - UI properties
    
    private var imageScrollView: TappedImageScrollView!
    private let imageForScroll: UIImageView
    private let nameOfImage: String
    private let labelWithName = UILabel()
    
    //  MARK: - init
    
    init(imageForScroll: UIImageView, nameOfImage: String) {
        self.imageForScroll = imageForScroll
        self.nameOfImage = nameOfImage
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageScrollView = TappedImageScrollView(frame: view.bounds)
        addViews()
        setupViews()
        makeConstraints()
    }
    
    //  MARK: - addViews
    
    private func addViews() {
        view.addSubview(labelWithName)
        view.addSubview(imageScrollView)
    }
    
    //    MARK: - setupViews
    private func setupViews() {
        self.imageScrollView.setImage(image: imageForScroll.image!)
        labelWithName.text = nameOfImage
        labelWithName.font = .boldSystemFont(ofSize: 30)
    }
    
    //    MARK: - makeConstraints
    
    private func makeConstraints() {
        labelWithName.snp.makeConstraints {
            $0 .centerX.equalToSuperview()
            $0 .top.equalToSuperview().inset(220)
        }
        imageScrollView.snp.makeConstraints {
            $0 .top.equalTo(labelWithName.snp.bottom).inset(50)
            $0 .right.left.equalToSuperview()
            $0 .bottom.equalToSuperview().inset(100)
        }
    }
}
