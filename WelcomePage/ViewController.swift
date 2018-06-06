//
//  ViewController.swift
//  WelcomePage
//
//  Created by sandra on 2018/5/29.
//  Copyright © 2018年 sandra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    private var pageViewController: UIViewController?
    private var pageController: UIPageViewController?
    private var pageItemIndex: Int?
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonSkip: UIButton!
    
    /* press skip button function */
    @IBAction func skipToLast(_ sender: Any) {
        if pageItemIndex! + 1 < contentImages.count {
            pageItemIndex = contentImages.count - 1
            /* the last welcome image, show scan button */
            showScanButton()
            let lastController = getItemController(itemIndex: pageItemIndex!)!
            let lastViewControllers = [lastController]
            pageController?.setViewControllers(lastViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
    }

    /* press next/scan button function */
    @IBAction func gotoNextImage(_ sender: Any) {
        if pageItemIndex! + 1 < contentImages.count {
            pageItemIndex = pageItemIndex! + 1
            /* the last welcome image, show scan button */
            if pageItemIndex! + 1 == contentImages.count {
                showScanButton()
            }
            let nextController = getItemController(itemIndex: pageItemIndex!)!
            let nextViewControllers = [nextController]
            self.pageController?.setViewControllers(nextViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
    }
    
    private let contentImages = ["intro_slide_1",
                                 "intro_slide_2",
                                 "intro_slide_3",
                                 "intro_slide_4",
                                 "intro_slide_5",
                                 "intro_slide_6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createPageViewController()
        setupPageControl()
        self.view.bringSubview(toFront: buttonNext)
        self.view.bringSubview(toFront: buttonSkip)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createPageViewController() {
        // PageItemController.swift
        pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageController") as? UIPageViewController
        pageController?.dataSource = self
        
        /* show the first welcome image */
        if contentImages.count > 0 {
            let firstController = getItemController(itemIndex: 0)!
            let startingViewControllers = [firstController]
            pageController?.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
            pageItemIndex = 0
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
    }
    
    private func setupPageControl() {
        let appearence = UIPageControl.appearance()
        appearence.pageIndicatorTintColor = UIColor.gray
        appearence.currentPageIndicatorTintColor = UIColor.white
        appearence.backgroundColor = UIColor.black
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if pageItemIndex! > 0 {
            /* restore next button */
            if pageItemIndex! + 1 == contentImages.count {
                showNextButton()
            }
            pageItemIndex = pageItemIndex! - 1
            return getItemController(itemIndex: pageItemIndex!)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if pageItemIndex! + 1 < contentImages.count {
            pageItemIndex = pageItemIndex! + 1
            /* the last welcome image, show scan button */
            if pageItemIndex! + 1 == contentImages.count {
                showScanButton()
            }
            return getItemController(itemIndex: pageItemIndex!)
        }
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            return pageItemController
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let returnIndex = pageItemIndex {
            return returnIndex
        }
        else {
            return 0
        }
    }
    
    private func showScanButton() {
        buttonNext.setTitle("Scan", for: .normal)
    }
    
    private func showNextButton() {
        buttonNext.setTitle("Next", for: .normal)
    }
}

