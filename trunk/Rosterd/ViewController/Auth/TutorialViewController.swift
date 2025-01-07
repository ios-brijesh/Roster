//
//  TutorialViewController.swift
//  Momentor
//
//  Created by wmdevios-h on 11/08/21.
//

import UIKit


class TutorialViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var cvSlider: UICollectionView!
    @IBOutlet weak var btnSkip: UIButton!
   
    @IBOutlet weak var vwPageControl: UIView!
    // MARK: - Variables
    private var arrTutorial : [TutorialImages] = [.tutorial1,.tutorial2,.tutorial3]
    private var currentIndex : Int = 0
    let pageControl = SCPageControlView()
    
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

// MARK: - UI helpers
fileprivate extension TutorialViewController {
    //MARK: Private Methods
    private func InitConfig() {
      
        
        self.cvSlider.register(TutorialCell.self)
        self.cvSlider.dataSource = self
        self.cvSlider.delegate = self
        
        self.btnSkip.setTitleColor(UIColor.CustomColor.subHeaderTextColor, for: .normal)
        self.btnSkip.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
       
        pageControl.frame = CGRect(x: 0, y: 0, width: vwPageControl.frame.width, height: vwPageControl.frame.height)
        pageControl.scp_style = .SCNormal
        pageControl.set_view(arrTutorial.count, current: 0, current_color: UIColor.CustomColor.appColor)
        vwPageControl.addSubview(pageControl)
        
    }
}

//MARK: -  Scrollview Method
extension TutorialViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentOfPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.scroll_did(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //self.collectionview.scrollToNearestVisibleCollectionViewCell()
        //self.pageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print("scrollViewDidEndDecelerating : \(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))")
        self.currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.btnSkip.isHidden = self.currentIndex >= 2
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //self.pageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print("scrollViewDidEndScrollingAnimation : \(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))")
        self.btnSkip.isHidden = self.currentIndex >= 2
    }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension TutorialViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrTutorial.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TutorialCell.self)
        if self.arrTutorial.count > 0 {
            cell.setupData(obj: self.arrTutorial[indexPath.row])
         
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
    @objc func btnNextAction(sender : UIButton) {
        self.btnSkip.isHidden = self.currentIndex >= 2
        if self.currentIndex == self.arrTutorial.count - 1 {
            //self.appNavigationController?.showDashBoardViewController()
        } else {
            self.cvSlider.scrollToNextItem()
        }
    }
    
}

//MARK: - IBAction Mthonthd
extension TutorialViewController {
    @IBAction func btnSkipClicked(_ sender: UIButton) {
        self.appNavigationController?.push(StartedViewController.self)
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        self.btnSkip.isHidden = self.currentIndex >= 2
        if self.currentIndex == self.arrTutorial.count - 1 {
            self.appNavigationController?.push(StartedViewController.self)
        } else {
            self.cvSlider.scrollToNextItem()
        }
    }
}

// MARK: - ViewControllerDescribable
extension TutorialViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension TutorialViewController: AppNavigationControllerInteractable { }

