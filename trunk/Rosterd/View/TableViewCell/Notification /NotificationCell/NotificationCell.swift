//
//  NotificationCell.swift
//  LightOnLeadership
//
//  Created by Harshad on 19/02/22.
//

import UIKit

class NotificationCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var imgUserProfile: UIImageView?
    @IBOutlet weak var vwUserProfileMain: UIView?
    
    @IBOutlet weak var imgNotification: UIImageView?
    @IBOutlet weak var vwNotificationImgMain: UIView?
    @IBOutlet weak var vwNotificationImgSub: UIView?
    @IBOutlet weak var VwMainImageUser: UIView!
    
    @IBOutlet weak var lblNotificationDesc: UILabel?
    @IBOutlet weak var lblNotificationTime: UILabel?
    
    @IBOutlet weak var vwPhotoMain: UIView?
    @IBOutlet weak var cvPhoto: UICollectionView?
    @IBOutlet weak var constraintCVPhotoHeight: NSLayoutConstraint?
    // MARK: - Variables
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addCollectionviewOberver()
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let btn = self.vwUserProfileMain {
            btn.cornerRadius = btn.frame.height/2
        }
        if let btn = self.imgUserProfile {
            btn.cornerRadius = btn.frame.height/2
        }
    }
    
    private func initConfig() {
        self.lblNotificationDesc?.textColor = UIColor.CustomColor.labelTextColor
        self.lblNotificationDesc?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
//        self.lblNotificationDesc?.setNotificationTextLable(firstText: "Patricia", SecondText: "has posted her new photos")
        
        self.lblNotificationTime?.textColor = UIColor.CustomColor.sepretorColor
        self.lblNotificationTime?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
        self.vwNotificationImgSub?.cornerRadius = 13.0
        self.imgNotification?.cornerRadius = 13.0
        
     
        
        self.cvPhoto?.register(NotificationPhotoCell.self)
        self.cvPhoto?.dataSource = self
        self.cvPhoto?.delegate = self
    }
    
    func setNotificationData(obj : NotificationModel){
        
       
//        self.lblNotificationDesc?.setNotificationTextLable(firstText: "\(obj.senderName) ", SecondText: "\(obj.desc)")
        self.lblNotificationTime?.text = obj.time
        self.vwPhotoMain?.isHidden = true
        if obj.rightSideImage != "" {
            self.vwNotificationImgMain?.isHidden = false
            self.imgNotification?.setImage(withUrl: obj.rightSideImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        } else {
            self.vwNotificationImgMain?.isHidden = true
        }
        
//        self.imgNotification?.setImage(withUrl: obj.rightSideImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        if obj.image != "" {
            self.VwMainImageUser?.isHidden = false
            self.imgUserProfile?.setImage(withUrl: obj.image, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        } else {
            self.VwMainImageUser?.isHidden = true
        }
//        self.imgUserProfile?.setImage(withUrl: obj.image, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
        var first = ""
        var second = ""
//        var third = ""
//        var four = ""
        
        var firstColor = ""
        var secondColor = ""
//        var thirdColor = ""
//        var fourColor = ""
        
        
        let arrDesList = obj.descList
        if arrDesList.count != 0 {
            for obj in arrDesList {
                if obj.color == "#0A5C94" && obj.weight == "bold" {
                    let firstTemp = obj.text + " "
                    if (first == "") {
                        first = firstTemp
                        firstColor = obj.color
                    }
                } else if obj.color == "#000000" && obj.weight == "normal" {
                    let secondTemp = obj.text + " "
                    if (second == "") {
                        second = secondTemp
                        secondColor = obj.color
                    }
                }
//                else if obj.color == "#0A5C94" && obj.weight == "bold" {
//                    let thirdTemp = obj.text + " "
//                    if (third == "") {
//                        third = thirdTemp
//                        thirdColor = obj.color
//                    }
//                } else if obj.color == "#000000" && obj.weight == "normal" {
//                    let fourTemp = obj.text + " "
//                    if (four == "") {
//                        four = fourTemp
//                        fourColor = obj.color
//                    }
//                }
            }
        }
        self.lblNotificationDesc?.setHomeHeaderAttributedText4(firstText: "\(first)", fc: "\(firstColor)", SecondText: "\(second)", sc: "\(secondColor)")
    }
}



//MARK: - Tableview Observer
extension NotificationCell {
    
    private func addCollectionviewOberver() {
        self.cvPhoto?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    func removeCollectionviewObserver() {
        if self.cvPhoto?.observationInfo != nil {
            self.cvPhoto?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UICollectionView {
            if obj == self.cvPhoto && keyPath == ObserverName.kcontentSize {
                self.constraintCVPhotoHeight?.constant = self.cvPhoto?.contentSize.height ?? 0.0
                //self.cvPhoto?.layoutIfNeeded()
                self.contentView.layoutIfNeeded()
            }
        }
    }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension NotificationCell : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: NotificationPhotoCell.self)
        
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
        return CGSize(width: 50, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

// MARK: - NibReusable
extension NotificationCell: NibReusable { }

