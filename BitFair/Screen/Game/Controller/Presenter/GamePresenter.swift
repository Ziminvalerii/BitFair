//
//  GamePresenter.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import SpriteKit
import UIKit

protocol GameViewProtocol:AnyObject {
    func setChilds(childs: [UIView])
    
}

protocol GamePresenterProtocol:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    init(view:GameViewProtocol, router: RouterProtocol, adManager: AdsManager)
    var adManager: AdsManager {get set}
    var settingsModel: SettingsModel.AllCases {get set}
}

class GamePresenter: NSObject, GamePresenterProtocol{
    weak var view: GameViewProtocol?
    var router: RouterProtocol
    var adManager: AdsManager
    var settingsModel: SettingsModel.AllCases = SettingsModel.allCases
    private lazy var overlay: UIView = {
        let overlay = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return overlay
    }()
    
    required init(view: GameViewProtocol, router: RouterProtocol, adManager: AdsManager) {
        self.view = view
        self.router = router
        self.adManager = adManager
    }
}

extension GamePresenter {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settings cell", for: indexPath) as! SettingsCollectionViewCell
        cell.configure(model: settingsModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SettingsCollectionViewCell
        settingsModel[indexPath.row].setValue()
        cell.updateValue(model: settingsModel[indexPath.row])
    }
    
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 98)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = CGFloat(128 * settingsModel.count)
        let totalSpacingWidth = (collectionView.frame.size.width - CGFloat(128 * settingsModel.count))/CGFloat(128 * settingsModel.count - 1)
        let leftInset = (collectionView.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
