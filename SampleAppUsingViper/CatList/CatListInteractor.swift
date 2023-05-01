//
//  CatListInteractor.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-04-30.
//

import Foundation
import Combine

final class CatListInteractor: PresenterToInteractorCatListDelegate {
    
    enum CatServiceEndPoints {
        case fetchCats(params: [String: String])
        
        var endPoint: String {
            switch self {
            case .fetchCats:
                return "/v1/breeds"
            }
        }
        
        var queryParams: [String: String] {
            switch self {
            case .fetchCats:
                return [:]
            }
        }
    }
    
    
    var presenter: InteractorToPresenterCatListDelegate?
    private var networkService: NetworkServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol = NetworkService(baseURLString: "https://api.thecatapi.com")) {
        self.networkService = networkService
    }
    
    func fetchCatList() {
        getCats().receive(on: DispatchQueue.main).sink(receiveCompletion: { [weak self] completion in
            if case .failure(let error) = completion {
                self?.presenter?.fetchCatList(result: .failure(error))
            }
        }, receiveValue: { [weak self] cats in
            self?.presenter?.fetchCatList(result: .success(cats))
        }).store(in: &cancellable)
    }
    
    private func getCats() -> AnyPublisher<[CatBreed], NetworkServiceError> {
        let fetchCatsRequest = CatServiceEndPoints.fetchCats(params: [:])
        return networkService.getPublisherForArrayResponse(endpoint: fetchCatsRequest.endPoint,
                                                            queryParameters: fetchCatsRequest.queryParams)
    }
    
    
    
    func getCatDetail(at index: Int) {
        getCats().receive(on: DispatchQueue.main).sink(receiveCompletion: { [weak self] completion in
            if case .failure(let error) = completion {
                self?.presenter?.fetchCatDetail(result: .failure(error))
            }
        }, receiveValue: { [weak self] cats in
            self?.presenter?.fetchCatDetail(result: .success(cats[index]))
        }).store(in: &cancellable)
    }
}
