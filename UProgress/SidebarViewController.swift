//
//  SidebarViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 30.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class SidebarViewController: UIViewController, NavigationViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    private var navigationView: NavigationView!
    let notificationName = Notification.Name("signedIn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(SidebarViewController.signedIn(user:)), name: notificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: Selector(("signedOut:")), name: NSNotification.Name(rawValue: "signOut"), object: nil)
        navigationView = NavigationView(viewController: self, table: tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    internal func onItemSelect(segueName: String!) {
        if CommonFunctions.DeviceData.isIphone() {
            segueForNavigationController(identifier: segueName)
        }
        else {
            self.performSegue(withIdentifier: segueName, sender: self)
        }
    }
    
    //MARK: Segue Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        
        if (segue.identifier == "directions") {
            _ = navVC.viewControllers.first as! DirectionsListViewController
        }
        if (segue.identifier == "sign_in") {
            let tableVC = navVC.viewControllers.first as! AuthorizationsViewController
            tableVC.signIn = true
        }
        
        if (segue.identifier == "sign_up") {
            let tableVC = navVC.viewControllers.first as! AuthorizationsViewController
            tableVC.signIn = false
        }
    }
    
    private func segueForNavigationController(identifier: String!) {
        var viewController: UIViewController!
        let cacheIdentifier = identifier
        
        switch identifier {
        case "directions":
            viewController = CommonFunctions.fromStoryboard(identifier: "DirectionsListViewController")
        case "sign_in":
            let authViewController = CommonFunctions.fromStoryboard(name: "AuthorizationStoryboard", identifier: "AuthorizationViewController") as! AuthorizationsViewController
            authViewController.signIn = true
            viewController = authViewController as UIViewController
        case "sign_up":
            let authViewController = CommonFunctions.fromStoryboard(name: "AuthorizationStoryboard", identifier: "AuthorizationViewController") as! AuthorizationsViewController
            authViewController.signIn = false
            viewController = authViewController as UIViewController
        default:
            viewController = CommonFunctions.fromStoryboard(identifier: "DirectionsListViewController")
        }
        
        sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: viewController))
    }
    
    func signedIn(user: Notification) {
        if let currentUserInfo = user.object {
            AuthorizationService.sharedInstance.currentUser = currentUserInfo as! User
            navigationView.setUser(user: AuthorizationService.sharedInstance.currentUser)
        }
    }
    
    func signedOut() {
    
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil);
    }
    
    func setNavBarToTheView() {
        let height: CGFloat = 150 //whatever height you want
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
    }
}
