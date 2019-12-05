//
//  LaunchesCollectionViewCell.swift
//  TestProjectTableView
//
//  Created by Volodymyr Smulskyi on 10/18/19.
//  Copyright © 2019 Volodymyr Smulskyi. All rights reserved.
//

import UIKit

class LaunchesCollectionViewCell: UICollectionViewCell {
    
    var launch: [Launch]?
    
    @IBOutlet weak var launchTableView: UITableView!{
        didSet {
            launchTableView.rowHeight = UITableView.automaticDimension
            launchTableView.estimatedRowHeight = 50.0
        }
    }
    
    func reload (data:[Launch]) {
        launch = data
        self.launchTableView.reloadData()
    }
    
}

extension LaunchesCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return launch?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                guard let launchData = launch?[indexPath.row] else {return UITableViewCell()}
        
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LaunchTableViewCell
                cell.setData(data: launchData)
                return cell
    }
    
    
}
