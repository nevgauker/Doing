//
//  TutorialViewController.swift
//  Doing
//
//  Created by rotem nevgauker on 2/17/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit

class TutorialViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {

    
    
   
    
    var vcs:[UIViewController] = [UIViewController]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
        
        let pageOneViewController = PageOneViewController(nibName: "PageOneViewController", bundle: nil)
        let pageTwoViewController = PageTwoViewController(nibName: "PageTwoViewController", bundle: nil)
        vcs.append(pageOneViewController)
        vcs.append(pageTwoViewController)
        dataSource = self
        if let firstViewController = vcs.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func viewControllerForIndex(index :Int)-> UIViewController? {
       
        if  index >= 0  && index < 2  {
            return vcs[index]
        }
        return nil
        
    }
    
    //MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard var viewControllerIndex = vcs.index(of: viewController) else {
            return nil
        }
        viewControllerIndex -= 1
        return viewControllerForIndex(index: viewControllerIndex)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var viewControllerIndex = vcs.index(of: viewController) else {
            return nil
        }
        viewControllerIndex += 1
        return viewControllerForIndex(index: viewControllerIndex)

        
        
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl()
        return self.vcs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
    }
   
    
    //MARK: UIPageViewControllerDelegate

}
