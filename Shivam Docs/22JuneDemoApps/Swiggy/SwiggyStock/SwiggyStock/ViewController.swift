//
//  ViewController.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 07/05/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet unowned var tableView: UITableView!

    var data = [DataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getStockData { [weak self] stockData in
            self?.data = stockData
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        setupTableView()
    }

    let viewModel = StockViewModel()

    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(StockCell.nib(), forCellReuseIdentifier: StockCell.identifier)

    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.identifier) as! StockCell
        let stcokData = data[indexPath.row]
        cell.configureCell(stcokData)
        return cell
    }
}

