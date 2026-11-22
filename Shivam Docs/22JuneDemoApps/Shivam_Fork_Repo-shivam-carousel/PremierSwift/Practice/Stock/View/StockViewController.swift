//
//  StockViewController.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 02/02/26.
//

import UIKit
import Foundation

class StockViewController: UIViewController {

    var viewModel = Stock1ViewModel()
    private var data = [StockDetail]()
    private var tableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stock App"
        setupTableView()
        setupConstraints()
        fetchData()
    }

    func setupTableView() {
        tableView.register(StockCell.self, forCellReuseIdentifier: "StockCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func fetchData() {
        viewModel.fetchDataFromRepo { [weak self] response in
            Task { @MainActor in
                self?.data = response
                self?.tableView.reloadData()
            }
            print(response)
        }
    }
}

extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockCell
        cell?.configureCell(data[indexPath.row])
        cell?.onButtonTap = { [weak self] in
            guard let self else { return }

            let item = self.data[indexPath.row]
            print("Button tapped for:", item)

            // navigation / API / ViewModel call
        }

        return cell ?? UITableViewCell()
    }
}
