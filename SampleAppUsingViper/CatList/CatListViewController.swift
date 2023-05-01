//
//  CatListViewController.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-04-30.
//

import UIKit

final class CatListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ViewToPresenterCatListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    func setupUI() {
        title = "Viper-Sample-App"
        tableView.registerCell(type: CatListCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .gray
    }
}


extension CatListViewController: PresenterToViewCatListDelegate {
    func onFetchCatList(result: Result<Void, NetworkServiceError>) {
        if case .success = result {
            tableView.reloadData()
        } else if case  .failure(let error) = result {
            print(error.localizedDescription)
        }
    }
    
    func showActivity() {
        //show indicator
    }
    
    func hideActivity() {
        //hide  indicator
    }
}

extension CatListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.setCell(tableView: tableView, indexPath: indexPath) ?? .init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter?.tableViewCellHeight() ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         presenter?.didSelectRowAt(index: indexPath.row)
    }
}
