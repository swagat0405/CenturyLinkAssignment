//
//  ViewController.swift
//  CenturyLinkAssignment
//
//  Created by Swagat Mishra on 4/22/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    //MARK:- Properties
    @IBOutlet weak var unloadButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView! {
        didSet {
            loadingIndicator.hidesWhenStopped = true
        }
    }
    var assets = [Assets]()
    @IBOutlet weak var assetsTableView: UITableView! {
        didSet {
            assetsTableView.dataSource = self
            assetsTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshAssets), for: .valueChanged)
        self.assetsTableView.refreshControl = refresh
    }
    
    //MARK:- Load asset details from n/w
    @objc func refreshAssets() {
        self.loadingIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            FetchAssets().fetchAssets {[weak self] (assets) in
                self?.assets = assets
                DispatchQueue.main.async {
                    if (self?.loadingIndicator.isAnimating)! {
                        self?.loadingIndicator.stopAnimating()
                    }
                    if (self?.assetsTableView.refreshControl?.isRefreshing)! {
                        self?.assetsTableView.refreshControl?.endRefreshing()
                    }
                    self?.assetsTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func unloadAssets(_ sender: UIButton) {
    }
    @IBAction func loadAssets(_ sender: UIButton) {
        refreshAssets()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshAssets()
    }

}

//MARK:- Tableview methods
extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.performBatchUpdates({
                assets.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        assets.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssetCell") as? AssetTableViewCell
        
        cell?.assetName?.text = assets[indexPath.row].assetTag
        cell?.assetId?.text = "#" + assets[indexPath.row].techId! + "-" + assets[indexPath.row].id!
        cell?.assetLocation.text = assets[indexPath.row].assetStatus?.capitalized
        
        //Loading dummy images based on asset Tag
        if assets[indexPath.row].assetTag == "S123122" {
            cell?.productImageView.image = UIImage(named: "PrismTV")
            cell?.locationImageView.image = UIImage(named: "FromStore")
        }
        else if assets[indexPath.row].assetTag == "S123123" {
            cell?.productImageView.image = UIImage(named: "Router")
            cell?.locationImageView.image = UIImage(named: "FromCust")
        }
        
        return cell!
    }
}

