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
    
    private var _vRights: String
    private var _vPrice: String
    private var _vArtist:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDte:String
    
    // this variable gets created from the UI
    var vImageData: NSData?
    
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
    
    var vRights: String {
        return _vRights
    }
        
    var vPrice: String {
        return _vPrice
    }
        
    var vArtist: String {
        return _vArtist
    }
                    
    var vImid: String {
        return _vImid
    }
                    
    var vGenre: String {
        return _vGenre
    }
        
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
                                
    var vReleaseDte: String {
        return _vReleaseDte
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
 
        
        
        if let rights = data["rights"] as? JSONDictionary,
            vRights = rights["label"] as? String {
                self._vRights = vRights
        }
        else {
            _vRights = ""
        }
        
        
        if let price = data["im:price"] as? JSONDictionary,
            vPrice = price["label"] as? String {
                self._vPrice = vPrice
        }
        else {
            _vPrice = ""
        }

        
        if let artist = data["im:artist"] as? JSONDictionary,
            vArtist = artist["label"] as? String {
                self._vArtist = vArtist
        }
        else {
            _vArtist = ""
        }


        
        if let imid = data["id"] as? JSONDictionary,
            vid = imid["attributes"] as? JSONDictionary,
            vImid = vid["im:id"] as? String {
                self._vImid = vImid
        }
        else {
            _vImid = ""
        }

        
        if let genre = data["category"] as? JSONDictionary,
            rel2 = genre["attributes"] as? JSONDictionary,
            vGenre = rel2["term"] as? String {
                self._vGenre = vGenre
        }
        else {
            _vGenre = ""
        }
        

        if let release2 = data["id"] as? JSONDictionary,
            vLinkToiTunes = release2["label"] as? String {
                self._vLinkToiTunes = vLinkToiTunes
        }
        else {
            _vLinkToiTunes = ""
        }
        
      
        if let release2 = data["im:releaseDate"] as? JSONDictionary,
            rel2 = release2["attributes"] as? JSONDictionary,
            vReleaseDte = rel2["label"] as? String {
                self._vReleaseDte = vReleaseDte
        }
        else {
            _vReleaseDte = ""
        }

    }
}