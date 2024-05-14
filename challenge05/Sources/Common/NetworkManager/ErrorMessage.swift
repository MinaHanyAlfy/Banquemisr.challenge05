//
//  ErrorMessage.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation

enum ErrorMessage : String,Error {
    case InvalidData = "Sorry ,Something went wrong try agian."
    case InvalidRequest = "Sorry ,This url isn't good enough ,Try agian later."
    case InvalidResponse = " Server Error ,Modify your search and try agian."
    case NoInternet = "No internet connection"
}
