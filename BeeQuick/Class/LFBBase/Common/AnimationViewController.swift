//
//  AnimationViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/14.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class AnimationViewController: BaseViewController,CAAnimationDelegate {

    var animationLayers: [CALayer]?
    
    var animationBigLayers: [CALayer]?
    
    // MARK: 商品添加到购物车动画
    func addProductsAnimation(imageView: UIImageView) {
        if (self.animationLayers == nil)
        {
            self.animationLayers = [CALayer]();
        }
        
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        self.view.layer.addSublayer(transitionLayer)
        self.animationLayers?.append(transitionLayer)
        
        let p1 = transitionLayer.position;
        let p3 = CGPoint(x:view.width - view.width / 4 - view.width / 8 - 6, y:self.view.layer.bounds.size.height - 40);
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath();
        path.move(to: p1)
        path.addCurve(to: CGPoint.init(x: p3.x, y: p3.y), control1: CGPoint.init(x: p1.x, y: p1.y - 30), control2: CGPoint.init(x: p3.x, y: p1.y - 30))
        positionAnimation.path = path
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = true
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.8
        groupAnimation.delegate = self
        
        transitionLayer.add(groupAnimation, forKey: "cartParabola")
    }
    
    
    // MARK: - 添加商品到右下角购物车动画
    func addProductsToBigShopCarAnimation(imageView: UIImageView) {
        if animationBigLayers == nil {
            animationBigLayers = [CALayer]()
        }
        
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        self.view.layer.addSublayer(transitionLayer)
        self.animationBigLayers?.append(transitionLayer)
        
        let p1 = transitionLayer.position;
        let p3 = CGPoint(x:view.width - 40, y:self.view.layer.bounds.size.height - 40);
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath();
        path.move(to: p1)
        path.addCurve(to: p3, control1: CGPoint(x:p1.x, y:p1.y - 30), control2: CGPoint(x: p3.x, y:p1.y - 30))
        positionAnimation.path = path;
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = true
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.8
        groupAnimation.delegate = self;
        
        transitionLayer.add(groupAnimation, forKey: "BigShopCarAnimation")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.animationLayers?.count != 0 {
            let transitionLayer = animationLayers![0]
            transitionLayer.isHidden = true
            transitionLayer.removeFromSuperlayer()
            animationLayers?.removeFirst()
            view.layer.removeAnimation(forKey: "cartParabola")
        }
        
        if self.animationBigLayers?.count != 0 {
            let transitionLayer = animationBigLayers![0]
            transitionLayer.isHidden = true
            transitionLayer.removeFromSuperlayer()
            animationBigLayers?.removeFirst()
            view.layer.removeAnimation(forKey: "BigShopCarAnimation")
        }
    }
    
}
