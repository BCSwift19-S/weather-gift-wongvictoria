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
    var pageControl: UIPageControl!
    var listButton: UIButton!
    var barButtonWidth: CGFloat = 44
    var barButtonHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setViewControllers([createDetailedVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureListButton()
        configurePageControl()
        
    }
    //MARK UIConfiguration Methods
    func configurePageControl() {
        let pageControlHeight: CGFloat = barButtonHeight
        let pageControlWidth: CGFloat = view.frame.width - (barButtonWidth * 2)
        
    
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
 
        pageControl = UIPageControl(frame: CGRect(x: (view.frame.width - pageControlWidth) / 2, y: safeHeight - pageControlHeight, width: pageControlWidth, height: pageControlHeight))
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.numberOfPages = locationsArray.count
        pageControl.currentPage = currentPage
        pageControl.addTarget(self, action: #selector(pageControlPressed), for: .touchUpInside)
        view.addSubview(pageControl)
    }
    
    func configureListButton() {
        let barButtonHeight = barButtonWidth
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
        
        listButton = UIButton(frame: CGRect(x: view.frame.width - barButtonWidth, y: safeHeight - barButtonHeight, width: barButtonWidth, height: barButtonHeight))
        listButton.setBackgroundImage(UIImage(named: "listbutton"), for: .normal)
        listButton.setBackgroundImage(UIImage(named: "listbutton-highlighted"), for: .highlighted)
        listButton.addTarget(self, action: #selector(segueToListVC), for: .touchUpInside)
        
        view.addSubview(listButton)
        
    }
    
    //MARK: Segues
    
    @objc func segueToListVC() {
        performSegue(withIdentifier: "ToListVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToListVC" {
            let destination = segue.destination as! ListVC
            destination.locationsArray = locationsArray
            destination.currentPage = currentPage
        }
    }
    @IBAction func unwindFromListVC(sender: UIStoryboardSegue) {
        pageControl.numberOfPages = locationsArray.count
        pageControl.currentPage = currentPage
        setViewControllers([createDetailedVC(forPage: currentPage)], direction: .forward, animated: false, completion: nil)
    }
    
    //MARK: create View Controller for UIPageViewController
    
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

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?[0] as? DetailedVC {
            pageControl.currentPage = currentViewController.currentPage
        }
    }
    
    @objc func pageControlPressed() {
        guard let currentViewController = self.viewControllers?[0] as? DetailedVC else
            {return}
        currentPage = currentViewController.currentPage
        if pageControl.currentPage < currentPage {
            setViewControllers([createDetailedVC(forPage: pageControl.currentPage)], direction: .reverse, animated: true, completion: nil)
        } else if pageControl.currentPage > currentPage {
            setViewControllers([createDetailedVC(forPage: pageControl.currentPage)], direction: .forward, animated: true, completion: nil)
        }
    }
}

