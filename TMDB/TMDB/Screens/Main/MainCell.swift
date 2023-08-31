//
//  MainCell.swift
//  TMDB
//
//  Created by Charlie on 31/8/23.
//

import UIKit

class MainCell: UICollectionViewCell{
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    static var identifier: String { return String(describing: self) }
    
    var viewModel: MainCellVM?{
        didSet{
            poster.load(url: viewModel?.poster, placeholder: nil)
            year.text = viewModel?.year
            title.text = viewModel?.title
            rate.text = viewModel?.rate
        }
    }
}
