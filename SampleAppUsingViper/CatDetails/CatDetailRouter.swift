//
//  CatDetailRouter.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-05-02.
//

import UIKit

typealias CatDetailPresenterDelegates = ViewToPresenterCatDetailDelegate & InteractorToPresenterCatDetailDelegate


final class CatDetailRouter: PresenterToRouterCatDetailDelegate {
    static func createModule(presenter: CatDetailPresenterDelegates = CatDetailPresenter(),
                             interractor: PresenterToInteractorCatDetailDelegate = CatDetailInteractor(),
                             router: PresenterToRouterCatDetailDelegate = CatDetailRouter(),
                             with cat: CatBreed) -> UIViewController {
        let sb = UIStoryboard(storyboard: .main)
        let vc:  CatDetailViewController = sb.instantiateViewController()
        vc.presenter = presenter
        vc.presenter?.router = router
        vc.presenter?.view = vc
        vc.presenter?.interactor = CatDetailInteractor()
        vc.presenter?.interactor?.presenter = presenter
        vc.presenter?.interactor?.catBreed = cat
        return vc
    }
}
