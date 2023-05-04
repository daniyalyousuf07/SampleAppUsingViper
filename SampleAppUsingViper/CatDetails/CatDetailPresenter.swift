//
//  CatDetailPresenter.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-05-02.
//

import UIKit

final class CatDetailPresenter: ViewToPresenterCatDetailDelegate {
    
    private(set) var catBreed: CatBreed?
    weak var view: PresenterToViewCatDetailDelegate?
    var router: PresenterToRouterCatDetailDelegate?
    var interactor: PresenterToInteractorCatDetailDelegate?
    
    func viewDidload() {
        view?.showActivity(show: true)
        interactor?.fetchCatDetail()
    }
}

extension CatDetailPresenter: InteractorToPresenterCatDetailDelegate {
    func getCatDetail(result: Result<CatBreed, NetworkServiceError>) {
        view?.showActivity(show: false)
        if case .success(let breed) = result {
            self.catBreed = breed
            view?.fetchedCatDetail(result: .success(()))
        } else if case .failure(let error) = result {
            view?.fetchedCatDetail(result: .failure(error))
        }
    }
}
