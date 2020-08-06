//
//  newOffersVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class newOffersVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var searchTF: textFieldView!
    @IBOutlet weak var allProductCollectionView: UICollectionView!
    
    var singleItme: dataCategoriesArray?
    var products = [productsDataArray]()
    var name = ""
    var url = URLs.offers
    
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false)
        searchTF.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handelApiflashSale(name: name)
    }
    
    func SetupSearch() {
        if url == URLs.favoirtes {
            searchTF.isHidden = true
        }else {
            searchTF.isHidden = false
        }
    }
    
    @objc func handelApiflashSale(name: String) {
        self.allProductCollectionView.register(UINib.init(nibName: "allProductViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        allProductCollectionView.delegate = self
        allProductCollectionView.dataSource = self
        guard !isLoading else { return }
        isLoading = true
        loaderHelper()
        homeApi.productsApi(url: url, pageName: 1,category_id: "\(singleItme?.id ?? 0)", subcategory_id: "",name: name){ (error,success,products) in
            self.isLoading = false
            if let products = products{
                self.products = products.data?.data ?? []
                print(products)
                self.allProductCollectionView.reloadData()
                self.current_page = 1
                self.last_page = products.data?.meta?.lastPage ?? 0
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func cart(url: String,id: String) {
        loaderHelper()
        cartApi.cartOption(url: url, product_id: id, qty: "\(1)") { (error, success, message,errorStoke,x) in
            if success {
                if message?.success == true {
                    if url == URLs.addToCart {
                        self.handelApiflashSale(name: self.name)
                        let title = NSLocalizedString("Cart", comment: "profuct list lang")
                        let message = NSLocalizedString("Added To Cart", comment: "profuct list lang")
                        self.showAlert(title: title, message: message)
                    }else if url == URLs.removeFromCart {
                        self.handelApiflashSale(name: self.name)
                        let title = NSLocalizedString("Cart", comment: "profuct list lang")
                        let message = NSLocalizedString("Removed From Cart", comment: "profuct list lang")
                        self.showAlert(title: title, message: message)
                    }
                    self.stopAnimating()
                }else {
                    let title = NSLocalizedString("Cart", comment: "profuct list lang")
                    let message = NSLocalizedString("Out Of Stock", comment: "profuct list lang")
                    self.showAlert(title: title, message: message)
                    self.stopAnimating()
                }
            }else {
                let title = NSLocalizedString("Cart", comment: "profuct list lang")
                let message = NSLocalizedString("Check your network", comment: "profuct list lang")
                self.showAlert(title: title, message: message)
                self.stopAnimating()
            }
            
            if errorStoke?.success == false {
                let title = NSLocalizedString("stock", comment: "profuct list lang")
                let message = NSLocalizedString("Out Of Stock", comment: "profuct list lang")
                self.showAlert(title: title, message: message)
                self.stopAnimating()
            }else {
                let title = NSLocalizedString("Cart", comment: "profuct list lang")
                let message = NSLocalizedString("Check your network", comment: "profuct list lang")
                self.showAlert(title: title, message: message)
                self.stopAnimating()
            }
        }
    }
    
    func fav(url: String,id: String) {
        loaderHelper()
        favoriteApi.favoriteOption(url: url, product_id: id) { (error, success, message) in
            if success {
                if message?.success == true {
                    if url == URLs.addFavorite {
                        self.handelApiflashSale(name: self.name)
                        let title = NSLocalizedString("Favorite", comment: "profuct list lang")
                        let message = NSLocalizedString("Added To Favorite", comment: "profuct list lang")
                        self.showAlert(title: title, message: message)
                    }else if url == URLs.removeFavorite {
                        self.handelApiflashSale(name: self.name)
                        let title = NSLocalizedString("Favorite", comment: "profuct list lang")
                        let message = NSLocalizedString("Remove From Favorite", comment: "profuct list lang")
                        self.showAlert(title: title, message: message)
                    }
                    self.stopAnimating()
                }else {
                    let title = NSLocalizedString("Favorite", comment: "profuct list lang")
                    self.showAlert(title: title, message: "")
                    self.stopAnimating()
                }
            }else {
                let title = NSLocalizedString("Favorite", comment: "profuct list lang")
                let message = NSLocalizedString("Check your network", comment: "profuct list lang")
                self.showAlert(title: title, message: message)
                self.stopAnimating()
            }
        }
    }
    
    @objc func loadMore(name: String) {
        self.allProductCollectionView.register(UINib.init(nibName: "allProductViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        allProductCollectionView.delegate = self
        allProductCollectionView.dataSource = self
        guard !isLoading else {return}
        guard current_page < last_page else {return}
        isLoading = true
        homeApi.productsApi(url: url, pageName: current_page+1,category_id: "\(singleItme?.id ?? 0)", subcategory_id: "",name: name){ (error,success,products) in
            self.isLoading = false
            if let products = products{
                self.products.append(contentsOf: products.data?.data ?? [])
                print(products)
                self.allProductCollectionView.reloadData()
                self.current_page += 1
                self.last_page = products.data?.meta?.lastPage ?? 0
                self.stopAnimating()
            }
        }
    }
}


extension newOffersVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = productDetailsVC(nibName: "productDetailsVC", bundle: nil)
        vc.singleItem = products[indexPath.row]
        vc.images = products[indexPath.row].productImages ?? []
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = allProductCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? allProductViewCell {
            cell.configureCell(products: products[indexPath.row])
            cell.addCart = {
                if self.products[indexPath.row].productInCart == 1 {
                    self.cart(url: URLs.removeFromCart, id: "\(self.products[indexPath.row].id ?? 0)")
                    self.refesHcart()
                }else if self.products[indexPath.row].productInCart == 0 {
                    self.cart(url: URLs.addToCart, id: "\(self.products[indexPath.row].id ?? 0)")
                    self.refesHcart()
                }
            }
            
            cell.addFav = {
                if self.products[indexPath.row].isProductFavoirte == 1 {
                    self.fav(url: URLs.removeFavorite, id: "\(self.products[indexPath.row].id ?? 0)")
                }else if self.products[indexPath.row].isProductFavoirte == 0 {
                    self.fav(url: URLs.addFavorite,id: "\(self.products[indexPath.row].id ?? 0)")
                }
                
            }
            return cell
        }else {
            return allProductViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        return CGSize(width: allProductCollectionView.frame.size.width/2, height: 340)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = self.products.count
        if indexPath.row ==  count-1 {
            self.loadMore(name: name)
        }
    }
    
}


extension newOffersVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        performAction()
        return true
    }
    
    func performAction() {
        handelApiflashSale(name: searchTF.text ?? "")
    }
}
