//
//  DetailVC.swift
//  TMDB
//
//  Created by Charlie on 31/8/23.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var movieBackdrop: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    var viewModel: DetailVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    static func instantiate(viewModel: DetailVM) -> DetailVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        vc.viewModel = viewModel
        return vc
    }
}
//Private
extension DetailVC{
    func setupViewModel() {
        // Reload View
        viewModel.callback_reloadView = { [weak self] in
            DispatchQueue.main.async {
                self?.movieBackdrop.load(url: self?.viewModel.backdropURL, placeholder: nil)
                self?.movieTitle.text = self?.viewModel.title
                self?.year.text = self?.viewModel.year
                self?.overview.text = self?.viewModel.overview
                self?.rate.text = self?.viewModel.rate
            }
        }
        viewModel.fetchDetail()
    }
}
