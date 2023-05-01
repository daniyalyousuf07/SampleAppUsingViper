//
//  CatListRouter.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-04-30.
//

import  UIKit

typealias CatListPresenterDelegates = ViewToPresenterCatListDelegate & InteractorToPresenterCatListDelegate

final class CatListRouter:  PresenterToRouterCatListDelegate {
    static func createModule(presenter: CatListPresenterDelegates = CatListPresenter(),
                             interactor:  PresenterToInteractorCatListDelegate  = CatListInteractor(),
                             router: PresenterToRouterCatListDelegate = CatListRouter()) -> UINavigationController? {
        let storyboard = UIStoryboard(storyboard: .main)
        let vc:  CatListViewController = storyboard.instantiateViewController()
        
        let navVC = UINavigationController(rootViewController: vc)
        
        vc.presenter = presenter
        vc.presenter?.interactor = interactor
        vc.presenter?.view =  vc
        vc.presenter?.router = router
        vc.presenter?.interactor?.presenter = presenter
        return navVC
    }
    
    func pushToCatDetail(on view: PresenterToViewCatListDelegate, with cat: CatBreed) {
        // connection with detail router...
    }
}
