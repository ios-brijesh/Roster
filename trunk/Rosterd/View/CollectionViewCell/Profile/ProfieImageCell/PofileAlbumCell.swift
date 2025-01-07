//
//  PofileAlbumCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 18/02/22.
//

import UIKit

class PofileAlbumCell: UICollectionViewCell {

    
    // MARK: - IBOutlet
    @IBOutlet weak var vwMain: UIView?
    @IBOutlet weak var vwpicview: UIView!
    
    @IBOutlet weak var btnAddimg: UIButton!
    @IBOutlet weak var vwPlusView: UIView!
    @IBOutlet weak var cvImg: UICollectionView?
    
    @IBOutlet weak var lblAlbumname: UILabel!
    
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var imgSecond: UIImageView!
    @IBOutlet weak var imgThird: UIImageView!
    @IBOutlet weak var imgfourth: UIImageView!
    
    @IBOutlet weak var lblcount: UILabel!
    @IBOutlet weak var vwfirst: UIView!
    @IBOutlet weak var vwsecond: UIView!
    @IBOutlet weak var vwthird: UIView!
    @IBOutlet weak var vwfourth: UIView!
    @IBOutlet weak var vwlabelview: UIView!
    
    @IBOutlet weak var btnDeleteAlbum: UIButton!
    private var arrImageupload : [ProfileImageModel] = []
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.contentView.clipsToBounds = true
        self.contentView.cornerRadius = 10.0
        //self.contentView.shadow(UIColor.CustomColor.shadowColorBlack, radius: 5.0, offset: CGSize(width: 4, height: 2), opacity: 1)
        self.contentView.maskToBounds = false
    }

    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        self.lblAlbumname?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        self.lblAlbumname?.textColor = UIColor.CustomColor.blackColor
        
        self.lblcount?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        self.lblcount?.textColor = UIColor.CustomColor.blackColor
       
        
        self.vwlabelview?.backgroundColor = UIColor.CustomColor.shadowColor43Black
       
            if let vw = self.vwMain {
                vw.cornerRadius = 13.0
            }
        //}
        
        self.vwpicview?.cornerRadius = 13.0
        self.vwpicview?.borderColor = UIColor.CustomColor.yesnoColor
        self.vwpicview?.borderWidth = 1.0
        
        self.cvImg?.register(AlbumCell.self)
        self.cvImg?.dataSource = self
        self.cvImg?.delegate = self
        
        [self.imgfourth,self.imgThird,self.imgSecond,self.imgFirst].forEach({
            $0?.cornerRadius = 10.0
            
            
        })
        
        [self.vwfirst,self.vwsecond,self.vwthird,self.vwfourth].forEach({
            $0?.cornerRadius = 10.0
            
            
        })
        
      
       
    }
    
    func setAlbumData(obj : ProfileAlbumModel) {
        self.lblAlbumname.text = obj.name
        self.lblcount.text = obj.hideMediaCount
        
    }
    
    func setAlbumData(_ data:ProfileAlbumModel?) {
        if let albumData = data{
            self.lblAlbumname.text = albumData.name
            self.lblcount.text = albumData.hideMediaCount
        }
    }
}


//MARK: - UICollectionView Delegate and Datasource Method
extension PofileAlbumCell : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AlbumCell.self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.height - 10) / 4, height: (collectionView.frame.size.height - 10) / 4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}



// MARK: - NibReusable
extension PofileAlbumCell: NibReusable { }
