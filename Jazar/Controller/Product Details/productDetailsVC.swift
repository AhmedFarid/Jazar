//
//  productDetailsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/5/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos
import NVActivityIndicatorView

class productDetailsVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var imageCollactionView: UICollectionView!
    @IBOutlet weak var smallDescText: UILabel!
    @IBOutlet weak var bigDescText: UILabel!
    @IBOutlet weak var genralPrice: UILabel!
    @IBOutlet weak var genralPrice2: UILabel!
    @IBOutlet weak var genralPrice3: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var discountPrice2: UILabel!
    @IBOutlet weak var pageControlBanner: UIPageControl!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productName2: UILabel!
    @IBOutlet weak var rateProduct: CosmosView!
    @IBOutlet weak var reviewsBtn: buttonView!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var qtnText: UILabel!
    @IBOutlet weak var bigCartBtn: buttonView!
    @IBOutlet weak var plusBTN: UIButton!
    @IBOutlet weak var minBtm: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var buyNowBtn: buttonView!
    @IBOutlet weak var saved: UILabel!
    @IBOutlet weak var stokeNum: UILabel!
    @IBOutlet weak var stokeStatus: UILabel!
    @IBOutlet weak var typeUnit: UILabel!
    
    var timer : Timer?
    var currentIndex = 0
    var singleItem: productsDataArray?
    var images = [ProductImage]()
    var isFav = 0
    var isCart = 0
    var qty = 1
    var selected = Int()
    var index = Int()
    let window = UIApplication.shared.keyWindow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()		
    }
    
    func setupView() {
        self.imageCollactionView.register(UINib.init(nibName: "bannerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        imageCollactionView.delegate = self
        imageCollactionView.dataSource = self
        
        self.pageControlBanner.numberOfPages = images.count //self.slider.count
        self.pageControlBanner.currentPage = 0
        let inStock = NSLocalizedString("In Stock:", comment: "profuct list lang")
        stokeNum.text = "\(inStock) \(singleItem?.stock ?? 0)"
        typeUnit.text = "\(singleItem?.unitValue ?? 0) \(singleItem?.unit ?? "")"
        if singleItem?.stock == 0 {
            let outOfStock = NSLocalizedString("Out Of Stock", comment: "profuct list lang")
            stokeStatus.text = outOfStock
            stokeStatus.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }else if singleItem?.stock ?? 0 <= 5 {
            let limitedQuantity = NSLocalizedString("Limited quantity", comment: "profuct list lang")
            stokeStatus.text = limitedQuantity
        }else {
            stokeStatus.text = ""
        }
        
        productName.text = singleItem?.name
        let Save = NSLocalizedString("Save", comment: "profuct list lang")
        let LE = NSLocalizedString("LE", comment: "profuct list lang")
        saved.text = "\(Save) \(singleItem?.discount ?? 0) \(LE)"
        productName2.text = singleItem?.name
        rateProduct.rating = Double(singleItem?.totalRate ?? 0)
        rateProduct.text = "\(singleItem?.totalNumberReview ?? 0)"
        smallDescText.text = singleItem?.shortDescription?.html2String
        bigDescText.text = singleItem?.datumDescription?.html2String
        genralPrice.text = "\(singleItem?.total ?? 0) \(singleItem?.currency ?? "")"
        genralPrice2.text = "\(singleItem?.total ?? 0) \(singleItem?.currency ?? "")"
        genralPrice3.text = "\(singleItem?.total ?? 0) \(singleItem?.currency ?? "")"
        discountPrice.text = "\(singleItem?.salePrice ?? 0) \(singleItem?.currency ?? "")"
        discountPrice2.text = "\(singleItem?.salePrice ?? 0) \(singleItem?.currency ?? "")"
        discountPrice.strikeThrough(true)
        discountPrice2.strikeThrough(true)
        self.isFav = singleItem?.isProductFavoirte ?? 0
        self.isCart = singleItem?.productInCart ?? 0
        
        
        if singleItem?.salePrice == 0 {
            discountPrice.isHidden = true
            discountPrice2.isHidden = true
        }else {
            discountPrice.isHidden = false
            discountPrice2.isHidden = false
        }
        
        if helperAuth.getAPIToken() == nil {
            cartBtn.isHidden = true
            favBtn.isHidden = true
            shareBtn.isHidden = true
        }else {
            cartBtn.isHidden = false
            favBtn.isHidden = false
            shareBtn.isHidden = false
            if singleItem?.productInCart == 1 {
                cartBtn.setImage(UIImage(named: "onCart"), for: .normal)
                let removeFromCart = NSLocalizedString("Remove from cart", comment: "profuct list lang")
                bigCartBtn.setTitle(removeFromCart, for: .normal)
                buyNowBtn.isHidden = true
                qtnText.text = "\(singleItem?.productInCartQty ?? 0)"
                qty = singleItem?.productInCartQty ?? 0
                self.discountPrice.text = "\((singleItem?.salePrice ?? 0) * self.qty) \(singleItem?.currency ?? "")"
                self.discountPrice2.text = "\((singleItem?.salePrice ?? 0) * self.qty) \(singleItem?.currency ?? "")"
                self.genralPrice.text = "\((Int((singleItem?.total ?? 0))) * self.qty) \(singleItem?.currency ?? "")"
                genralPrice2.text = "\((Int((singleItem?.total ?? 0))) * self.qty) \(singleItem?.currency ?? "")"
                genralPrice3.text = "\((Int((singleItem?.total ?? 0))) * self.qty) \(singleItem?.currency ?? "")"
                plusBTN.isHidden = true
            }else {
                cartBtn.setImage(UIImage(named: "NoCart"), for: .normal)
                let addCart = NSLocalizedString("Add Cart", comment: "profuct list lang")
                bigCartBtn.setTitle("\(addCart)", for: .normal)
                buyNowBtn.isHidden = false
                plusBTN.isHidden = false
            }
            if singleItem?.isProductFavoirte == 1 {
                favBtn.setImage(UIImage(named: "Group 1503"), for: .normal)
                self.isFav = 1
            }else {
                favBtn.setImage(UIImage(named: "NoFave"), for: .normal)
                self.isFav = 0
            }
        }
        
        
    }
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        if currentIndex < images.count {//slider.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.imageCollactionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControlBanner.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.imageCollactionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControlBanner.currentPage = currentIndex
            currentIndex = 1
        }
        
    }
    
    
    func fav(url: String) {
        loaderHelper()
        favoriteApi.favoriteOption(url: url, product_id: "\(singleItem?.id ?? 0)") { (error, success, message) in
            if success {
                if message?.success == true {
                    if url == URLs.addFavorite {
                        self.isFav = 1
                        self.favBtn.setImage(UIImage(named: "Group 1503"), for: .normal)
                        self.showAlert(title: "Favorite", message: "Added To Favorite")
                    }else if url == URLs.removeFavorite {
                        self.isFav = 0
                        self.favBtn.setImage(UIImage(named: "NoFave"), for: .normal)
                        self.showAlert(title: "Favorite", message: "Remove From Favorite")
                    }
                    self.stopAnimating()
                }else {
                    self.showAlert(title: "Favorite", message: "")
                    self.stopAnimating()
                }
            }else {
                self.showAlert(title: "Favorite", message: "Check your network")
                self.stopAnimating()
            }
        }
    }
    
    
    func cart(url: String,type: String) {
        loaderHelper()
        cartApi.cartOption(url: url, product_id: "\(singleItem?.id ?? 0)", qty: "\(qty)") { (error, success, message,errorStoke,x) in
            if success {
                if message?.success == true {
                    if url == URLs.addToCart {
                        self.isCart = 1
                        self.cartBtn.setImage(UIImage(named: "onCart"), for: .normal)
                        let removeFromCart = NSLocalizedString("Remove from cart", comment: "profuct list lang")
                        self.bigCartBtn.setTitle(removeFromCart, for: .normal)
                        self.buyNowBtn.isHidden = true
                        self.plusBTN.isHidden = true
                        self.minBtm.isHidden = true
                        if type == "BuyNowAddToCart" {
                            let alert = UIAlertController(title: "Order", message: "Add To Cart You will moved to Cart", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                                let tabbarController = self.window!.rootViewController as! UITabBarController
                                tabbarController.selectedIndex = 2
                            }))
                            self.present(alert, animated: true, completion: nil)		
                        }else {
                           self.showAlert(title: "Cart", message: "Added To Cart")
                        }
                        
                    }else if url == URLs.removeFromCart {
                        self.isCart = 0
                        self.cartBtn.setImage(UIImage(named: "NoCart"), for: .normal)
                        let addCart = NSLocalizedString("Add Cart", comment: "profuct list lang")
                        self.bigCartBtn.setTitle(addCart, for: .normal)
                        self.buyNowBtn.isHidden = false
                        self.qty = 1
                        self.discountPrice.text = "\((self.singleItem?.salePrice ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
                        self.discountPrice2.text = "\((self.singleItem?.salePrice ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
                        self.genralPrice.text = "\((self.singleItem?.total  ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
                        self.genralPrice2.text = "\((self.singleItem?.total  ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
                        self.genralPrice3.text = "\((self.singleItem?.total  ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
                        self.qtnText.text = "1"
                        self.plusBTN.isHidden = false
                        self.showAlert(title: "Cart", message: "Removed From Cart")
                    }
                    self.stopAnimating()
                }else {
                    self.showAlert(title: "Cart", message: "Out Of Stock")
                    self.stopAnimating()
                }
            }else {
                self.showAlert(title: "Cart", message: "Check your network")
                self.stopAnimating()
            }
            
            if errorStoke?.success == false {
                self.showAlert(title: "stock", message: "Out Of Stock")
                self.stopAnimating()
            }else {
                self.showAlert(title: "Cart", message: "Check your network")
                self.stopAnimating()
            }
        }
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        let textToShare = [ singleItem?.productLink ?? "" ]
               let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view
               activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
               self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func reviewsBtnAction(_ sender: Any) {
        let vc = reviewsVC(nibName: "reviewsVC", bundle: nil)
        vc.reviwes = singleItem?.reviews ?? []
        vc.id = singleItem?.id ?? 0
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func mainQntyBTN(_ sender: Any) {
        qty = qty - 1
        //self.discountPrice.text = "\((singleItem?.salePrice ?? 0) * self.qty) \(singleItem?.currency ?? "")"
        //self.discountPrice2.text = "\((singleItem?.salePrice ?? 0) * self.qty) \(singleItem?.currency ?? "")"
        self.genralPrice.text = "\((self.singleItem?.total ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
        //self.genralPrice2.text = "\((self.singleItem?.total ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
        //self.genralPrice3.text = "\((self.singleItem?.total ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
        self.qtnText.text = "\(qty)"
        if qty == 1 {
            minBtm.isHidden = true
        }else {
            minBtm.isHidden = false
        }
    }
    
    @IBAction func addQunttyBTN(_ sender: Any) {
        qty = qty + 1
        //self.discountPrice.text = "\((singleItem?.salePrice ?? 0) * self.qty) \(singleItem?.currency ?? "")"
        //self.discountPrice2.text = "\((singleItem?.salePrice ?? 0) * self.qty) \(singleItem?.currency ?? "")"

        self.genralPrice.text = "\((self.singleItem?.total ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
        //self.genralPrice2.text = "\((self.singleItem?.total ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
        //self.genralPrice3.text = "\((self.singleItem?.total ?? 0) * self.qty) \(self.singleItem?.currency ?? "")"
        self.qtnText.text = "\(qty)"
        if qty == 1 {
            minBtm.isHidden = true
        }else {
            minBtm.isHidden = false
        }
        
    }
    
    @IBAction func smallAddCartAction(_ sender: Any) {
        if isCart == 1 {
            cart(url: URLs.removeFromCart, type: "normalAddToCart")
            self.refesHcart()
        }else if isCart == 0 {
            cart(url: URLs.addToCart, type: "normalAddToCart")
            self.refesHcart()
        }
    }
    
    @IBAction func addToFavouritsBTN(_ sender: Any) {
        if isFav == 1 {
            fav(url: URLs.removeFavorite)
        }else if isFav == 0 {
            
            fav(url: URLs.addFavorite)
        }
    }
    
    @IBAction func buyNowAction(_ sender: Any) {
        if helperAuth.getAPIToken() == nil {
            let vc = loginVC(nibName: "loginVC", bundle: nil)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }else {
            if isCart == 1 {
                cart(url: URLs.removeFromCart, type: "BuyNowAddToCart")
                self.refesHcart()
            }else if isCart == 0 {
                cart(url: URLs.addToCart, type: "BuyNowAddToCart")
                if singleItem?.stock == 0 {
                     	
                }else {
                
                }
                self.refesHcart()
            }
        }
    }
    
    @IBAction func addToCartAction(_ sender: Any) {
        if helperAuth.getAPIToken() == nil {
            let vc = loginVC(nibName: "loginVC", bundle: nil)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }else {
            if isCart == 1 {
                cart(url: URLs.removeFromCart, type: "normalAddToCart")
                self.refesHcart()
            }else if isCart == 0 {
                cart(url: URLs.addToCart, type: "normalAddToCart")
                self.refesHcart()
            }
        }
    }
}


extension productDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = productViewImagesVC(nibName: "productViewImagesVC", bundle: nil)
        self.index = indexPath.item
        self.selected = 1
        vc.selected = self.selected
        vc.index = self.index
        vc.images = self.images
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = imageCollactionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? bannerCell {
            cell.configureCellProducts(images: images[indexPath.row])
            return cell
        }else {
            return bannerCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: imageCollactionView.frame.size.width, height: imageCollactionView.frame.size.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == imageCollactionView{
            currentIndex = Int(scrollView.contentOffset.x / imageCollactionView.frame.size.width)
            pageControlBanner.currentPage = currentIndex
        }
    }
}
