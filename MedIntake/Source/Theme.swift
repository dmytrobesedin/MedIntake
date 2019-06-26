//
//  Theme.swift
//  EmployeeTest
//
//  Created by Дмитрий Беседин on 15.05.2018.
//  Copyright © 2018 dmytrobesedin. All rights reserved.
//

import UIKit

func applyTheme() {
    let sharedApplication = UIApplication.shared
    sharedApplication.delegate?.window??.tintColor = mainColor
    sharedApplication.statusBarStyle = UIStatusBarStyle.lightContent
    
    styleForTabBar()
    styleForNavigationBar()
    styleForTableView()
}

func styleForTabBar() {
    UITabBar.appearance().barTintColor = barTintColor
    UITabBar.appearance().tintColor = UIColor.white
    
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for:.selected)
    
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for:.normal)
}


func styleForNavigationBar() {
    UINavigationBar.appearance().barTintColor = barTintColor
    UINavigationBar.appearance().tintColor = UIColor.white
  //  UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey: standardTextFont,  NSAttributedStringKey.foregroundColor: UIColor.white]
}

func styleForTableView() {
    UITableView.appearance().backgroundColor = backgroundColor
    UITableView.appearance().separatorStyle = .singleLine
}


var mainColor: UIColor {
    return UIColor(red: 103.0/255.0, green: 112.0/255.0, blue: 117.0/255.0, alpha: 1.0)
}

var barTintColor: UIColor {
    return UIColor(red: 103.0/255.0, green: 112.0/255.0, blue: 117.0/255.0, alpha: 1.0)
}

var barTextColor: UIColor {
    return UIColor(red: 254.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
}

var backgroundColor: UIColor {
    return UIColor(red: 182.0/255.0, green: 208.0/255.0, blue: 218.0/255.0, alpha: 1.0)
}

var textColor: UIColor {
    return UIColor(red: 50.0/255.0, green: 195.0/255.0, blue: 52.0/255.0, alpha: 1.0)
}

var headingTextColor: UIColor {
    return UIColor(red: 99.0/255.0, green: 28.0/255.0, blue: 78.0/255.0, alpha: 1.0)
}

var subtitleTextColor: UIColor {
    return UIColor(red: 139.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 1.0)
}

var standardTextFont: UIFont {
    return UIFont(name: "AvenirNext-Medium", size: 15)!
}
var registerTextFont: UIFont {
    return UIFont(name: "AvenirNext-Medium", size: 30)!
}

var headlineFont: UIFont {
    return UIFont(name: "AvenirNext-Bold", size: 15)!
}

var subtitleFont: UIFont {
    return UIFont(name: "AvenirNext-DemiBold", size: 15)!
}
