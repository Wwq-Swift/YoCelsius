//
//  SunsetView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class SunsetView: UIView {

    lazy private var upView: UIView = UIView()
    lazy private var downView: UIView = UIView()
    var sunImageView: UIImageView = UIImageView()
    var sunImageViewStoreValue: CGRectStoreValue = CGRectStoreValue()
    var moonImageView: UIImageView = UIImageView()
    var moonImageViewStoreValue: CGRectStoreValue = CGRectStoreValue()
    lazy private var lineView: UIView = UIView()
    
    func buildView() {
        let sunwidth  = self.frame.width
        let sunheight = self.frame.height / 2.0
        let upCenterRect   = CGRect(x: 0, y: 0, width: sunwidth, height: sunheight)
        let downCenterRect = CGRect(x: 0, y: sunheight, width: sunwidth, height: sunheight)
        
        upView.frame = upCenterRect
        upView.layer.masksToBounds = true
        self.addSubview(self.upView)
        
        downView.frame = downCenterRect
        downView.layer.masksToBounds = true
        self.addSubview(downView)
        
        // 创建出太阳的view并存储一些相关参数
        sunImageView.frame = self.upView.frame
        sunImageView.image = #imageLiteral(resourceName: "sun")
        self.upView.addSubview(self.sunImageView)
        sunImageView.alpha     = 0.0
        sunImageViewStoreValue.startRect = self.sunImageView.frame
        sunImageView.frame.origin.y += self.sunImageView.frame.height
        sunImageViewStoreValue.midRect  = self.sunImageView.frame
        sunImageView.frame.origin.y += 10.0
        sunImageViewStoreValue.endRect   = self.sunImageView.frame
        sunImageView.frame = self.sunImageViewStoreValue.startRect
        
        // 创建出月亮的view并存储一些相关参数
        moonImageView.frame = self.upView.bounds
        moonImageView.image = #imageLiteral(resourceName: "moon")
        moonImageView.frame.origin.y -= moonImageView.frame.height
        self.downView.addSubview(self.moonImageView)
        moonImageViewStoreValue.startRect = self.moonImageView.frame
        moonImageView.frame.origin.y += self.moonImageView.frame.height
        moonImageViewStoreValue.midRect   = self.moonImageView.frame
        moonImageView.frame.origin.y += 10.0
        moonImageViewStoreValue.endRect   = self.moonImageView.frame
        moonImageView.frame = self.moonImageViewStoreValue.startRect
        moonImageView.alpha = 0.0
        
        // 中间的线条
        lineView.frame  = CGRect(x: 0, y: self.frame.height / 2.0, width: self.frame.width, height: 1)
        lineView.alpha = 0.0
        lineView.backgroundColor = UIColor(hexString: "C2C2C2")
        self.addSubview(self.lineView)
        
    }
    
    func showWithDuration(duration: TimeInterval) {
        
        UIView.animate(withDuration: duration) {
            self.sunImageView.frame = self.sunImageViewStoreValue.midRect
            self.sunImageView.alpha = 1.0
            
            self.moonImageView.frame = self.moonImageViewStoreValue.midRect
            self.moonImageView.alpha = 1.0
            
            self.lineView.alpha = 1.0
        }
    }
    
    func hideWithDuration(duration: TimeInterval) {
        
        UIView.animate(withDuration: duration, animations: {
            self.sunImageView.frame = self.sunImageViewStoreValue.endRect
            self.sunImageView.alpha = 0.0
            
            self.moonImageView.frame        = self.moonImageViewStoreValue.endRect
            self.moonImageView.alpha        = 0.0
            self.downView.layer.masksToBounds = false
            
            self.lineView.alpha = 0.0
            
        }) { (_) in
            self.sunImageView.frame  = self.sunImageViewStoreValue.startRect
            self.moonImageView.frame = self.moonImageViewStoreValue.startRect
            self.upView.layer.masksToBounds = true
        }
    }

}
