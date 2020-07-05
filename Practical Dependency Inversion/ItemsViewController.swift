//
//  ItemsViewController.swift
//  Practical Dependency Inversion
//
//  Created by Hanyu on 2020/6/11.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import UIKit

struct Item {
    let titleText: String
    let contentText: String
}

protocol ItemsViewControllerSpec {
    
    func items(completion: @escaping (Result<[Item], Error>) -> Void)
}

class ItemsViewController: UIViewController {
    
    init(spec: ItemsViewControllerSpec) {
        self.spec = spec
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let spec: ItemsViewControllerSpec
    
    private var items: [Item] = []
    
    private lazy var tableView = makeTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        spec.items { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.items = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                //Present error
                print(error)
            }
        }
    }
}

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        let item = items[indexPath.row]
        cell.layoutUI(with: item)
        return cell
    }
}

extension ItemsViewController {
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        return tableView
    }
}

extension Item: ItemTableViewCellSpec {
    
    var title: String? {
        return titleText
    }
    
    var content: String? {
        return contentText
    }
}
