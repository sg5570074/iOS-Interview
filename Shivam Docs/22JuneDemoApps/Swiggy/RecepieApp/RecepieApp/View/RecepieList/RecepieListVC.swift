//
//  RecepieListVC.swift
//  RecepieApp
//
//  Created by Shivam Gupta on 06/05/25.
//

import Foundation
import UIKit


class RecepieListVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    var refreshController = UIRefreshControl()
    var label = UILabel()

    var data = [Recepie]()
    var filterData = [Recepie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        tableView.register(UINib(nibName: "RecepieCell", bundle: nil), forCellReuseIdentifier: "RecepieCell")
        tableView.dataSource = self
        filterData = data
        tableView.reloadData()

//        searchController.searchBar.delegate = self
//        searchController.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController

        refreshController.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshController
    }

    @objc
    func refresh(sender: UIRefreshControl) {
        sender.endRefreshing()
        tableView.reloadData()
    }
}

extension RecepieListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecepieCell") as! RecepieCell
        cell.recepieData = filterData[indexPath.row]
        cell.setupCell()
        return cell
    }
    
}

extension RecepieListVC: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        if searchText == "" {
            filterData = data

        }else {
            filterData = data.filter{ $0.ingredient.joined(separator: ",").lowercased().contains(searchText.lowercased()) }
        }

        tableView.reloadData()
    }
}
