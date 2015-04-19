//
//  ViewController.swift
//  CustomScrollView
//
//  Created by 朱 文杰 on 15/4/19.
//  Copyright (c) 2015年 Venj Chu. All rights reserved.
//

import UIKit

let middleViewHeight : CGFloat = 44.0

class ViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var middleView: UIView!
    var secondView: UIView!
    var lastContentOffSetY : CGFloat!
    var direction : String!
    var shouldUpdateInset: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView = UIScrollView(frame: view.frame)
        scrollView.indicatorStyle = .Black
        scrollView.delegate = self
        view.addSubview(scrollView)
        shouldUpdateInset = false
        
        let scrollViewFrame = scrollView.frame
        let scrollViewSize = scrollViewFrame.size
        // 让ScrollView的contentsize
        let contentSize = CGSizeMake(scrollViewSize.width, scrollViewSize.height + 1.0);
        scrollView.contentSize = contentSize
        // 加入3个view，显示scrollview的情况
        let firstView = UIView(frame: CGRectMake(0.0, 0.0, scrollViewSize.width, scrollViewSize.height))
        middleView = UIView(frame: CGRectMake(0.0, scrollViewSize.height, scrollViewSize.width, middleViewHeight))
        firstView.backgroundColor = UIColor.magentaColor()
        middleView.backgroundColor = UIColor.cyanColor()
        secondView = UIView(frame: CGRectMake(0.0, scrollViewSize.height + middleViewHeight + 1.0, scrollViewSize.width, scrollViewSize.height))
        secondView.backgroundColor = UIColor.redColor()
        
        scrollView.addSubview(firstView)
        scrollView.addSubview(middleView)
        scrollView.addSubview(secondView)

        lastContentOffSetY = 0.0
    }
    
    // 滚动方向
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y > lastContentOffSetY {
            direction = "down"
        }
        else {
            direction = "up"
        }
        
        if direction == "down" && !scrollView.decelerating {
            middleView.backgroundColor = UIColor.blueColor()
        }
        if direction == "up" && !scrollView.decelerating {
            middleView.backgroundColor = UIColor.brownColor()
        }
        
        lastContentOffSetY = scrollView.contentOffset.y;
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        println("\(scrollView.contentOffset.y)")
        if direction == "down" && scrollView.contentOffset.y >= middleViewHeight {
            self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2.0 + middleViewHeight + 2.0)
            self.shouldUpdateInset = true
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.scrollView.setContentOffset(CGPointMake(0.0, self.view.frame.size.height + middleViewHeight + 1.0), animated: true)
            })
        }
        if direction == "up" && scrollView.contentOffset.y > 0.0 && scrollView.contentOffset.y <= self.view.frame.size.height {
            self.shouldUpdateInset = true
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.scrollView.setContentOffset(CGPointMake(0.0, 0.0), animated: true)
            })
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if (self.shouldUpdateInset != nil) {
            self.shouldUpdateInset = false
            if direction == "down" {
                if scrollView.contentOffset.y < 0.0 {
                    return
                }
                self.scrollView.contentInset = UIEdgeInsetsMake(-(self.view.frame.size.height + middleViewHeight + 1.0), 0.0, 0.0, 0.0)
            }
            else {
                if scrollView.contentOffset.y > self.view.frame.size.height + middleViewHeight {
                    return
                }
                self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 1.0)
                self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

