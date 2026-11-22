//
//  ViewController.swift
//  POPDemo
//
//  Created by Shivam Gupta on 25/11/25.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel:NewsFlashViewModelProtocol = NewsFlashViewModel()

    private var newSourceData = [NewsSourceModel]()
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupConstraints()
        self.navigationItem.title = "NewsFlash"

        viewModel.getNewRepositoryData { [weak self] data in
            self?.newSourceData = data
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }

    }

    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsSourceCell.self, forCellReuseIdentifier: "NewsSourceCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }


    func setupConstraints() {

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newSourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell") as? NewsSourceCell {
            cell.configureCell(model: newSourceData[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }
    

}

