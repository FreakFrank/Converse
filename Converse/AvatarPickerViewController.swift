//
//  AvatarPickerViewController.swift
//  Converse
//
//  Created by Kareem Ismail on 8/23/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var darkLightSegment: UISegmentedControl!
    @IBOutlet weak var avatarCollectionView: UICollectionView!
    
    var avatarType: AvatarType = .dark
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarCollectionView.delegate = self
        avatarCollectionView.dataSource = self
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func darkLightChanged(_ sender: Any) {
        
        if darkLightSegment.selectedSegmentIndex == 0 {
            avatarType = .dark
        }
        else {
            avatarType = .light
        }
        
//        if avatarType == .dark {
//            avatarType = .light
//        }
//        else {
//            avatarType = .dark
//        }
        avatarCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        var numOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width >= 320 {
            numOfColumns = 4
        }
        
        let spaceBetweenColumns: CGFloat = 10
        let padding: CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenColumns) / numOfColumns
        return CGSize(width: cellDimension, height: cellDimension)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDataService.instance.setAvatarName(avatarName: "\(avatarType)\(indexPath.item)")
        self.dismiss(animated: true, completion: nil)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AVATAR_CELL_IDENTIFIER, for: indexPath) as? AvatarCellCollectionViewCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        
        return AvatarCellCollectionViewCell()
    }
    
}
