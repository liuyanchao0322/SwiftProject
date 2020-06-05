//
//  HQAdBannerView.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

protocol HQAdBannerViewDelegate : NSObjectProtocol {
    func didSelectNoti(notiModel:HQNotiBannerModel)
}

class HQAdBannerView: UIView,UICollectionViewDelegate, UICollectionViewDataSource {

    var CLMaxSections = 100
    let ID = "adcell"
    var timer = Timer()
    var scrollSecond = 2.0
    
    var delegate: HQAdBannerViewDelegate?
    
    private lazy var dataArray : NSMutableArray = {
        let listArray = NSMutableArray.init()
        return listArray
    }()
    
    lazy var leftImagView :UIImageView = {
        let leftView = UIImageView()
        leftView.image = UIImage.init(named: "notiIcon")
        leftView.frame = CGRect.init(x: 15, y: 17, width: 15, height: 15)
        return leftView
    } ()
    
    
    lazy var adListView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame:CGRect(x: 30, y: 0, width: self.width, height: self.height), collectionViewLayout:layout)
        
        layout.itemSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(HQAdCell.self, forCellWithReuseIdentifier: ID)
        // 默认显示最中间的那组
        collectionView.scrollToItem(at: IndexPath.init(row: 0, section: CLMaxSections/2), at: UICollectionViewScrollPosition.top, animated: false)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func loadDataArray(notiDataArray:NSMutableArray)  {
        self.dataArray = notiDataArray
        self.addSubview(self.adListView)
        self.addSubview(self.leftImagView)
        self.starTimer()
        self.adListView.reloadData()
    }
    
    // MARK:- 开启定时器
    func starTimer(){
        timer = Timer.scheduledTimer(timeInterval: scrollSecond, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    // MARK:- 关闭定时器
    func stopTimer(){
        timer.invalidate()
    }

    @objc func nextPage(){
        // 1.马上显示回最中间那组的数据
        let currentIndexPathReset:IndexPath = self.resetIndexPath()
        // 2.计算出下一个需要展示的位置
        var nextItem:Int = currentIndexPathReset.item + 1
        var nextSection:Int = currentIndexPathReset.section
        
        if nextItem == self.dataArray.count {
            nextItem = 0
            nextSection += 1
        }
        
        let nextIndexPath = IndexPath.init(item: nextItem, section: nextSection)
        //3.通过动画滚动到下一个位置
        self.adListView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
    }
    
    func resetIndexPath() -> IndexPath{
        let itemArr = self.adListView.indexPathsForVisibleItems as NSArray
        // 当前正在展示的位置
        let currentIndexPath = itemArr.lastObject
        
        if currentIndexPath == nil {
            return IndexPath.init(item: 0, section: CLMaxSections/2)
        }
        
        // 马上显示回最中间那组的数据
        let currentIndexPathReset:IndexPath = IndexPath.init(item: ((currentIndexPath! as AnyObject).item), section: CLMaxSections/2)
        self.adListView .scrollToItem(at: currentIndexPathReset, at: UICollectionViewScrollPosition.top, animated: false)
        return currentIndexPathReset
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CLMaxSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! HQAdCell
        cell.model = self.dataArray[indexPath.item] as! HQNotiBannerModel
        cell.cellLableClickClosure = {
            
            (notiModel:HQNotiBannerModel) ->()
            in
            self.delegate?.didSelectNoti(notiModel: notiModel)
        }
        return cell
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension HQAdBannerView : UICollectionViewDelegate, UICollectionViewDataSource
//{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return CLMaxSections
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.dataArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! HQAdCell
//        return cell
//    }
//
//
//}
