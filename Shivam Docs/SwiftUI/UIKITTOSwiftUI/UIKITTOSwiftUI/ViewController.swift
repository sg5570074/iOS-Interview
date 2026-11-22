//
//  ViewController.swift
//  UIKITTOSwiftUI
//
//  Created by Shivam on 30/04/26.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vm = ViewModel()
       let vc = UIHostingController(rootView: UIViewDemo().environment(vm))
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

