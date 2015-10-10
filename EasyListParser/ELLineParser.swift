//
//  ELLineParser.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/29/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import Foundation

// https://adblockplus.org/filters
// https://adblockplus.org/filter-cheatsheet

class ELLineParser {
    
    static func parse(line: String) throws -> ELBlockerEntry {
        
        if let char = line.characters.first {
            switch char {
            case "[", "!", "@" :
                break
            default:
                
                var domainFilter: String = ""
                var cssSelector: String = ""
                var filterOptions: String = ""
                
                if line.containsString("##") {
                    let cssParts = line.componentsSeparatedByString("##")
                    domainFilter = cssParts[0]
                    cssSelector = cssParts[1]
                } else if line.containsString("$") {
                    var optionParts = line.componentsSeparatedByString("$")
                    
                    //this may be more than 2 parts, e.g. 3, and the first 2 are the domain, concat
                    filterOptions = optionParts.last!
                    optionParts.removeLast()
                    domainFilter = optionParts.joinWithSeparator("");
                    
                } else {
                    domainFilter = line
                }
                
                let filterOptionParts: [String]
                if !filterOptions.isEmpty {
                    filterOptionParts = filterOptions.componentsSeparatedByString(",")
                    
                } else {
                    filterOptionParts = []
                }
                
                if  // limitation of RegEx in WebKit Content Blocker
                    domainFilter.canBeConvertedToEncoding(NSASCIIStringEncoding) &&
                    // limitation of RegEx in WebKit Content Blocker
                    !domainFilter.containsString("{") {
                        
                        let entry = ELBlockerEntry()
                        entry.trigger.urlFilter = ELFilterParser.parse(domainFilter)
                        
                        if cssSelector.isEmpty {
                            entry.action.type = ELBlockerEntry.Action.Type.Block.rawValue
                        } else {
                            entry.action.type = ELBlockerEntry.Action.Type.CssDisplayNone.rawValue
                            entry.action.selector = cssSelector
                        }
                        
                        try ELOptionParser.parse(filterOptionParts, destination: entry)
                        
                        return entry
                }
            }
            
        }
        
        throw ELParserError.InvalidInput
    }
}