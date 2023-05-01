//
//  CatListPresenter.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-04-30.
//

import UIKit

final class CatListPresenter: ViewToPresenterCatListDelegate {
    
    private var cats = [CatBreed]() 
    weak var view: PresenterToViewCatListDelegate?
    var interactor: PresenterToInteractorCatListDelegate?
    var router: PresenterToRouterCatListDelegate?
    
    func viewDidLoad() {
        view?.showActivity()
        interactor?.fetchCatList()
    }
    
    func refresh() {
            
    }
    
    func numberOfRows(section: Int) -> Int {
        return cats.count
    }
    
    func setCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: CatListCell.self, for: indexPath)  as? CatListCell else {
            return .init()
        }
        // always pass business model not data model but this is not in focus in this sample proj.
        cell.bindData(cat: cats[indexPath.row])
        return cell
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.getCatDetail(at: index)
    }
    
    func tableViewCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension CatListPresenter: InteractorToPresenterCatListDelegate {
    func fetchCatList(result: Result<[CatBreed], NetworkServiceError>) {
        if case .success(let cats) = result {
            self.cats = cats
            view?.hideActivity()
            view?.onFetchCatList(result: .success(()))
        } else if case .failure(let error) = result {
            view?.hideActivity()
                view?.onFetchCatList(result: .failure(error))
        }
    }
    
    func fetchCatDetail(result: Result<CatBreed, NetworkServiceError>) {
        if case  .success(let cat) = result, let _ = view {
            router?.pushToCatDetail(on: view!, with: cat)
        }
    }
}
