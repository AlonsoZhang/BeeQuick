//  AnimationTabBarController.swift
//
// Copyright (c) 11/10/14 Ramotion Inc. (http://ramotion.com)

import UIKit

class RAMAnimatedTabBarItem: UITabBarItem {

    var animation: RAMItemAnimation?
    
    var textColor = UIColor.gray

    func playAnimation(icon: UIImageView, textLabel: UILabel){
        guard let animation = animation else {
            print("add animation in UITabBarItem")
            return
        }
        animation.playAnimation(icon, textLabel: textLabel)
    }

    func deselectAnimation(icon: UIImageView, textLabel: UILabel) {
        animation?.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor, defaultIconColor: textColor)
    }

    func selectedState(icon: UIImageView, textLabel: UILabel) {
        animation?.selectedState(icon, textLabel: textLabel)
    }
}

class RAMAnimatedTabBarController: UITabBarController {
    
    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = []
    var iconsImageName:[String] = ["v2_home", "v2_order", "freshReservation", "shopCart", "v2_my"]
    var iconsSelectedImageName:[String] = ["v2_home_r", "v2_order_r", "freshReservation_r", "shopCart", "v2_my_r"]
// MARK: create methods

    func createCustomIcons(containers : [String: UIView]) {
        if let items = tabBar.items as? [RAMAnimatedTabBarItem] {
            
            let itemsCount = items.count as Int - 1
            
            for (index, item) in items.enumerated() {

                assert(item.image != nil, "add image icon in UITabBarItem")
                
                guard let container = containers["container\(itemsCount-index)"] else
                {
                    print("No container given")
                    continue
                }
                
                container.tag = index

                let imageW:CGFloat = 21
                let imageX:CGFloat = (ScreenWidth / CGFloat(items.count) - imageW) * 0.5
                let imageY:CGFloat = 8
                let imageH:CGFloat = 21
                let icon = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageW, height: imageH))
//                let icon = UIImageView(image: item.image)
                icon.image = item.image
//                icon.translatesAutoresizingMaskIntoConstraints = false
                icon.tintColor = UIColor.clear
                
                if 3 == index {
                    let redDotView = ShopCarRedDotView.sharedRedDotView
                    redDotView.frame = CGRect(x:imageH + 2, y:1, width:15, height:15)
                    icon.addSubview(redDotView)
                }

                // text
                let textLabel = UILabel()
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clear
                textLabel.textColor = item.textColor
                textLabel.font = UIFont.systemFont(ofSize: 10)
                textLabel.textAlignment = NSTextAlignment.center
                textLabel.translatesAutoresizingMaskIntoConstraints = false

                container.addSubview(icon)
                
//                if let itemImage = item.image {
//                    createConstraints(icon, container: container, size: itemImage.size, yOffset: -5)
//                }

                container.addSubview(textLabel)
                
                if let tabBarItem = tabBar.items {
                    let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBarItem.count) - 5.0
                    createConstraints(view: textLabel, container: container, size: CGSize(width: textLabelWidth , height: 10), yOffset: 16)
                }

                let iconsAndLabels = (icon:icon, textLabel:textLabel)
                iconsView.append(iconsAndLabels)

                if 0 == index { // selected first elemet
                    icon.image = UIImage(named: "v2_home_r")
                    item.selectedState(icon: icon, textLabel: textLabel)
                }

                item.image = nil
                item.title = ""
            }
        }
    }

    func createConstraints(view: UIView, container: UIView, size: CGSize, yOffset: CGFloat) {

        let constX = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: container,
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 0)
        container.addConstraint(constX)

        let constY = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.centerY,
            relatedBy: NSLayoutRelation.equal,
            toItem: container,
            attribute: NSLayoutAttribute.centerY,
            multiplier: 1,
            constant: yOffset)
        container.addConstraint(constY)

        let constW = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: size.width)
        view.addConstraint(constW)

        let constH = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: size.height)
        view.addConstraint(constH)
    }

    func createViewContainers() -> [String: UIView] {
        var containersDict = [String: UIView]()
    
        guard let customItems = tabBar.items else
        {
            return containersDict
        }

        for index in 0..<customItems.count {
            let viewContainer = createViewContainer()
            containersDict["container\(index)"] = viewContainer
        }

        var formatString = "H:|-(0)-[container0]"
        for index in 1..<customItems.count {
            formatString += "-(0)-[container\(index)(==container0)]"
        }
        formatString += "-(0)-|"
        let constranints = NSLayoutConstraint.constraints(withVisualFormat: formatString,
                                                                    options:NSLayoutFormatOptions.directionRightToLeft,
                                                                    metrics: nil,
                                                                      views: containersDict)
        view.addConstraints(constranints)
        
        return containersDict
    }

    func createViewContainer() -> UIView {
        let viewContainer = UIView()
        viewContainer.backgroundColor = UIColor.clear // for test
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewContainer)

        // add gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector(("tapHandler:")))
        tapGesture.numberOfTouchesRequired = 1
        viewContainer.addGestureRecognizer(tapGesture)

        // add constrains
        let constY = NSLayoutConstraint(item: viewContainer,
                                   attribute: NSLayoutAttribute.bottom,
                                   relatedBy: NSLayoutRelation.equal,
                                      toItem: view,
                                   attribute: NSLayoutAttribute.bottom,
                                  multiplier: 1,
                                    constant: 0)

        view.addConstraint(constY)

        let constH = NSLayoutConstraint(item: viewContainer,
                                   attribute: NSLayoutAttribute.height,
                                   relatedBy: NSLayoutRelation.equal,
                                      toItem: nil,
                                   attribute: NSLayoutAttribute.notAnAttribute,
                                  multiplier: 1,
                                    constant: tabBar.frame.size.height)
        viewContainer.addConstraint(constH)

        return viewContainer
    }

// MARK: actions

    func tapHandler(gesture:UIGestureRecognizer) {

        let items = tabBar.items as! [RAMAnimatedTabBarItem]

        let currentIndex = gesture.view!.tag
        
        // 点击的购物车按钮
        if currentIndex == 3 {
            let vc = childViewControllers[selectedIndex]
            let shopCar = ShopCartViewController()
            let nav = BaseNavigationController(rootViewController: shopCar)
            vc.present(nav, animated: true, completion: nil)
            
            return
        }
        
        if selectedIndex != currentIndex {
            let animationItem : RAMAnimatedTabBarItem = items[currentIndex]
            let icon = iconsView[currentIndex].icon
            icon.image = items[currentIndex].selectedImage
            let textLabel = iconsView[currentIndex].textLabel
            animationItem.playAnimation(icon: icon, textLabel: textLabel)

            let deselelectIcon = iconsView[selectedIndex].icon
            let deselelectTextLabel = iconsView[selectedIndex].textLabel
            let deselectItem = items[selectedIndex]
            
            deselelectIcon.image = UIImage(named: iconsImageName[selectedIndex])
            deselectItem.deselectAnimation(icon: deselelectIcon, textLabel: deselelectTextLabel)

            selectedIndex = gesture.view!.tag
        }
    }
    
    func setSelectIndex(from: Int,to: Int) {
        selectedIndex = to
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        let fromIV = iconsView[from].icon
        fromIV.image = UIImage(named: iconsImageName[from])
        items[from].deselectAnimation(icon: fromIV, textLabel: iconsView[from].textLabel)
        
        let toIV = iconsView[to].icon
        toIV.image = UIImage(named: iconsSelectedImageName[to])
        items[to].playAnimation(icon: toIV, textLabel: iconsView[to].textLabel)
    }
}


