//
//  TrackManager.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation

class TrackManager {
    // TODO: 프로퍼티 정의하기 - 트랙들, 앨범들, 오늘의 곡
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todaysTrack: AVPlayerItem?
    
    // TODO: 생성자 정의하기
    init() {
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todaysTrack = self.tracks.randomElement()
    }

    // TODO: 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        // 파일들 읽어서 AVPlayerItem 만들기
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []  // Bundle : local 파일 사용시 활용
        
        // 일반 버전
//        var items: [AVPlayerItem] = []
//        for url in urls {
//            let item = AVPlayerItem(url: url)
//            items.append(item)
//        }
        // 조금 어려운 버전-1
//        let items = urls.map { url -> AVPlayerItem in
//            let item = AVPlayerItem(url: url)
//            return item
//        }
        // 조금 어려운 버전-2 (강의에서 쌤이 선호하는 방식)
//        let items = urls.map { url in
//            return AVPlayerItem(url: url)
//        }
//        결국 ㅁㅁ.map 이라는걸 사용하면 ㅁㅁ라는 이름의 새로운 배열이 생성되는 것.
        
        // 조금 어려운 버전-3
        let items = urls.map { AVPlayerItem(url: $0) }  // 하나씩 들어오는 urls이 AVPlayerItem로 생성되어서 그것이 items로 리턴이 되는 것
        
        return items
    }
    
    // TODO: 인덱스에 맞는 트랙 로드하기
    func track(at index: Int) -> Track? {
        let playerItem = tracks[index]
        let track = playerItem.convertToTrack()
        return track
    }

    // TODO: 앨범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        let trackList: [Track] = tracks.compactMap { $0.convertToTrack() }
        let albumDics = Dictionary(grouping: trackList, by: { track in track.albumName})
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        return albums
    }

    // TODO: 오늘의 트랙 랜덤으로 선책
    func loadOtherTodaysTrack() {
        self.todaysTrack = self.tracks.randomElement()
    }
}
