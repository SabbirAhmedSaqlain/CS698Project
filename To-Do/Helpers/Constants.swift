//
//  Constants.swift
//  To-Do
//
//  Created by Aaryan Kothari on 11/10/20.
 
//

import Foundation


class Constants {
    
    struct ViewController{
        static let Onboarding = "OnboardingViewController"
        static let ResultsTable = "ResultsTableController"
    }
    
    struct Cell{
        static let taskCell = "todocell"
        static let photoCell = "AttachmentCell"
    }
    
    struct Segue{
        static let taskToTaskDetail = "gototask"
        static let createNewNotes = "createNewNotes"
        
    }
    
    struct Key{
        static let onboarding = "already_shown_onboarding"
        static let pin = "pinnumber"
        static let face = "faceid"
        static let noteCounter = "noteCounter"
    }
    
    struct Action{
        static let star = "star"
        static let unstar = "unstar"
        static let add = "add"
        static let update = "update"
        static let delete = "delete"
        static let complete = "complete"
        static let cancel = "cancel"
    }
}
