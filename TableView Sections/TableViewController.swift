//
//  TableViewControllerViewController.swift
//  TableView with sections
//
//  Created by Дмитрий Пономарев on 01.10.2022.
//


//MARK: - Make Models


import UIKit
import SnapKit

final class TableViewController: UIViewController {
    
    //  MARK: - UI properties
    
    private let tableview = UITableView()
    var behaviourArray: [Model] = []
    var creationalArray: [Model] = []
    var structuralArray: [Model] = []
    
    //  MARK: - View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addViews()
        makeConstraints()
        setupViews()
        divideArray()
    }
}

//  MARK: - Extension TableViewController

private extension TableViewController {
    
    //  MARK: - addViews
    
    func addViews() {
        view.addSubview(tableview)
    }
    
    //  MARK: - makeConstraints
    
    func makeConstraints() {
        
        tableview.snp.makeConstraints {
            $0 .edges.equalToSuperview()
        }
    }
    
    //  MARK: - setupViews
    
    func setupViews() {
        setupNavBar()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableview.separatorInset.left = 125
        tableview.reloadData()
        tableview.estimatedRowHeight = 80
        tableview.rowHeight = 80
    }
    
    //  MARK: - setupNavBar
    
    func setupNavBar() {
        navigationItem.title = "Project's patterns"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(makeNewCell))
    }
    
    @objc func makeNewCell() {
        let secondView = NewObjectViewController()
        secondView.delegateNewPattern = self
        self.navigationController?.pushViewController(secondView, animated: true)
    }
    
    //  MARK: - divideArray
    
    func divideArray () {
        let behaviors = Model.primaryArray.filter { $0.pattern == .behaviour }
        behaviourArray.append(contentsOf: behaviors)
        let structurals = Model.primaryArray.filter { $0.pattern == .structural }
        structuralArray.append(contentsOf: structurals)
        let creationals = Model.primaryArray.filter { $0.pattern == .creational }
        creationalArray.append(contentsOf: creationals)
    }
}

//  MARK: - Extension DataSource

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return behaviourArray.count
        case 1: return creationalArray.count
        case 2: return structuralArray.count
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Pattern.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let nameOfSection = Model.primaryArray.map { $0.pattern }[section].rawValue
        return nameOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        var modelForCell = Model.primaryArray[indexPath.row]
        if indexPath.section == 0 {
            modelForCell = behaviourArray [indexPath.row]
        }
        else if indexPath.section == 1 {
            modelForCell = creationalArray [indexPath.row]
        }
        else if indexPath.section == 2 {
            modelForCell = structuralArray [indexPath.row]
        }
        cell.configureView(modelForCell)
        return cell
    }
}

//  MARK: - Extension TableViewDelegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        var example = Model.primaryArray [indexPath.row]
        
        if indexPath.section == 0 {
            example = behaviourArray [indexPath.row]
        }
        else if indexPath.section == 1 {
            example = creationalArray [indexPath.row]
        }
        else if indexPath.section == 2 {
            example = structuralArray [indexPath.row]
        }
        let detailVC = DetailViewController(item: example)
        detailVC.delegate = self
        tableView.reloadData()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //  MARK: - deletingObject
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
            case 0: behaviourArray.remove(at: indexPath.row)
            case 1: creationalArray.remove(at: indexPath.row)
            case 2: structuralArray.remove(at: indexPath.row)
            default: return
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//  MARK: - Extension AddNewPattern

extension TableViewController: AddNewPattern {
    func addCell(newpattern: Model) {
        self.dismiss(animated: true) {
            Model.primaryArray.append(newpattern)
            if newpattern.pattern == .structural {
                self.structuralArray.append(newpattern)
            }
            else if newpattern.pattern == .behaviour {
                self.behaviourArray.append(newpattern)
            }
            else if newpattern.pattern == .creational {
                self.creationalArray.append(newpattern)
            }
            self.tableview.reloadData()
        }
    }
}

//  MARK: - Extension DetailViewControllerDelegate

extension TableViewController: DetailViewControllerDelegate {
    func changedDescription(patternWithNewDescription: Model) {
        Model.primaryArray.append(patternWithNewDescription)
        if patternWithNewDescription.pattern == .structural {
            self.structuralArray.append(patternWithNewDescription)
        }
        else if patternWithNewDescription.pattern == .behaviour {
            self.behaviourArray.append(patternWithNewDescription)
        }
        else if patternWithNewDescription.pattern == .creational {
            self.creationalArray.append(patternWithNewDescription)
        }
        self.tableview.reloadData()
    }
}



//open -
//public -
//internal -
//private -
//fileprivate -

//
//
