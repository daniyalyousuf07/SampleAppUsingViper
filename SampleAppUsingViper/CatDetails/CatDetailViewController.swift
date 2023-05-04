//
//  CatDetailViewController.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-05-02.
//

import UIKit

final class CatDetailViewController: UIViewController {
    
    @IBOutlet weak private var lblName: UILabel!
    @IBOutlet weak private var lblBreed: UILabel!
    
    var presenter: ViewToPresenterCatDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
}

extension CatDetailViewController: PresenterToViewCatDetailDelegate {
    func fetchedCatDetail(result: Result<Void, NetworkServiceError>) {
        if case .success = result {
            lblName.text = presenter?.catBreed?.name
            lblBreed.text = presenter?.catBreed?.origin
        } else if case .failure(let error) = result {
            
        }
    }
    
    func showActivity(show: Bool) {
        //show indicator
    }
}
