//
//  ViewController.swift
//  SampleTableView
//
//  Created by 922235 on 26/03/20.
//  Copyright © 2020 922235. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivityIndicatory()
        APIHandler.shared.fetchDetails(completion: {
            self.removeActivityIndicator()
            self.title = APIHandler.shared.navTitle
            self.configureTableView()
        })
        
        // If url does not work use Response.json stub data to load table
        /* APIHandler.shared.jsonData(completion: {
         self.removeActivityIndicator()
         self.title = APIHandler.shared.navTitle
         self.configureTableView()
         })*/
    }
    
    // method to configure tableview properties
    func configureTableView() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refresh), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    // Refresh control action
    @objc func refresh(sender:AnyObject)
    {
        
        APIHandler.shared.fetchDetails(completion: {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        })
        /* APIHandler.shared.jsonData(completion: {
         self.tableView.reloadData()
         self.refreshControl?.endRefreshing()
         })*/
        
    }
    
    // Tableview delegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIHandler.shared.modelstruct.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! CustomTableViewCell
        
        let tableList = APIHandler.shared.modelstruct[indexPath.row]
        
        if tableList.imageHref.isEmpty {
            cell.cellImage.image = UIImage(named: "ExclamationRed.png")
        }else {
            cell.cellImage.imageFromServerURL(tableList.imageHref, placeHolder: UIImage(named: "ExclamationRed.png"))
        }
        
        
        if tableList.title == "" && tableList.description == "" && tableList.imageHref == "" {
            APIHandler.shared.modelstruct.remove(at: indexPath.row)
            tableView.reloadData()
        }
        cell.titleLabel.text = tableList.title
        cell.descriptionLabel.text = tableList.description
        
        return cell
    }
    
    
}

// extension to show and hide activity indicator
extension ViewController {
    func showActivityIndicatory() {
        activityView.center = self.view.center
        activityView.color = .red
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func removeActivityIndicator() {
        activityView.removeFromSuperview()
        activityView.stopAnimating()
    }
}
