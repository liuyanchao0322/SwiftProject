//
//  TestKVOView.swift
//  SwiftDemo
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

// MARK: final-->防止被重写或被继承
final class TestKVOView: UIView {

    var p : HQPersonModel?
    lazy var ageLabel :UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 15)
        label.frame = CGRect.init(x: 0, y: 40, width: 100, height: 20)
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.blue
        return label
    } ()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(ageLabel)
        
        let person = HQPersonModel(name: "lyc")
        p = person
        p?.addObserver(self, forKeyPath: "age", options: [.new,.old], context: nil)
        self.ageLabel.text = String(format: "%ld", (p?.age)!)

    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "age" {
            let oldValue = change![NSKeyValueChangeKey.oldKey] as? Int
            let newValue = change![NSKeyValueChangeKey.newKey] as? Int
            print("oldValue = \(String(describing: oldValue)),newValue = \(String(describing: newValue))")
            self.ageLabel.text = String(format: "%ld", (newValue)!)
            print("keyPath = \(String(describing: keyPath))")
            print("object = \(String(describing: object))")
            print("change = \(String(describing: change))")
            print("context = \(String(describing: context))")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
