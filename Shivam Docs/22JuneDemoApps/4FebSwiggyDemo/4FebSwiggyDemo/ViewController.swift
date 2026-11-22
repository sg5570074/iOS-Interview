//
//  ViewController.swift
//  4FebSwiggyDemo
//
//  Created by Shivam Gupta on 04/02/26.
//

import UIKit

class ViewController: UIViewController {

    var viewModel:StockViewModelProtocol = StockViewModel()
    var stockDetails = [StockDetails]()

    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stock App"
        setupTableView()
        setConstraints()
        loadData()
    }

    private func setupTableView() {
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        view.addSubview(tableView)

    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func loadData() {
        viewModel.getStockData {[weak self] data in
            self?.stockDetails = data
            DispatchQueue.main.async {
                self?.tableView.reloadRows(at: [IndexPath], with: <#T##UITableView.RowAnimation#>)
            }
        }

//        DispatchQueue.global().async { [weak self] in
//            while(true) {
//                
//                print("aaa")
//            }
//        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.cellIdentifier, for: indexPath) as? StockCell
        cell?.configureCell(stockDetails[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

