//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by William Ko on 12/12/15.
//  Copyright © 2015 Will Ko. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(_ url: NSURL, name: String) {
        filePathUrl = url
        title = name
    }
}