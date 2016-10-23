//
//  AnimationViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/14.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class AnimationViewController: BaseViewController {

    var animationLayers: [CALayer]?
    
    // MARK: 商品添加到购物车动画
    func addProductsAnimation(imageView: UIImageView) {
        if animationLayers == nil {
            animationLayers = [CALayer]()
        }
        
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        transitionLayer.fillMode = kCAFillModeRemoved
        
        let p1 = transitionLayer.position
        let p3X = view.width - view.width / 5 - 10
        let p3 = CGPoint(x:p3X, y:ScreenHeight - 20)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath()
        path.move(to: CGPoint(x:p1.x, y:p1.y))
        path.addLine(to: CGPoint(x:p3.x, y:p3.y))
        positionAnimation.isRemovedOnCompletion = true
        positionAnimation.path = path
        positionAnimation.fillMode = kCAFillModeForwards
        
        let transformAnimation =  CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.1, 0.1, 1))
        transformAnimation.fillMode = kCAFillModeForwards
        transformAnimation.isRemovedOnCompletion = true
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.8
        opacityAnimation.toValue = 0.1
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = true
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.5
        //groupAnimation.delegate = self
        
        transitionLayer.add(groupAnimation, forKey: "cartParabola")
        
        view.layer.addSublayer(transitionLayer)
        animationLayers!.append(transitionLayer)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
            transitionLayer.isHidden = true
        }
    }
    
//    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//        if animationLayers!.count > 0 {
//            let transitionLayer = animationLayers![0]
//            transitionLayer.isHidden = true
//            transitionLayer.removeFromSuperlayer()
//            animationLayers?.removeFirst()
//            view.layer.removeAnimation(forKey: "cartParabola")
//        }
//    }
}
