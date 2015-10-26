//
//  ViewController.swift
//  Template1-iOS
//
//  Copyright © 2015 Sky UK. All rights reserved.
//

import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class WikipediaSearchViewController: ViewController {
    
    private var disposeBag = DisposeBag()
    private var viewModel: SearchViewModel? = nil
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        
        let resultsTableView = self.searchDisplayController!.searchResultsTableView
        let searchBar = self.searchDisplayController!.searchBar
        
        resultsTableView.registerNib(UINib(nibName: "WikipediaSearchCell", bundle: nil), forCellReuseIdentifier: "WikipediaSearchCell")
        
        resultsTableView.rowHeight = 194
        
        let selectedResult: Observable<SearchResultViewModel> = resultsTableView.rx_modelSelected().asObservable()
        
        let viewModel = SearchViewModel(
            searchText: searchBar.rx_text.asObservable(),
            selectedResult: selectedResult
        )
        
        // map table view rows
        // {
        viewModel.rows
            .bindTo(resultsTableView.rx_itemsWithCellIdentifier("WikipediaSearchCell")) { (_, viewModel, cell: WikipediaSearchCell) in
                cell.viewModel = viewModel
            }
            .addDisposableTo(disposeBag)
        // }

        // dismiss keyboard on scroll
        // {
        resultsTableView.rx_contentOffset
            .subscribeNext { _ in
                if searchBar.isFirstResponder() {
                    _ = searchBar.resignFirstResponder()
                }
            }
            .addDisposableTo(disposeBag)

        self.viewModel = viewModel
        // }
    }
}
