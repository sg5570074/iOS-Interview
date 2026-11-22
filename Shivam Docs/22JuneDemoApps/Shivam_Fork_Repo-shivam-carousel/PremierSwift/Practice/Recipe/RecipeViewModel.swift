//
//  RecipeViewModel.swift
//  PremierSwift
//
//  Created by Shivam Gupta on 03/02/26.
//  Copyright © 2026 Deliveroo. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       print(searchController.searchBar.text)
    }

    private var recipeTxtField = UITextField()
    private var indgredientTxtField = UITextField()
    private var submitBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2.0
        return btn
    }()
    private var stackView:UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.spacing = 10
        st.distribution = .fillProportionally
        st.translatesAutoresizingMaskIntoConstraints = false
        st.backgroundColor = UIColor.cyan
        st.layer.cornerRadius = 10
        return st
    }()

    private var tableView = UITableView()
    private var searchBar = UISearchController()
    var resultData = [StockDetail]()


    override func viewDidLoad() {
        title = "Recipe App"
        [recipeTxtField, indgredientTxtField, submitBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        recipeTxtField.placeholder = "Enter Recipe"
        indgredientTxtField.placeholder = "Enter Ingredient"
        submitBtn.addTarget(self, action: #selector(submitBtnAction), for: .touchUpInside)

        searchBar.searchResultsUpdater = self
        setupTableView()
        view.addSubview(stackView)
        view.addSubview(tableView)
        setupConstraints()
    }

    func setupTableView() {
        tableView.register(StockCell.self, forCellReuseIdentifier: "StockCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        navigationItem.searchController = searchBar
        view.addSubview(tableView)
    }

    func setupConstraints() {
        //Stack View Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])

        //tableViewConstraint
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

   @objc func submitBtnAction() {
       print("Pressed")
       let recipe = recipeTxtField.text ?? ""
       _ = indgredientTxtField.text ?? ""
       let data = StockDetail(sid: recipe)
       resultData.append(data)
       tableView.reloadData()

    }
}

extension RecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockCell
        cell?.configureCell(resultData[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
