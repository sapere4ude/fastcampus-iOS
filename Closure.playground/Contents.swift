import UIKit

// MARK: - 클로저는 이름없는 메서드. 실무에서 사용할땐 동적으로 기능을 끼워넣을때 사용할 수 있다.

// 기본적인 클로저의 모양
var multiplyClosure1: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
        return  a * b
}

// 클로저의 단축. [반환타입, 매개변수의 타입, 괄호, return 값, 매개변수] 제거
var simpleMultiplyClosure: (Int, Int) -> Int = { $0 * $1 }

let result = simpleMultiplyClosure(4,2)

func operateTwoNum(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a,b)
    return result
}

// 위에서 만든 클로저를 가져와서 사용
operateTwoNum(a: 4, b: 2, operation: simpleMultiplyClosure)

// 변수를 하나 설정해서 클로저를 만든 뒤
var addClosure: (Int, Int) -> Int = { a, b in
    return a + b
}
// 이렇게 기존의 함수에 추가하여 사용할 수도 있다.
operateTwoNum(a: 4, b: 2, operation: addClosure)

// 즉흥적으로 클로저를 만드는 방법도 존재한다
operateTwoNum(a: 4, b: 2) { (a, b) -> Int in
    return a / b
}

// 
