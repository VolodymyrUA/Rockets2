//
//  LaunchesVC.swift
//  TestProjectTableView
//
//  Created by Володимир Смульський on 10/8/19.
//  Copyright © 2019 Volodymyr Smulskyi. All rights reserved.
//

import Foundation
import UIKit

protocol  LaunchesVCDelegete: class {
    func  didSelectedCell(data: [Launch]?)
}

class LaunchesVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leadingConstForSlider: NSLayoutConstraint!
    
    @IBAction func upcomingBtn(_ sender: Any) {
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @IBAction func previousBtn(_ sender: Any) {
        self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: true)
    }
    
    weak var delegate:  LaunchesVCDelegete?
    let viewModel = LaunchesVM()
    var launch: [Launch]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.makeRequest { (launches) in
            DispatchQueue.main.async {
                self.launch = launches
            }
            
        }
       // delegate?.didSelectedCell(data: self.launch)
    }
    
}

extension LaunchesVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 648)
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension LaunchesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchesCollectionViewCell", for: indexPath) as! LaunchesCollectionViewCell
        cell.backgroundColor = indexPath.row == 0 ?.blue :.yellow
        cell.reload(data: launch ?? [])
        return cell
    }
    
    //Scrollview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         self.leadingConstForSlider.constant = (scrollView.contentOffset.x * 0.5)
    }
}


