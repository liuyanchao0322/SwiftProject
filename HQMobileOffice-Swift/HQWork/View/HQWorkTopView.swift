//
//  HQWorkTopView.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import LLCycleScrollView

class HQWorkTopView: UIView,HQAdBannerViewDelegate {
    
    func didSelectNoti(notiModel: HQNotiBannerModel) {
        didSelectNotiBlock!(notiModel)
    }
    
    
    var didSelectNotiBlock:((_ notiModel:HQNotiBannerModel) ->())?
    
    lazy var bannerView : LLCycleScrollView = {
        
        let bannerFrame = CGRect.init(x: 10, y: 10, width: kScreenWidth - 20, height: 160)
        
        let topView = LLCycleScrollView.llCycleScrollViewWithFrame(bannerFrame, imageURLPaths: nil, titles: nil, didSelectItemAtIndex: { (itemIndex) in
            self.textShow(text: "njkenvfdj", view: self, after: 0.25)
        })
        // 是否自动滚动
        topView.autoScroll = true
        
        // 是否无限循环，此属性修改了就不存在轮播的意义了 😄
        topView.infiniteLoop = true
        
        // 滚动间隔时间(默认为2秒)
        topView.autoScrollTimeInterval = 3.0
        
        // 等待数据状态显示的占位图
        topView.placeHolderImage = UIImage.init(named: "banner")
        
        // 如果没有数据的时候，使用的封面图
        topView.coverImage = UIImage.init(named: "banner")
        
        // 设置图片显示方式=UIImageView的ContentMode
        topView.imageViewContentMode = .scaleToFill
        
        // 设置滚动方向（ vertical || horizontal ）
        topView.scrollDirection = .horizontal
        
        // 设置当前PageControl的样式 (.none, .system, .fill, .pill, .snake)
        topView.customPageControlStyle = .snake
        
        // 非.system的状态下，设置PageControl的tintColor
        topView.customPageControlInActiveTintColor = UIColor.red
        
        // 设置.system系统的UIPageControl当前显示的颜色
        topView.pageControlCurrentPageColor = UIColor.white
        
        // 非.system的状态下，设置PageControl的间距(默认为8.0)
        topView.customPageControlIndicatorPadding = 8.0
        
        // 设置PageControl的位置 (.left, .right 默认为.center)
        topView.pageControlPosition = .center
        topView.imagePaths = ["https://www.baidu.com/img/bd_logo1.png?qua=high&where=super","banner"]

        return topView
    }()
    
    lazy var adBannerView : HQAdBannerView = {
        let bannerView = HQAdBannerView()
        bannerView.delegate = self
        return bannerView
    }()
    
    lazy var topLineView :UIView = {
        
        let topView = UIView()
        topView.backgroundColor = kLineColor
        return topView
    }()
    
    lazy var nextLineView :UIView = {
        
        let lineView = UIView()
        lineView.backgroundColor = kLineColor
        return lineView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.bannerView)
        self.addSubview(self.adBannerView)
        self.addSubview(self.topLineView)
        self.addSubview(self.nextLineView)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.topLineView.frame = CGRect.init(x: 15, y: self.bannerView.bottom, width: kScreenWidth - 30, height: 0.5)
        self.adBannerView.frame = CGRect.init(x: 0, y: self.bannerView.bottom, width: kScreenWidth, height: 50)
        self.nextLineView.frame = CGRect.init(x: 15, y: self.adBannerView.bottom, width: kScreenWidth - 30, height: 0.5)
    }
    
    
    
    func loadNotiData(notiArray:NSMutableArray)  {
        self.adBannerView.loadDataArray(notiDataArray: notiArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
