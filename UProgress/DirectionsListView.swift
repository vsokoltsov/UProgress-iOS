//
//  DirectionsListView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class DirectionsListView: NSObject, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var searchActive : Bool = false
    var cellIdentifier = "cellId"
    var itemsList:[Direction]! = []
    var filtered:[Direction] = []
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var viewController: DirectionsListViewProtocol!
    
    init(viewController: DirectionsListViewProtocol!, table: UITableView!, searchBar: UISearchBar!) {
        super.init()
        self.viewController = viewController
        self.tableView = table
        self.searchBar = searchBar
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellId")
        var item: Direction!
        if (searchActive) {
            item = filtered[indexPath.row]
        }
        else {
            item = itemsList[indexPath.row]
        }
        cell.textLabel?.text = item.title
        return cell
    }


    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive) {
            return filtered.count
        }
        return itemsList.count
    }
    
    public func updateData(directions: [Direction]!) {
        self.itemsList = directions
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController.clickOnItem(direction: itemsList[indexPath.row], indexPath: indexPath)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = itemsList.filter({ (direction) -> Bool in
            let tmp: NSString = direction.title as NSString
            let range = tmp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
}