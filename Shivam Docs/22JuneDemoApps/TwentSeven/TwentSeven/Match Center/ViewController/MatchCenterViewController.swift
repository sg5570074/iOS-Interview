//
//  MatchCenterViewController.swift
//  World T2
//
//  Created by Shivam Gupta on 06/04/25.
//

import UIKit

class MatchCenterViewController: UIViewController {

    private var team1: Team!
    private var team2: Team!

    private var team1Score = 0
    private var team2Score = 0
    private var team1Wickets = 0
    private var team2Wickets = 0
    private var team1Balls = 0
    private var team2Balls = 0
    private var battingTeamIndex = 0
    private var isMatchOver = false

    private let outcomes: [(String, Int)] = [
        ("0", 25), ("1", 20), ("2", 15), ("3", 5), ("4", 10), ("6", 5),
        ("Out", 10), ("Wide", 5), ("No Ball", 5)
    ]

    private var outcomeLabel = UILabel()
    private var nextBallButton = UIButton(type: .system)

    private let team1Label = UILabel()
    private let team2Label = UILabel()
    private let team1ScoreLabel = UILabel()
    private let team2ScoreLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Match Center"
        view.backgroundColor = .white
        setupUI()
        updateScoreLabels()
    }

    func configureTeams(team1: Team, team2: Team) {
        self.team1 = team1
        self.team2 = team2
    }

    private func setupUI() {
        team1Label.text = "\(team1.name) (Batting)"
        team2Label.text = "\(team2.name) (Bowling)"
        [team1Label, team2Label, team1ScoreLabel, team2ScoreLabel, outcomeLabel, nextBallButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        team1ScoreLabel.text = "Score: 0/0"
        team2ScoreLabel.text = "yet to bat"

        outcomeLabel.textAlignment = .center
        outcomeLabel.font = UIFont.boldSystemFont(ofSize: 32)
        outcomeLabel.backgroundColor = .lightGray

        nextBallButton.setTitle("Play Next Ball", for: .normal)
        nextBallButton.backgroundColor = .systemGreen
        nextBallButton.setTitleColor(.white, for: .normal)
        nextBallButton.layer.cornerRadius = 8
        nextBallButton.addTarget(self, action: #selector(playBall), for: .touchUpInside)

        NSLayoutConstraint.activate([
            team1Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            team1Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            team1ScoreLabel.topAnchor.constraint(equalTo: team1Label.bottomAnchor, constant: 8),
            team1ScoreLabel.leadingAnchor.constraint(equalTo: team1Label.leadingAnchor),

            team2Label.topAnchor.constraint(equalTo: team1ScoreLabel.bottomAnchor, constant: 20),
            team2Label.leadingAnchor.constraint(equalTo: team1Label.leadingAnchor),

            team2ScoreLabel.topAnchor.constraint(equalTo: team2Label.bottomAnchor, constant: 8),
            team2ScoreLabel.leadingAnchor.constraint(equalTo: team2Label.leadingAnchor),

            outcomeLabel.topAnchor.constraint(equalTo: team2ScoreLabel.bottomAnchor, constant: 30),
            outcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            outcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            outcomeLabel.heightAnchor.constraint(equalToConstant: 150),

            nextBallButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextBallButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextBallButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextBallButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func playBall() {
        guard !isMatchOver else { return }

        let outcome = randomOutcome()
        outcomeLabel.text = outcome

        if battingTeamIndex == 0 {
            applyOutcome(toScore: &team1Score, wickets: &team1Wickets, balls: &team1Balls, outcome: outcome)
            if team1Wickets == 3 || team1Balls == 12 {
                battingTeamIndex = 1
                team1Label.text = "\(team1.name) (Bowling)"
                team2Label.text = "\(team2.name) (Batting)"
            }
        } else {
            applyOutcome(toScore: &team2Score, wickets: &team2Wickets, balls: &team2Balls, outcome: outcome)
            if team2Wickets == 3 || team2Balls == 12 || team2Score > team1Score {
                isMatchOver = true
                showResult()
            }
        }

        updateScoreLabels()
    }

    private func applyOutcome(toScore score: inout Int, wickets: inout Int, balls: inout Int, outcome: String) {
        switch outcome {
        case "0", "1", "2", "3", "4", "6":
            score += Int(outcome) ?? 0
            balls += 1
        case "Out":
            wickets += 1
            balls += 1
        case "Wide", "No Ball":
            score += 1
        default:
            break
        }
    }

    private func updateScoreLabels() {
        team1ScoreLabel.text = "Score: \(team1Score)/\(team1Wickets)    Overs: \(ballsToOvers(team1Balls))"
        if battingTeamIndex == 0 {
            team2ScoreLabel.text = "yet to bat"
        } else {
            team2ScoreLabel.text = "Score: \(team2Score)/\(team2Wickets)    Overs: \(ballsToOvers(team2Balls))"
        }
    }

    private func ballsToOvers(_ balls: Int) -> String {
        let overs = balls / 6
        let remainder = balls % 6
        return "\(overs).\(remainder)"
    }

    private func randomOutcome() -> String {
        let totalWeight = outcomes.map { $0.1 }.reduce(0, +)
        let rand = Int.random(in: 0..<totalWeight)
        var sum = 0
        for (outcome, weight) in outcomes {
            sum += weight
            if rand < sum {
                return outcome
            }
        }
        return "0"
    }

    private func showResult() {
        nextBallButton.setTitle("Match Over", for: .normal)
        nextBallButton.isEnabled = false
        var result = ""

        if team1Score > team2Score {
            result = "\(team1.name) Wins!"
        } else if team2Score > team1Score {
            result = "\(team2.name) Wins!"
        } else {
            result = "It's a Tie!"
        }

        outcomeLabel.text = result
    }
}
