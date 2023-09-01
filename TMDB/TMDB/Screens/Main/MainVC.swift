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
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, self.view.bounds.width, 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        let vm = DetailVM(apiService: viewModel.apiService, movie_id: viewModel.cellVMs[indexPath.row].movie_id ?? 0)
        let vc = DetailVC.instantiate(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY >= contentHeight - scrollView.frame.size.height{
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
//SearchBar
extension MainVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        self.perform(#selector(searchTextChange), with: searchText, afterDelay: 0.5)
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
        searchTextChange("")
    }
}
//Private
extension MainVC{
    @objc func searchTextChange(_ text: String){
        if text.isEmpty{
            viewModel.fetchTrendingMovie()
        }else{
            viewModel.fetchSearchingMovie(query: text)
        }
    }
    func setupView(){
        searchBar.placeholder = "Search"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
    }
    func setupViewModel() {
        // Reload CollectionView closure
        viewModel.callback_reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.collectionView.alwaysBounceVertical = false
                if self?.viewModel.currentPage == 1{
                    self?.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
                }
            }
        }
        viewModel.fetchTrendingMovie()
    }
}
