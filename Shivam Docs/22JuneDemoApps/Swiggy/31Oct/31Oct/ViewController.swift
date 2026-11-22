//
//  ViewController.swift
//  31Oct
//
//  Created by Shivam Gupta on 31/10/25.
//

import UIKit

class ViewController: UIViewController {

    var currecnyViewModel = ConvertorViewModel()

    var data = [String:Double]()

    var userInt:Double = 5
    var finalConversion = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        currecnyViewModel.getCurrenctDictionary { [weak self] data in
            self?.data = data
            print(data)
        }
        print("hjbknlm;")

    }


    func currecnyConversion() {
    }
}

