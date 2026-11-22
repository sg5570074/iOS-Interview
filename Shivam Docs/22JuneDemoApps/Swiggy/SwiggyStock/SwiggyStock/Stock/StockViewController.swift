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
    var data = [StockDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }


    @MainActor
    func fetchData() {
        viewModel.fetchDataFromRepo { [weak self] response in
            self?.data = response
            print(response)
        }
    }
}
