//
//  NewObjectViewController.swift
//  petshelp
//
//  Created by Дмитрий Пономарев on 18.09.2022.
//


import UIKit
import SnapKit

protocol AddNewPattern {
    func addCell (newpattern: Model)
}

final class NewObjectViewController: UIViewController {
    
    //  MARK: - UI properties
    
    var delegateNewPattern: AddNewPattern?
    let addImage = UIImageView()
    let stackView = UIStackView()
    let nameLabel = UILabel()
    let nameTF = UITextField()
    let typeLabel = UILabel()
    let typeTF = UITextField()
    let descriptionLabel = UILabel()
    let descriptionTF = UITextField()
    let tableViewPattern = UITableView()
    
    //  MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    //  MARK: - View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addViews()
        makeConstraints()
        setupViews()
        setupNavBar()
        addGestures()
    }
}

//  MARK: - Extension NewObjectViewController

private extension NewObjectViewController {
    
    //  MARK: - addViews
    
    func addViews() {
        view.backgroundColor = .systemGray4
        view.addSubview(addImage)
        view.addSubview(stackView)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(typeTF)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTF)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionTF)
        view.addSubview(tableViewPattern)
    }
    
    //  MARK: - makeConstraints
    
    func makeConstraints() {
        addImage.snp.makeConstraints {
            $0 .top.equalToSuperview().inset(100)
            $0 .right.left.equalToSuperview()
            $0 .height.equalTo(300)
        }
        stackView.snp.makeConstraints {
            $0 .top.equalTo(addImage.snp.bottom).offset(50)
            $0 .height.equalTo(300)
            $0 .right.left.equalToSuperview().inset(25)
        }
        tableViewPattern.snp.makeConstraints {
            $0.top.equalTo(typeTF.snp.bottom).offset(2)
            $0.width.equalTo(typeTF.snp.width)
            $0.centerX.equalTo(typeTF.snp.centerX)
            $0.height.equalTo(100)
        }
    }
    
    //  MARK: - setupViews
    
    func setupViews() {
        tableViewPattern.dataSource = self
        tableViewPattern.delegate = self
        tableViewPattern.register(TableViewCellForSelectorPatternType.self, forCellReuseIdentifier: TableViewCellForSelectorPatternType.identifier)
        tableViewPattern.backgroundColor = .white
        tableViewPattern.isHidden = true
        tableViewPattern.layer.cornerRadius = 5
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        addImage.image = UIImage(named: "addImage")
        addImage.contentMode = .center
        addImage.backgroundColor = .white
        
        typeLabel.text = "Pattern's type"
        typeLabel.font = .boldSystemFont(ofSize: 25)
        typeLabel.textColor = .black
        typeLabel.textAlignment = .center
        
        typeTF.borderStyle = .roundedRect
        typeTF.placeholder = "Choose pattern's type"
        typeTF.textColor = .black
        typeTF.textAlignment = .center
        typeTF.font = .systemFont(ofSize: 20)
  
        nameLabel.text = "Pattern's name"
        nameLabel.font = .boldSystemFont(ofSize: 25)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        
        nameTF.borderStyle = .roundedRect
        nameTF.placeholder = "Print pattern's name"
        nameTF.textColor = .black
        nameTF.delegate = self
        nameTF.font = .systemFont(ofSize: 20)
        nameTF.returnKeyType = .done
        
        descriptionLabel.text = "Pattern's description"
        descriptionLabel.font = .boldSystemFont(ofSize: 25)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        
        descriptionTF.borderStyle = .roundedRect
        descriptionTF.placeholder = "Print pattern's description"
        descriptionTF.textColor = .black
        descriptionTF.delegate = self
        descriptionTF.font = .systemFont(ofSize: 20)
        descriptionTF.returnKeyType = .done
    }
    
    //    MARK: - func addGestures
    
    func addGestures() {
        
        let tapOnButtonToShowTableView = UITapGestureRecognizer(target: self, action: #selector(showView(frames:)))
        typeTF.addGestureRecognizer(tapOnButtonToShowTableView)
        
        let tapGestureForImage = UITapGestureRecognizer(target: self, action: #selector(NewObjectViewController.imageTapped(gesture:)))
        addImage.addGestureRecognizer(tapGestureForImage)
        addImage.isUserInteractionEnabled = true
    }
    
    //    MARK: - func animate
    
    func animate(toggle: Bool) {
        
        if toggle {
            UIView.animate (withDuration: 0.5,
                            animations: {
                self.tableViewPattern.isHidden = false
                self.tableViewPattern.frame = CGRect(x: self.typeTF.frame.midX - 164,
                                                     y: self.typeTF.frame.minY + 510,
                                                     width: self.typeTF.frame.width,
                                                     height: 420) } )
        }
    }
    
    //  MARK: - setupNavBar
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem?.isEnabled = false
        nameTF.addTarget(self, action: #selector(enablingBarButtonDone), for: .editingChanged)
        typeTF.addTarget(self, action: #selector(enablingBarButtonDone), for: .touchDown)
    }
    
    //    MARK: - objc func
    
    @objc func showView (frames: CGRect) {
        tableViewPattern.isHidden ? animate(toggle: true) : animate(toggle: false)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.cameraPicker(source: .camera)
            }
            let library = UIAlertAction(title: "Library", style: .default) {_ in
                self.pickPhoto()
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(camera)
            actionSheet.addAction(cancel)
            actionSheet.addAction(library)
            present(actionSheet, animated: true)
        }
    }
    
    @objc func goBack() {
        let pattern = Model(
            name: nameTF.text!,
            description: descriptionTF.text ?? "No description",
            pattern: .init(rawValue: (typeTF.text)!)!,
            image: addImage.image)
            
        delegateNewPattern?.addCell(newpattern: pattern)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func enablingBarButtonDone() {
        if typeTF.text?.isEmpty == false && nameTF.text?.isEmpty == false {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

//  MARK: - extension chooseImagePicker

extension NewObjectViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func cameraPicker (source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func pickPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        addImage.image = (info[.editedImage] as? UIImage)
        addImage.contentMode = .scaleAspectFill
        addImage.clipsToBounds = true
        picker.dismiss(animated: true, completion: nil)
    }
}

//  MARK: - extension UITextFieldDelegate

extension NewObjectViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTF.endEditing(true)
        descriptionTF.endEditing(true)
        return true
    }
}

//  MARK: - extension UITableViewDataSource

extension NewObjectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pattern.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellForSelectorPatternType.identifier, for: indexPath) as? TableViewCellForSelectorPatternType else { return UITableViewCell() }
        let modelForCell = Model.primaryArray[indexPath.row]
        cell.configureView(modelForCell)
        return cell
    }
}

//  MARK: - extension UITableViewDelegate

extension NewObjectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let arrayOfPatternsType = ["Поведенческие", "Порождающие", "Структурные"]
        let example = arrayOfPatternsType[indexPath.row]
        typeTF.text = example
        tableView.isHidden = true
    }
}





