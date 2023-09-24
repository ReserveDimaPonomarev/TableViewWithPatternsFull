//
//  DetailViewController.swift
//  TableView with sections
//
//  Created by Дмитрий Пономарев on 01.10.2022.
//


import UIKit

protocol DetailViewControllerDelegate: UIViewController {
    func changedDescription(patternWithNewDescription: Model)
}

final class DetailViewController: UIViewController {
    
    //  MARK: - UI properties
    
    private let image = UIImageView()
    private lazy var scrollView = UIScrollView()
    private let contentView = UIView()
    private var item: Model
    private let textView = UITextView()
    var delegate: DetailViewControllerDelegate?
    
    //   MARK: - Init
    
    //convuinence
    
    init (item:Model) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addViews()
        makeConstraints()
        setupViews()
        changingLeftBar()
        setupAction()
    }
}

//  MARK: - Extension DetailViewController

private extension DetailViewController {
    
    //  MARK: - addViews
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(image)
        contentView.addSubview(textView)
    }
    
    //  MARK: - makeConstraints
    
    func makeConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        image.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(300)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(50)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(500)
        }
    }
    
    //  MARK: - setupViews
    
    func setupViews() {
        self.view.backgroundColor = .white
        contentView.backgroundColor = .white
        image.image = UIImage(named: item.name)
        textView.text = item.description
        textView.font = .boldSystemFont(ofSize: 15)
        textView.resignFirstResponder()
        self.title = item.name
    }
    
    //  MARK: - setupNavBar
    
    func changingLeftBar() {
        textView.isEditable = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(edit))
    }
    
    //  MARK: - setupAction
    
    func setupAction() {
        image.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                          action: #selector(imageTapped)))
        image.isUserInteractionEnabled = true
    }
    
    //  MARK: - @objc func
    
    @objc func imageTapped() {
        let imageVC = TappedImageViewController(imageForScroll: image, nameOfImage: item.name)
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
    
    @objc func edit() {
        textView.isEditable = true
        textView.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(save))
    }
    
    @objc func save() {
        let changedPattern = Model(
            name: item.name,
            description: textView.text,
            pattern: item.pattern,
            image: item.image)
        self.delegate?.changedDescription(patternWithNewDescription: changedPattern)
        textView.resignFirstResponder()
        changingLeftBar()
    }
}

