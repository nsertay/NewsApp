//
//  AllNewsController.swift
//  NewsApp
//
//  Created by Nurmukhanbet Sertay on 06.05.2024.
//

import UIKit
import SnapKit

protocol SegmentedValueChangedDelegate: AnyObject {
    func valueChanged(index: Int)
}

class AllNewsController: UITableViewController {
    
    let vm = NewsViewModel.shared
    
    var articles = [Article]()
    var segmentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always
        fetchData(segmentIndex)
    }
    
    func setupTableView() {
        title = "Новости"
        
        tableView.separatorStyle = .none
        tableView.register(SegmentedControllerCell.self, forCellReuseIdentifier: SegmentedControllerCell.identifier)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
    }
    
    func fetchData(_ segmentIndex: Int) {
        switch segmentIndex {
        case 0:
            NewsViewModel.shared.fetchNews { [weak self] result in
                switch result {
                case .success(let articles):
                    self?.articles = articles
                    self?.reloadTableView()
                case .failure(let error):
                    print(error)
                }
            }
        case 1:
            articles = NewsViewModel.shared.getLocalNews()
            reloadTableView()
        default:
            break
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension AllNewsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SegmentedControllerCell.identifier, for: indexPath) as! SegmentedControllerCell
            cell.selectionStyle = .none
            cell.delegate = self
            
            return cell
        case 1...articles.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
            cell.article = articles[indexPath.row - 1]
            cell.selectionStyle = .none
            
            return cell
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row > 0 else { return }
        
        let vc = NewsDescriptionController()
        vc.article = articles[indexPath.row - 1]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AllNewsController: SegmentedValueChangedDelegate {
    func valueChanged(index: Int) {
        segmentIndex = index
        fetchData(index)
    }
}
