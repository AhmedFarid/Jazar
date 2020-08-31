//
//  nottaficationVC.swift
//  Jazar
//
//  Created by Ahmed farid on 8/27/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class nottaficationVC: UIViewController {
    
    @IBOutlet weak var notifacrtionTabelView: UITableView!
    
    
    var collection = [nottaficationData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handelApiBanner()
       // setUpNavColore(false)
    }
    
    func handelApiBanner() {
        
        
        self.notifacrtionTabelView.register(UINib.init(nibName: "nottaficationCell", bundle: nil), forCellReuseIdentifier: "cell")
        notifacrtionTabelView.delegate = self
        notifacrtionTabelView.dataSource = self
        
        notifacrtionTabelView.rowHeight = UITableView.automaticDimension
        notifacrtionTabelView.estimatedRowHeight = UITableView.automaticDimension
        
        
        notificaitonsApi.getNotificaitonsApi{ (error,success,collection) in
            if let collection = collection{
                self.collection = collection.data ?? []
                print(collection)
                self.notifacrtionTabelView.reloadData()
            }
        }
    }
    
    
}


extension nottaficationVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = notifacrtionTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? nottaficationCell {
            cell.configureCell(products: collection[indexPath.row])
            return cell
        }else {
            return nottaficationCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
