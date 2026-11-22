//
//  ViewController.swift
//  RecepieApp
//
//  Created by Shivam Gupta on 27/02/25.
//

import UIKit

// Receipe App, where user can enter recepie thier ingredients and display that in a list. Now perform search based on ingredeints.


class ViewController: UIViewController {

//    var recpieButton = UIButton()
//    var tableView = UITableView()
//
//    var receipeCountt = 1
//    var ingredientCountt = 1
//    var prepStepsCountt = 1

    @IBOutlet weak var txtRecepie: UITextField!
    @IBOutlet weak var txtIngredients: UITextField!

    var vieWModel = RecepieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func btnSave(_ sender: Any) {
        let status = vieWModel.validateAndaddReceipe(txtRecepie.text, txtIngredients.text)

        if status {
            let vc = storyboard?.instantiateViewController(withIdentifier: "RecepieListVC") as! RecepieListVC
            vc.data = vieWModel.loadRecepie()
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            showAlert()
        }
    }

    func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "something wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }

}


//    func setButton(){
//        recpieButton.setTitle("Add Receipe", for: .normal)
//        recpieButton.addTarget(self, action: #selector(addRcepie), for: .touchUpInside)
//        recpieButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(recpieButton)
//    }
//
//    func setTableView() {
//        tableView.register(ReceipieCell.self, forCellReuseIdentifier: ReceipieCell.identifier)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.dataSource = self
//        tableView.delegate = self
//        view.addSubview(tableView)
//    }
//
//    func setConstraint() {
//        recpieButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        recpieButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        NSLayoutConstraint.activate([
//            recpieButton.topAnchor.constraint(equalTo: view.topAnchor),
//            recpieButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            recpieButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.topAnchor.constraint(equalTo: recpieButton.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    @objc func addRcepie() {
//        vieWModel.addReceipe(Recepie(id: 1, name: "", ingredient: "", prepSteps: "")) { status in
//            print("Yes added")
//        }
//    }
//
//
//}
//
//extension ViewController : UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listOfRecepie.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell =  tableView.dequeueReusableCell(withIdentifier: ReceipieCell.identifier, for: indexPath) as! ReceipieCell
//        cell.recepieLbl.text = "\(listOfRecepie[indexPath.row].name) \(listOfRecepie[indexPath.row].name)  \(listOfRecepie[indexPath.row].name)"
//        return cell
//    }
//
//}
//
