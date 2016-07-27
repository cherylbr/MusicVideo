//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Cheryl Broder on 27/07/2016.
//  Copyright © 2016 Cheryl Broder. All rights reserved.
//

import Foundation

class Videos {

    // Data Encapsulation
    
    private var _vName:String
    private var _vImageURL:String
    private var _vVideoURL:String
    
    // Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vImageURL: String {
        return _vImageURL
    }
    
    var vVideoURL: String {
        return _vVideoURL
    }
    init (data: JSONDictionary) {
        
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            self._vName = vName
            }
        else {
            _vName = ""
        }
    
    
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageURL =
                    immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }
        else {
         _vImageURL = ""
        }
    
        if let video = data["link"] as? JSONArray,
            vURL = video[1] as? JSONDictionary,
            vHref = vURL["attributes"] as? JSONDictionary,
            vVideoURL = vHref["href"] as? String {
                self._vVideoURL = vVideoURL
        }
        else {
            self._vVideoURL = ""
        }
    
}
}