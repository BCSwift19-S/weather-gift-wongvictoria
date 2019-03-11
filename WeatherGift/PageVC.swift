//
//  PageVC.swift
//  WeatherGift
//
//  Created by Victoria Wong on 3/10/19.
//  Copyright © 2019 Victoria Wong. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    
    var currentPage = 0
    var locationsArray = ["Local City", "Sydney, Australia","Accra, Ghana", "Uglich, Russia"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setViewControllers([createDetailedVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
    }
    
    func createDetailedVC(forPage page: Int) -> DetailedVC {
        
        currentPage = min(max(0, page), locationsArray.count - 1)
        
        let detailedVC = storyboard!.instantiateViewController(withIdentifier: "DetailedVC") as! DetailedVC
        
        detailedVC.locationsArray = locationsArray
        detailedVC.currentPage = currentPage
        
        return detailedVC
    }
}


extension PageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? DetailedVC {
            if currentViewController.currentPage < locationsArray.count - 1 {
                return createDetailedVC(forPage: currentViewController.currentPage + 1)
            }
        }
    
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? DetailedVC {
            if currentViewController.currentPage > 0 {
                return createDetailedVC(forPage: currentViewController.currentPage - 1)
            }
        }
        
        return nil
    }

}
