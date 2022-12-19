//
//  Order.swift
//  FinalProject
//
//  Created by ezz on 07/12/2022.
//

import Foundation
import Firebase

struct DBorder {
    var userId : String = ""
    var userName : String = ""
    var style : String = ""
    var region : String = ""
    var city : String = ""
    var buildingArea : String = ""
    var theNumberOfRooms : Int = 0
    var theNumberOfFloors : Int = 0
    var ceilingHeight : String = ""
    var cost : Int = 0
    var chartImage : String = ""
}


class Order {

    var userId : String = ""
    var userName : String = ""
    var style : String = ""
    var region : String = ""
    var city : String = ""
    var buildingArea : String = ""
    var theNumberOfRooms : Int = 0
    var theNumberOfFloors : Int = 0
    var ceilingHeight : String = ""
    var cost : Int = 0
    var chartImage : String = ""
    
    init(_ snapshot: DataSnapshot) {
        let obj = snapshot.value as? [String:Any] ?? [:]

        self.userId        = obj["userId"] as? String ?? ""
        self.userName      = obj["userName"] as? String ?? ""
        self.style      = obj["style"] as? String ?? ""
        self.region         = obj["region"] as? String ?? ""
        self.city     = obj["city"] as? String ?? ""
        self.buildingArea        = obj["buildingArea"] as? String ?? ""
        self.theNumberOfRooms        = obj["theNumberOfRooms"] as? Int ?? 0
        self.theNumberOfFloors        = obj["theNumberOfFloors"] as? Int ?? 0
        self.ceilingHeight        = obj["ceilingHeight"] as? String ?? ""
        self.cost        = obj["cost"] as? Int ?? 0
        self.chartImage        = obj["chartImage"] as? String ?? ""
    }
    
    init(userId: String = "", userName: String = "", style: String = "", region: String = "", city: String = "", buildingArea: String = "", theNumberOfRooms: Int = 0, theNumberOfFloors: Int = 0, ceilingHeight: String = "", cost: Int = 0, chartImage: String = "") {
       self.userId = userId
       self.userName = userName
       self.style = style
       self.region = region
       self.city = city
       self.buildingArea = buildingArea
       self.theNumberOfRooms = theNumberOfRooms
       self.theNumberOfFloors = theNumberOfFloors
       self.ceilingHeight = ceilingHeight
       self.cost = cost
       self.chartImage = chartImage
   }
    
    func toDic() -> [String:Any] {
        return [
            "userId" :self.userId  ,
            "userName": self.userName ,
            "style": self.style  ,
            "region" :self.region  ,
            "city" : self.city  ,
            "buildingArea" :self.buildingArea  ,
            "theNumberOfRooms" :self.theNumberOfRooms  ,
            "theNumberOfFloors" : self.theNumberOfFloors,
            "ceilingHeight" :self.ceilingHeight ,
            "cost" : self.cost ,
            "chartImage" : self.chartImage
        ]
        
    }
    func toAnyObject() -> [String:Any] {
        return [
            "userId" :self.userId  ,
            "userName": self.userName ,
            "style": self.style  ,
            "region" :self.region  ,
            "city" : self.city  ,
            "buildingArea" :self.buildingArea  ,
            "theNumberOfRooms" :self.theNumberOfRooms  ,
            "theNumberOfFloors" : self.theNumberOfFloors,
            "ceilingHeight" :self.ceilingHeight ,
            "cost" : self.cost ,
            "chartImage" : self.chartImage
        ]
    }
    
    
}
