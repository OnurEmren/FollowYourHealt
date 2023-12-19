//
//  UserInfo.swift
//  FollowYourHealt
//
//  Created by Onur Emren on 12.12.2023.
//

import Foundation
import CoreData

class UserData: NSManagedObject {
    @NSManaged var height: Int
    @NSManaged var weight: Int
}
