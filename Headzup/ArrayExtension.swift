//
//  ArrayExtension.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

extension Array {
    
    /** split in chunks with given chunk size */
    func chunks(chunksize:Int) -> [Array<Element>] {
        var words = [[Element]]()
        words.reserveCapacity(self.count / chunksize)
        for var idx = chunksize; idx <= self.count; idx = idx + chunksize {
            let word = Array(self[idx - chunksize..<idx]) // this is slow for large table
            words.append(word)
        }
        let reminder = Array(self.suffix(self.count % chunksize))
        if (reminder.count > 0) {
            words.append(reminder)
        }
        return words
    }
}
