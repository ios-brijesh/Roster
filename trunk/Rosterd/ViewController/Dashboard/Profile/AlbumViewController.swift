//
//  AlbumViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 18/08/22.
//

import UIKit
import Alamofire

class AlbumViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var cvAlbum: UICollectionView?
    
    
    private var arrImages : [ProfileAlbumModel] = []
    private var arrImageupload : [ProfileImageModel] = []
    var userId : String = ""
    var selectedAlbum : ProfileAlbumModel?
    
    var isfromother : Bool = false
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.arrImages.removeAll()
        self.cvAlbum?.reloadData()
        self.getAlbumsAPICall()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
}
// MARK: - Init Configure
extension AlbumViewController {
    private func InitConfig(){
        if let cv = self.cvAlbum {
            cv.register(PofileAlbumCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
    }
    
    private func configureNavigationBar() {
  
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Albums", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
   }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension AlbumViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isfromother {
            return self.arrImages.count
        } else {
            return self.arrImages.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PofileAlbumCell.self)
       
        if indexPath.row == arrImages.count && !self.isfromother {
            cell.vwPlusView?.isHidden = false
            cell.btnAddimg.isHidden = false
            cell.imgFirst?.isHidden = true
            cell.imgSecond?.isHidden = true
            cell.imgThird?.isHidden = true
            cell.imgfourth?.isHidden = true
            cell.vwlabelview?.isHidden = true
            cell.btnDeleteAlbum?.isHidden = true
            
        } else {

            cell.setAlbumData(obj: self.arrImages[indexPath.row])
            cell.vwPlusView?.isHidden = true
            cell.btnAddimg.isHidden = true
            if self.isfromother == true {
                cell.btnDeleteAlbum?.isHidden = true
                
            } else {
                cell.btnDeleteAlbum?.isHidden = false
            }
            let arrMedia = self.arrImages[indexPath.row].media
//
            if arrMedia.count == 0 {
                cell.imgFirst?.isHidden = true
                cell.imgSecond?.isHidden = true
                cell.imgThird?.isHidden = true
                cell.imgfourth?.isHidden = true
                cell.vwlabelview?.isHidden = true
            }
            else if arrMedia.count == 1 {
                cell.imgFirst?.isHidden = false
                cell.imgSecond?.isHidden = true
                cell.imgThird?.isHidden = true
                cell.imgfourth?.isHidden = true
                cell.vwlabelview?.isHidden = true
                if let imgfirst = arrMedia.first,imgfirst.media != ""  {
                    cell.imgFirst?.setImage(withUrl: imgfirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                }

            }
            else if arrMedia.count == 2 {
                cell.imgFirst?.isHidden = false
                cell.imgSecond?.isHidden = false
                cell.imgThird?.isHidden = true
                cell.imgfourth?.isHidden = true
                cell.vwlabelview?.isHidden = true
                if let imgfirst = arrMedia.first,imgfirst.media != ""  {
                    cell.imgFirst?.setImage(withUrl: imgfirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                }
                if let imgSecond = arrMedia.last,imgSecond.media != "" {
                    cell.imgSecond?.setImage(withUrl: imgSecond.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                }
            }
            else if arrMedia.count == 3 {
                cell.imgFirst?.isHidden = false
                cell.imgSecond?.isHidden = false
                cell.imgThird?.isHidden = false
                cell.imgfourth?.isHidden = true
                cell.vwlabelview?.isHidden = true
                if let imgFirst = arrMedia.first,imgFirst.media != "" {
                    cell.imgFirst?.setImage(withUrl: imgFirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)

                    cell.imgSecond?.setImage(withUrl: arrMedia[1].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)

                    cell.imgThird?.setImage(withUrl: arrMedia[2].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                }
            }
            else if arrMedia.count == 4 {
                cell.imgFirst?.isHidden = false
                cell.imgSecond?.isHidden = false
                cell.imgThird?.isHidden = false
                cell.imgfourth?.isHidden = false
                cell.vwlabelview?.isHidden = true
                if let imgFirst = arrMedia.first,imgFirst.media != "" {
                    cell.imgFirst?.setImage(withUrl: imgFirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)

                    cell.imgSecond?.setImage(withUrl: arrMedia[1].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)

                    cell.imgThird?.setImage(withUrl: arrMedia[2].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    cell.imgfourth?.setImage(withUrl: arrMedia[3].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                }

            }
            else {
                cell.imgFirst?.isHidden = false
                cell.imgSecond?.isHidden = false
                cell.imgThird?.isHidden = false
                cell.imgfourth?.isHidden = false
                cell.vwlabelview?.isHidden = false
                if let imgFirst = arrMedia.first,imgFirst.media != "" {
                    cell.imgFirst?.setImage(withUrl: imgFirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)

                    cell.imgSecond?.setImage(withUrl: arrMedia[1].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)

                    cell.imgThird?.setImage(withUrl: arrMedia[2].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    cell.imgfourth?.setImage(withUrl: arrMedia[3].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)

                }

            }
        }
        
        cell.btnDeleteAlbum?.tag = indexPath.row
        cell.btnDeleteAlbum?.addTarget(self, action: #selector(self.btnDeleteAlbumClicked(_:)), for: .touchUpInside)
        
        cell.btnAddimg?.tag = indexPath.row
        cell.btnAddimg?.addTarget(self, action: #selector(self.btnAddimgClicked(_:)), for: .touchUpInside)
   
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = ((collectionView.frame.width) - ((3 - 1) * 3)) / 3
        return CGSize(width: width, height: 130)
        
//        return CGSize(width: (collectionView.frame.size.width / 3.0) - 12.0, height: ((collectionView.frame.size.width / 3.0) - 12.0))
//        return CGSize(width: (collectionView.frame.size.width - 10) / 3, height: (collectionView.frame.size.height - 10) / 3)
        //return CGSize(width: (collectionView.frame.size.width / 2.0) - 10.0, height: (indexPath.row / 2 == 0) ? ((collectionView.frame.size.width / 1.5) - 10.0) : ((collectionView.frame.size.width / 2.0) - 10.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == arrImages.count {
            
        } else {
            self.appNavigationController?.push(InsideAlbumViewController.self.self,configuration: { vc in
                vc.selectedAlbumdata = self.arrImages[indexPath.row].id
                vc.isfromOther = self.isfromother
            })
        }
    }
    @objc func btnAddimgClicked(_ sender : UIButton){
        self.appNavigationController?.detachRightSideMenu()
        self.appNavigationController?.present(AlbumNameViewController.self,configuration: { vc in
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.delegate = self
            vc.isfromProfile = true
            vc.isfromAlbum = true 
             
        })
    }
    
    @objc func btnDeleteAlbumClicked(_ sender : UIButton){
        self.showAlert(withTitle: "", with:"Are you sure want to delete this Album?", firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
            if self.arrImages.count > 0 {
                self.DeletePfotoAlbumApi(albumId: self.arrImages[sender.tag].id)
            }
        }, secondButton: ButtonTitle.No, secondHandler: nil)
    }
}

//MARK:- UITableView Delegate
extension AlbumViewController : addAlbumDelegate {
    func reloadalbum() {
        self.arrImages.removeAll()
        self.cvAlbum?.reloadData()
        self.getAlbumsAPICall()
    }
}

extension AlbumViewController {
    
private func getAlbumsAPICall() {
    if let user = UserModel.getCurrentUserFromDefault() {
        let dict : [String:Any] = [
            ktoken : user.token,
            klangType : Rosterd.sharedInstance.languageType,
            kuserId : self.userId
          
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        ProfileAlbumModel.getAlbums(with: param, success: { (arr,message) in
            self.arrImages = arr
            self.cvAlbum?.reloadData()
         
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
 }
    
    
    private func DeletePfotoAlbumApi(albumId : String){
      if let user = UserModel.getCurrentUserFromDefault() {
          self.view.endEditing(true)
          
          let dict : [String:Any] = [
              klangType : Rosterd.sharedInstance.languageType,
              ktoken : user.token,
              kalbumId : albumId
          ]
          
          let param : [String:Any] = [
              kData : dict
          ]
          
          ProfileAlbumModel.DeletePfotoAlbum(with: param, success: { (msg) in
              self.arrImages.removeAll()
              self.cvAlbum?.reloadData()
              self.getAlbumsAPICall()
          }, failure: {[unowned self] (statuscode,error, errorType) in
              print(error)
              if !error.isEmpty {
                  self.showMessage(error, themeStyle: .error)
              }
          })
      }
    
    }
}
// MARK: - ViewControllerDescribable
extension AlbumViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}
// MARK: - AppNavigationControllerInteractable
extension AlbumViewController: AppNavigationControllerInteractable { }
