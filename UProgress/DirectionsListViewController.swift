//
//  ViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//
import Foundation
import UIKit
import MBProgressHUD

class DirectionsListViewController: BaseViewController, DirectionViewProtocol, DirectionsListViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemsList:[Direction]! = []
    private let userNick = "vforvad"
    private let manager = DirectionManager()
    private var presenter: DirectionListPresenterImpl!
    private var viewInstance: DirectionsListView!
    var actInd : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CommonFunctions.DeviceData.isIPad() {
            self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        }
        viewInstance = DirectionsListView(viewController: self, table: tableView, searchBar: searchBar)
        presenter = DirectionListPresenterImpl(model: manager, view: self)
        presenter.loadDirections(userNick: userNick)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func successDirectionsLoad(directions: [Direction]!) {
        viewInstance.updateData(directions: directions)
    }
    
    internal func successLoadMoreDirections(directions: [Direction]!) {
        viewInstance.addDirections(directions: directions)
    }
    
    internal func stopLoader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    internal func startLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    internal func failedDirectionsLoad(error: NSError) {
        
    }
    
    internal func clickOnItem(direction: Direction, indexPath: IndexPath!) {
        
    }
    
    internal func refreshTriggered() {
        presenter.reloadDirectionsList(userNick: userNick)
    }
    
    internal func infiniteScrollTriggered() {
        presenter.loadMoreDirections(userNick: userNick)
    }
    
    internal func startRefresh() {
        viewInstance.refreshControl.beginRefreshing()
    }
    
    internal func stopRefresh() {
        viewInstance.refreshControl.endRefreshing()
    }
    
    internal func stopInfiniteScroll() {
        viewInstance.stopInfiniteScroll()
    }
    
    func backAction() {
//        if let sidebar = self.splitViewController?.viewControllers[0] as! SidebarViewController {
//            sidebar.popToRootViewControllerAnimated(true)
//        }
    }
}

