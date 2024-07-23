//
//  FoodListTableViewController.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import UIKit

class FoodListTableViewController: UITableViewController {
    
    var viewModel: FoodViewModelProtocol?
    private var foodTableHeaderView: FoodTableHeaderView? = FoodTableHeaderView.loadView()
    private var searchBar = CustomSearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel?.getFoods()
    }
}
extension FoodListTableViewController {
    private func bind() {
        viewModel?.dataLoaded = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.setErrorPlaceholder(isShow: false)
                self.foodTableHeaderView?.setData(array: self.viewModel?.getCategories)
                self.tableView.reloadData()
            }
        }
        
        viewModel?.errorHandler = { (message) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.setErrorPlaceholder(text: message)
                self.tableView.reloadData()
            }
        }
    }
    
    private func setErrorPlaceholder(text: String = "", isShow: Bool = true) {
        self.tableView.removeEmptyMessage()
        if isShow {
            self.tableView.showEmptyMessage(text: text)
        }
    }
    
    private func setupUI() {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.clipsToBounds = true
        tableView.register(UINib(nibName: FoodScreenConstant.ViewIndetifire.foodListTableViewCell, bundle: nil), forCellReuseIdentifier: FoodScreenConstant.ViewIndetifire.foodListTableViewCell)
        searchBar.searchDelegate = self

        foodTableHeaderView?.autoresizingMask = .flexibleWidth
        foodTableHeaderView?.translatesAutoresizingMaskIntoConstraints = true
        foodTableHeaderView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * FoodScreenConstant.Height.headerRatio)
        tableView.tableHeaderView = foodTableHeaderView
        tableView.backgroundColor = FoodScreenTheme.Color.black
        tableView.separatorColor = FoodScreenTheme.Color.clear
        foodTableHeaderView?.delegate = self
    }
}

extension FoodListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getFoodsItems.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: FoodScreenConstant.ViewIndetifire.foodListTableViewCell) as? FoodListTableViewCell
        cell?.setFood(viewModel?.getFoodsItems[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FoodScreenConstant.Height.sectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FoodScreenConstant.Height.listItemHeight
    }
}

extension FoodListTableViewController: FoodTableHeaderViewDelegate {
    func collectionCarouselScrollAt(_ id: Int) {
        searchBar.clearSearch()
        viewModel?.loadFoodAsPerCategoryId(id)
    }
}

extension FoodListTableViewController: CustomSearchBarDelegate {
   
    func searchBarTextDidChange(_ searchText: String) {
        viewModel?.searchFood(searchText)
    }
    
    func searchBarCancelButtonClicked() {
        viewModel?.clearSearch()
    }
}
