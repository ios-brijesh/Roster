//
//  ContentViewController.swift
//  ARStories
//
//  Created by Antony Raphel on 05/10/17.
//



import UIKit


var ContentViewControllerVC = ContentViewController()



class ContentViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageViewController : UIPageViewController?
    var pages: [StoryModel] = []
    var currentIndex : Int = 0
    var storyType :StoryType = .DefaultStory
    var onReloadStory:(() -> ())?
    var onShareStoryDismiss:(() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ContentViewControllerVC = self
        pageViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        
        if let startingViewController: PreViewController = viewControllerAtIndex(index: currentIndex) {
            let viewControllers = [startingViewController]
            pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
            pageViewController!.view.frame = view.bounds
            
            addChild(pageViewController!)
            view.addSubview(pageViewController!.view)
            view.sendSubviewToBack(pageViewController!.view)
            pageViewController!.didMove(toParent: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - UIPageViewControllerDataSource
    //1
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! PreViewController).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index: index)
    }
    
    //2
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PreViewController).pageIndex
        if index == NSNotFound {
            return nil
        }
        index += 1
        if (index == pages.count) {
            return nil
        }
        return viewControllerAtIndex(index: index)
    }
    
    //3
    func viewControllerAtIndex(index: Int) -> PreViewController? {
        if pages.count == 0 || index >= pages.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let vc = storyboard?.instantiateViewController(withIdentifier: "PreView") as! PreViewController
        vc.pageIndex = index
        vc.items = pages
        vc.storyType = self.storyType
        currentIndex = index
        
        vc.view.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        return vc
    }
    
    // Navigate to next page
    func goNextPage(fowardTo position: Int) {
        let startingViewController: PreViewController = viewControllerAtIndex(index: position)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: true, completion: nil)
    }
    
    // MARK: - Button Actions
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
