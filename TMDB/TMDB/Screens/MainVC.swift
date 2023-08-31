//
//  MainVC.swift
//  TMDB
//
//  Created by Charlie on 30/8/23.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var viewModel = {
        MainVM(apiService: ApiService(baseURLString: URL_base))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
}
//CollectionView
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellVMs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        cell.viewModel = viewModel.cellVMs[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vm = TeamDetailVM(team: viewModel.cellVMs[indexPath.row], apiService: viewModel.apiService)
//        let vc = TeamDetailVC.instantiate(viewModel: vm)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY >= contentHeight - scrollView.frame.size.height{
            print("Load Next")
            viewModel.fetchNextPage()
        }
    }
}

let ITEMS_SPACING = 8.0
//let ITEMS_PADING = 8.0
let ITEMS_COLUMNS = 3.0

extension MainVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - (ITEMS_COLUMNS - 1) * ITEMS_SPACING) / ITEMS_COLUMNS
        return CGSize(width: itemWidth, height: itemWidth * 1.75)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ITEMS_SPACING
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ITEMS_SPACING
    }
}
//Private
extension MainVC{
    func setupViewModel() {
        // Reload CollectionView closure
        viewModel.callback_reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.collectionView.alwaysBounceVertical = false
                
//                let contentOffset = self?.collectionView.contentOffset
//                self?.collectionView.layoutIfNeeded()
//                self?.collectionView.setContentOffset(contentOffset!, animated: false)
            }
        }
        viewModel.fetchFirstPage()
    }
}
