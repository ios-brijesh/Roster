
import Foundation


class ModelSubData : NSObject {

	var couponCode : String
	var createdDate : String
	var descriptionField : String
	var expiryDate : String
	var id : String
	var image : String
	var offerImage : String
	var offerPercentage : String
	var status : String
	var thumbOfferImage : String
	var updatedDate : String
	var userId : String
	var websiteLink : String
    var isFlipped:Bool

	init(fromDictionary dictionary: [String:Any]){
		couponCode = dictionary["couponCode"] as? String ?? ""
		createdDate = dictionary["createdDate"] as? String ?? ""
		descriptionField = dictionary["description"] as? String ?? ""
		expiryDate = dictionary["expiryDate"] as? String ?? ""
		id = dictionary["id"] as? String ?? ""
		image = dictionary["image"] as? String ?? ""
		offerImage = dictionary["offerImage"] as? String ?? ""
		offerPercentage = dictionary["offerPercentage"] as? String ?? ""
		status = dictionary["status"] as? String ?? ""
		thumbOfferImage = dictionary["thumbOfferImage"] as? String ?? ""
		updatedDate = dictionary["updatedDate"] as? String ?? ""
		userId = dictionary["userId"] as? String ?? ""
		websiteLink = dictionary["websiteLink"] as? String ?? ""
        isFlipped = false
	}
}
