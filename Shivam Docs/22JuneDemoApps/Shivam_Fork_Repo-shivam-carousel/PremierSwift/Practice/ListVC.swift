//
//  ListVC.swift
//  PremierSwift
//
//  Created by Shivam Gupta on 31/01/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ListVC : UIViewController {

    var tableView: UITableView!
    var countryList: [CountryList]?
    private var cancellables = Set<AnyCancellable>()
    let httpUtitlity = HttpUitilityCombine()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Country List"
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        view.addSubview(tableView)

        // set Constraint
        
        NSLayoutConstraint.activate([
            
        ])
        
        

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])


        loadData()

    }

    func loadData() {
        //        let apiManager = ApiManager()
        //        apiManager.callCountryListApi { [weak self] response in
        //            self?.countryList = response
        //            DispatchQueue.main.async {
        //                self?.tableView.reloadData()
        //            }
        //
        //        }
        let endPoint = "https://restcountries.com/v3.1/region/europe"
                let httpUtility = HttpUitility()

//                httpUtility.getApi(URL(string: endPoint)!, responseType: [CountryList].self) { [weak self] response in
//                    switch response {
//                    case .success(let result):
//                        self?.countryList =  result
//                        DispatchQueue.main.async {
//                            self?.tableView.reloadData()
//                        }
//                    case .failure(let error):
//                        print(error)
//                    }
//        
//                }

        Task {
            let response = await httpUtility.getAPi(URL(string: endPoint)!, responseType: [CountryList].self)
            switch response {
            case .success(let result):
                self.countryList =  result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }

        }



        httpUtitlity.getApi(URL(string: endPoint)!, responseType: [CountryList].self)
            .sink { _ in

            } receiveValue: { [weak self] data in
                self?.countryList = data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &self.cancellables)


    }

}

extension ListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.customLabel.text = countryList?[indexPath.row].name?.common
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = SecondVC()
        secondVC.capital = countryList?[indexPath.row].capital?.first
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}



// MARK: - Model

struct CountryList: Decodable {
    var name:CityName?
    var capital: [String]?
    var price: Int?

    enum CodingKeys: CodingKey {
        case name
        case capital
        case price
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(CityName.self, forKey: .name)
        self.capital = try container.decodeIfPresent([String].self, forKey: .capital)
        if let intValue = try? container.decode(Int.self, forKey: .price) {
                    price = intValue
                } else if let stringValue = try? container.decode(String.self, forKey: .price),
                          let intValue = Int(stringValue) {
                    price = intValue
                } else {
                    // ✅ REQUIRED fallback
                    price = nil
//                    throw DecodingError.typeMismatch(
//                        Int.self,
//                        DecodingError.Context(
//                            codingPath: [CodingKeys.price],
//                            debugDescription: "Expected Int or String for price"
//                        )
//                    )
                }
    }
}

struct CityName: Decodable {
    var common: String?
}


// MARK: - Cell

class ListCell: UITableViewCell {
    var customLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    var asView = UIView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()

    }

    func setupUI() {
        asView.transform = CGAffineTransform(rotationAngle: 3)
        contentView.addSubview(customLabel)

        NSLayoutConstraint.activate([
            customLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                        customLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                        customLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                        customLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// Service

class ApiManager {

    let endPoint = "https://restcountries.com/v3.1/region/europe"

    func callCountryListApi(completionHandler:@escaping (([CountryList]?)->Void)) {

        guard let url  = URL(string: endPoint) else { return }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { repsonseData, response,_ in

            guard let repsonseData else { return }

            do {
                let responseResult = try JSONDecoder().decode([CountryList].self, from: repsonseData)
                print(responseResult)
                completionHandler(responseResult)
            } catch {
                completionHandler(nil)
            }

        }.resume()
    }


    func callCountryListApi<T: Decodable>(completionHandler:@escaping (([T]?)->Void)) {

        guard let url  = URL(string: endPoint) else { return }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { repsonseData, response,_ in

            guard let repsonseData else { return }

            do {
                let responseResult = try JSONDecoder().decode([T].self, from: repsonseData)
                print(responseResult)
                completionHandler(responseResult)
            } catch {
                completionHandler(nil)
            }

        }.resume()
    }
}



class SecondVC: UIViewController {
   private var label: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    var capital:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        label.text = capital
    }
}



// MARK: - HttpUtility using UrlSession

class HttpUitility {


    func getAPi<T: Decodable>(_ url: URL, responseType: T.Type) async -> (Result<T,Error>) {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
               let decodedData = try JSONDecoder().decode(responseType, from: data)
               return .success(decodedData)
           } catch {
               return .failure(error)
           }
    }
    
    func getApi<T: Decodable & Sendable>(_ reuquestUrl: URL, responseType: T.Type, completion: @escaping ((Result<T,Error>)->())) {

        URLSession.shared.dataTask(with: reuquestUrl) { responseData, response, error in

            guard let data = responseData else { return }

            do {
                let result = try JSONDecoder().decode(responseType, from: data)
                completion(.success(result))
            }catch(let error) {
                completion(.failure(error))
            }
        }.resume()
    }

    func postApi<T: Decodable>(_ reuquestUrl: URL, httpBody: Data, responseType: T.Type, completion: @escaping (Result<T, Error>)->()) {
        var request = URLRequest(url: reuquestUrl)
        request.httpMethod = "post"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "content-type")

        URLSession.shared.dataTask(with: request) { responseData, response, error in

            guard let data = responseData else { return }

            do {
              let result = try JSONDecoder().decode(responseType, from: data)
                completion(.success(result))
            }catch(let error) {
                completion(.failure(error))
            }
        }.resume()
    }
}

class HttpUitilityCombine {
    private var subscribtion = Set<AnyCancellable>()

    func getApi<T: Decodable>(_ reuquestUrl: URL, responseType: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self else { return }
            URLSession.shared.dataTaskPublisher(for: reuquestUrl)
                .tryMap { (data, response) -> Data in
                    return data
                }
                .decode(type: responseType, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in

                    switch completion {
                    case .finished:
                        break
                    case . failure(let error):
                        return promise(.failure(error))
                    }

                } receiveValue: { data in
                    return promise(.success(data))
                }
                .store(in: &self.subscribtion)
        }
    }
    
    
    func get<T: Decodable>(url:URL, responseType: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    return data
                }
                .decode(type: responseType, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    
                    switch completion {
                    case .finished:
                        break
                    case . failure(let error):
                        return promise(.failure(error))
                    }

                } receiveValue: { data in
                    return promise(.success(data))
                }
                .store(in: &self?.subscribtion)
        }
        

    }
    
}
