//
//  CatListCell.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-04-30.
//

import UIKit

final class CatListCell: UITableViewCell {

    @IBOutlet weak private var lblTitle: UILabel!
    
    private var title: String? = "" {
        didSet {
            lblTitle.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func bindData(cat: CatBreed) {
        title = cat.name
    }
}
