//
//  CatDetailInteractor.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-05-02.
//

import Foundation

final class CatDetailInteractor: PresenterToInteractorCatDetailDelegate {
    var catBreed: CatBreed?
    
    weak var presenter: InteractorToPresenterCatDetailDelegate?
    
    func fetchCatDetail() {
        if let catBreed = catBreed {
            presenter?.getCatDetail(result: .success(catBreed)) // mock data make actual call.
        }
    }
}
