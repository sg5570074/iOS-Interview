//
//  ViewController.swift
//  25JuneDemo
//
//  Created by Shivam Gupta on 25/06/25.
//

import UIKit

class ViewController: UIViewController {

    private var tableView = UITableView()
    private var textFeild = UITextField()
    private var sendBtn = UIButton()
    private var stackView = UIStackView()

    private var senderData = [String]()
    private var receiverData = [String]()

    private var viewModel = ChatVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        [tableView, textFeild, sendBtn, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }


        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.addArrangedSubview(textFeild)
        stackView.addArrangedSubview(sendBtn)

        sendBtn.titleLabel?.text = "Send"

        sendBtn.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)

        [tableView, stackView].forEach {
            view.addSubview($0)
        }
        setupTableView()
        setupConstraints()


    }

    @objc func sendMessage(_ sender: UIButton) {

        if let text = textFeild.text {
            senderData.append(text)
        }
        tableView.reloadData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if let randomStr = self.viewModel.receiverMessage.randomElement() {
                self.receiverData.append(randomStr)
                self.tableView.reloadData()
            }

        }

    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(ReceiverCell.self, forCellReuseIdentifier: "ReceiverCell")
        tableView.register(SenderCell.self, forHeaderFooterViewReuseIdentifier: "SenderCell")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-10),

            stackView.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor, constant:10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])

    }

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return senderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as? SenderCell
        return cell!
    }


}




// Chatting Interface :
// Send Message:
// shoudl appear on screen
// After 5 second of sending message, Diaplay random mesaage from array as a receiver message

