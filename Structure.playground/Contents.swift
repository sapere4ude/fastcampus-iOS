import UIKit

/*
 Structure : 관계가 있는 것들을 묶어서 표현하는 것
 
 Object = Data + Method. Object에는 Struct, Class 있다.
 
 Structure : Value Types, copy
 Class : Reference Types, Share
 */

// 문제: 가장 가까운 편의점 찾기

// 현재 스토어의 위치, 튜플형태로 표현
let store1 = (x: 3, y: 5, name: "gs")
let store2 = (x: 3, y: 5, name: "seven")
let store3 = (x: 3, y: 5, name: "cu")

// 거리 구하는 함수
func distance(current: (x: Int, y: Int), target: (x: Int, y: Int)) -> Double {
    let distanceX = Double(target.x - current.x)
    let distanceY = Double(target.y - current.y)
    let distance = sqrt(distanceX * distanceX + distanceY * distanceY)
    return distance
}

// 가장 가까운 스토어 구해서 프린트하는 함수
func printClosestStore(currentLocation: (x: Int, y: Int), stores:[(x: Int, y: Int, name: String)]) {
    var closestStoreName = ""
    var closestStoreDistance = Double.infinity
    
    for store in stores {
        let distanceToStore = distance(current: currentLocation, target: (x: store.x, y: store.y))
        closestStoreDistance = min(distanceToStore, closestStoreDistance)
        if closestStoreDistance == distanceToStore {
            closestStoreName = store.name
        }
    }
    print("Closest store: \(closestStoreName)")
}
