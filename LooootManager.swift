//
//  LooootManagerOut.swift
//  Loooot
//
//  Created by Deventure Dev on 05/10/2020.
//  Copyright © 2020 Deventure. All rights reserved.
//
//
import Foundation
import Loooot

public class LooootManager : BaseLooootManager {
    public static var shared:BaseLooootManager
    {
        get
        {
            if(BaseLooootManager.sharedInstance.protoHttpManagerDelegate == nil)
            {
                BaseLooootManager.sharedInstance.protoHttpManagerDelegate = ProtoClientManager.shared
            }
            return BaseLooootManager.sharedInstance
        }

    }

    private override init() {
        super.init()


    }
}
