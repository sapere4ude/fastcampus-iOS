//
//  Track.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//
import UIKit

struct Track {
    let title: String
    let artist: String
    let albumName: String
    let artwork: UIImage
    
    // 저장 프로퍼티들은 반드시 이와같이 이니셜라이저를 사용해서 초기화해줘야 한다.
    init(title: String, artist: String, albumName: String, artwork: UIImage) {
        self.title = title
        self.artist = artist
        self.albumName = albumName
        self.artwork = artwork
    }
}

struct Album {
    let title: String
    let tracks: [Track]
    
    var thumbnail: UIImage? {
        return tracks.first?.artwork
    }
    
    var artist: String? {
        return tracks.first?.artist
    }
    
    init(title: String, tracks: [Track]) {
        self.title = title
        self.tracks = tracks
    }
}
