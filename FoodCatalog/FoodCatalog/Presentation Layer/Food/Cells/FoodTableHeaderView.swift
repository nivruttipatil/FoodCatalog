//
//  FoodTableHeaderView.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import UIKit

protocol FoodTableHeaderViewDelegate {
    func collectionCarouselScrollAt(_ id: Int)
}

final class FoodTableHeaderView: UIView {
    @IBOutlet weak var collectionCarousel: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    private var currentCarouselIndex = 0
    private var arrCarouselList = [FoodCategory]()
    var delegate: FoodTableHeaderViewDelegate?
    
    static func loadView() -> FoodTableHeaderView? {
        guard let view = Bundle.main
            .loadNibNamed(FoodScreenConstant.ViewIndetifire.foodTableHeaderView, owner: self, options: nil)?[0]
                as? FoodTableHeaderView else {
            return nil
        }
        view.setupFoodTableHeaderView()
        return view
    }
    
    private func setupFoodTableHeaderView() {
        collectionCarousel.register(UINib(nibName: FoodScreenConstant.ViewIndetifire.CollectionCellImage, bundle: nil), forCellWithReuseIdentifier: FoodScreenConstant.ViewIndetifire.CollectionCellImage)
        collectionCarousel.decelerationRate = .fast
        collectionCarousel.dataSource = self
        collectionCarousel.delegate = self
    }
    
    func setData(array: [FoodCategory]?) {
        arrCarouselList = array ?? []
        pageControl.numberOfPages = arrCarouselList.count
        collectionCarousel.reloadData()
    }
    
}
//MARK: - UICollectionViewDataSource
extension FoodTableHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCarouselList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: FoodScreenConstant.ViewIndetifire.CollectionCellImage, for: indexPath) as? FoodListCollectionViewCell
        cell?.setFoodCategory(arrCarouselList[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FoodTableHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(ceil(scrollView.contentOffset.x/scrollView.bounds.size.width))
        if currentCarouselIndex != currentPage, arrCarouselList.count > currentPage , let category = arrCarouselList[currentPage].id {
            delegate?.collectionCarouselScrollAt(category)
            pageControl.currentPage = currentPage
            currentCarouselIndex = currentPage
        }
    }
}
