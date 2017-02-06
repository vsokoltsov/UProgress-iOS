//
//  DirectionModelProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire

protocol DirectionModelProtocol {
    func loadDirectionsList(userNick: String, pageNumber: Int, success: @escaping (_ directions: [Direction]) -> Void, failure: @escaping (_ error: NSError) -> Void)
    func loadDirection(userNick: String, directionId: String!, success: @escaping (_ direction: Direction) -> Void, failure: @escaping (_ error: NSError) -> Void)
}
