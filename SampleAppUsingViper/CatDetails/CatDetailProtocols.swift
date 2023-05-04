//
//  CatDetailProtocols.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-05-02.
//

import UIKit

protocol ViewToPresenterCatDetailDelegate {
    var catBreed: CatBreed? { get }
    var view: PresenterToViewCatDetailDelegate? { get set }
    var router: PresenterToRouterCatDetailDelegate? { get set }
    var interactor: PresenterToInteractorCatDetailDelegate? { get set }
    func viewDidload()
}

protocol PresenterToViewCatDetailDelegate: AnyObject {
    var presenter: ViewToPresenterCatDetailDelegate? { get set }
    func fetchedCatDetail(result: Result<Void, NetworkServiceError>)
    func showActivity(show: Bool)
}

protocol PresenterToInteractorCatDetailDelegate: AnyObject {
    var catBreed: CatBreed? { get set }
    var presenter: InteractorToPresenterCatDetailDelegate? { get set }
    func fetchCatDetail()
}

protocol InteractorToPresenterCatDetailDelegate: AnyObject {
    func getCatDetail(result: Result<CatBreed, NetworkServiceError>)
}

protocol PresenterToRouterCatDetailDelegate {
    static func createModule(presenter: CatDetailPresenterDelegates,
                             interractor: PresenterToInteractorCatDetailDelegate,
                             router: PresenterToRouterCatDetailDelegate,
                             with cat: CatBreed) -> UIViewController
}
