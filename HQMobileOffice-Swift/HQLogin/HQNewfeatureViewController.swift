//
//  HQNewfeatureViewController.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQNewfeatureViewController: UIViewController,UIScrollViewDelegate {

    let IWNewfeatureImageCount = 4
    var pageControl : UIPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupPageControl()
    }

    func setupScrollView()  {
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds;
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        for index in 0 ..< IWNewfeatureImageCount {
            
            let imageView = UIImageView(frame: CGRect.init(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
            let name = NSString.init(format: "引导页%d", index + 1)
            imageView.image = UIImage.init(named: name as String)
            scrollView.addSubview(imageView)
            
            if index == IWNewfeatureImageCount - 1 {
        
                self.setupLastImageView(imageVIew: imageView)
            }
        }
        // 3.设置滚动的内容尺寸
        scrollView.contentSize = CGSize.init(width: CGFloat(IWNewfeatureImageCount) * kScreenWidth, height: 0)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
    }
    
    func setupLastImageView(imageVIew:UIImageView) {
        // 0.让imageView能跟用户交互
        imageVIew.isUserInteractionEnabled = true
        
        // 1.添加开始按钮
        let startButton = UIButton.init(type: UIButtonType.custom)
        startButton.layer.cornerRadius = 5
        startButton.layer.masksToBounds = true
    
        let btnX = (kScreenWidth - 100) / 2;
        let btnY =  (kScreenHeight - 100)

        startButton.frame = CGRect.init(x: btnX, y: btnY, width: 100, height: 40)
        
        if (kScreenWidth == 320) {
            startButton.top = kScreenWidth - 80;
        }
        // 3.设置文字
        
        startButton.setTitle("立即体验", for: UIControlState.normal)
        startButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        startButton.backgroundColor = kMainColor
        imageVIew.addSubview(startButton)
    }
    
    func setupPageControl()  {
        // 1.添加
        let pageControl = UIPageControl()
        pageControl.numberOfPages = IWNewfeatureImageCount;
        let centerX = self.view.frame.size.width * 0.5;
        let centerY = self.view.frame.size.height - 30;
        pageControl.center = CGPoint.init(x: centerX, y: centerY)
        pageControl.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 30)
        pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
        self.pageControl = pageControl;
        
        // 2.设置圆点的颜色
        pageControl.currentPageIndicatorTintColor = kMainColor
        pageControl.pageIndicatorTintColor = RGBA(r: 189, g: 189, b: 189, a: 1)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.取出水平方向上滚动的距离
        let offsetX = scrollView.contentOffset.x;
        
        // 2.求出页码
        let pageDouble = offsetX / scrollView.frame.size.width;
        let pageInt = Int(pageDouble + 0.5);
        self.pageControl?.currentPage = pageInt
    }
    
    @objc func start()  {

        UIApplication.shared.keyWindow?.rootViewController = HQLoginViewController()
    }
    
}
