//
//  File.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-04-30.
//

import UIKit

protocol ViewToPresenterCatListDelegate {
    
    var interactor: PresenterToInteractorCatListDelegate? { get set }
    var view: PresenterToViewCatListDelegate? { get set }
    var router: PresenterToRouterCatListDelegate?  { get  set }
        
    func viewDidLoad()
    func refresh()
    
    
    func numberOfRows(section: Int)-> Int
    func setCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectRowAt(index: Int)
    func tableViewCellHeight() -> CGFloat
    
}


protocol PresenterToViewCatListDelegate: AnyObject {
    var presenter: ViewToPresenterCatListDelegate? { get set }
    func onFetchCatList(result: Result<Void, NetworkServiceError>)
    func showActivity()
    func hideActivity()
}

protocol PresenterToInteractorCatListDelegate {
    var presenter: InteractorToPresenterCatListDelegate? { get set }
    func fetchCatList() 
    func getCatDetail(at index: Int)
}

protocol InteractorToPresenterCatListDelegate: AnyObject {
    func fetchCatList(result: Result<[CatBreed], NetworkServiceError>)
    func fetchCatDetail(result: Result<CatBreed,  NetworkServiceError>)  
}

protocol PresenterToRouterCatListDelegate {
    static func createModule(presenter: CatListPresenterDelegates,
                             interactor:  PresenterToInteractorCatListDelegate,
                             router: PresenterToRouterCatListDelegate) -> UINavigationController?
    func pushToCatDetail(on view: PresenterToViewCatListDelegate,
                         with cat: CatBreed)
}
