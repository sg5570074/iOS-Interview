//
//  ViewController.swift
//  World T2
//
//  Created by Shivam Gupta on 06/04/25.
//

import UIKit

class TeamSelectionViewController: UIViewController {
    private var teams: [Team] = []
    private var selectedTeams: [Team] = []

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 60)
        layout.minimumLineSpacing = 10
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Match", for: .normal)
      //  button.isEnabled = true
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Teams"
        view.backgroundColor = .white

        loadTeams()

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: TeamCell.identifier)

        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startMatchTapped), for: .touchUpInside)

        view.addSubview(collectionView)
        view.addSubview(startButton)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -16),

            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func loadTeams() {
        guard let url = Bundle.main.url(forResource: "MatchList", withExtension: "JSON"),
              let data = try? Data(contentsOf: url),
              let teams = try? JSONDecoder().decode([Team].self, from: data) else { return }
        self.teams = teams
        collectionView.reloadData()
    }

    @objc private func startMatchTapped() {

        let matchVC = MatchCenterViewController()
        matchVC.configureTeams(team1: selectedTeams[0], team2: selectedTeams[1])
        navigationController?.pushViewController(matchVC, animated: true)
    }
}

extension TeamSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCell.identifier, for: indexPath) as! TeamCell
        let team = teams[indexPath.item]
        cell.configure(with: team, selected: selectedTeams.contains(where: { $0.name == team.name }))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = teams[indexPath.item]
        if selectedTeams.contains(where: { $0.name == selected.name }) {
            selectedTeams.removeAll { $0.name == selected.name }
        } else if selectedTeams.count < 2 {
            selectedTeams.append(selected)
        }
        startButton.isEnabled = selectedTeams.count == 2
        startButton.backgroundColor = selectedTeams.count == 2 ? .systemGreen : .gray
        collectionView.reloadData()
    }
}
