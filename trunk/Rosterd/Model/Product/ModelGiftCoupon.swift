
import Foundation


class ModelGiftCoupon : NSObject{

	var subData : [ModelSubData]

	init(fromDictionary dictionary: [String:Any]){
		subData = [ModelSubData]()
		if let subDataArray = dictionary["sub_data"] as? [[String:Any]]{
			for dic in subDataArray{
				let value = ModelSubData(fromDictionary: dic)
				subData.append(value)
			}
		}
	}
    
    class func getGiftCouponNew(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ sub_data: [ModelGiftCoupon],_ msg : String) -> Void, failure: @escaping FailureBlock) {
          if isShowLoader {
              SVProgressHUD.show()
          }
          APIManager.makeRequest(with: AppConstant.API.kgetGiftCouponNew, method: .post, parameter: param, success: {(response) in
              if isShowLoader {
                  SVProgressHUD.dismiss()
              }
              let dict = response as? [String:Any] ?? [:]
  
              let message = dict[kMessage] as? String ?? ""
              let statuscode = dict[kstatus] as? String ?? "0"
              let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
    
              if  isSuccess,let arr = dict[kData] as? [[String:Any]] {
                  let sub_data = arr.compactMap({ModelGiftCoupon.init(fromDictionary: $0)})
                  
                  withResponse(sub_data,message)
              }
              else {
                  failure(statuscode,message, .response)
              }
          }, failure: { (error) in
              if isShowLoader {
                  SVProgressHUD.dismiss()
              }
              failure("0",error, .server)
          }, connectionFailed: { (connectionError) in
              if isShowLoader {
                  SVProgressHUD.dismiss()
              }
              failure("0",connectionError, .connection)
          })
      }
}
