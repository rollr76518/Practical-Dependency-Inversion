//
//  ItemsViewController.swift
//  Practical Dependency Inversion
//
//  Created by Hanyu on 2020/6/11.
//  Copyright © 2020 Hanyu. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    
    private let dataManager = DataMananger()
    
    private var items: [Item] = []
    
    private lazy var tabelView = makeTabelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.items { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.items = items
                DispatchQueue.main.async {
                    self.tabelView.reloadData()
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
        let cell = tabelView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        let item = items[indexPath.row]
        cell.layoutUI(with: item)
        return cell
    }
}

extension ItemsViewController {
    
    private func makeTabelView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tabelView.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        return tableView
    }
}
