//
//  Methods.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/09.
//

import Foundation

// - Topic: Methods
///
/// 스위프트에서는 다른 언어와 다르게 열거형, 구조체에서도 메소드 정의가 가능하다.
/// 이는 타입 메소드에 대해서도 마찬가지이다.

/// - Instance Methods
/// 인스턴스 메소드는 인스턴스에 종속된 함수이다.
/// 함수와 마찬가지로, 인자레이블과 매개변수 이름을 동시에 설정할 수 있다.
class Counter{
    var count = 0
    
    func implement(){
        count += 1
    }
    func implement(by amount: Int){
        count += amount
    }
    func reset(){
        count = 0
    }
}

let counter = Counter()
counter.implement() // 1
counter.implement() // 2
counter.implement(by: 4) // 6

/// 메소드내에서 self 키워드를 사용할 수 있다.
/// self는 인스턴스를 의미하며, 주로 메소드 내에서 매개변수의 이름과 프로퍼티의 이름이 같은 경우 사용한다.
/// 스위프트는 매개변수를 우선순위로 생각하기 때문에 두 이름이 같은 경우, 둘다 매개변수로 취급한다.
/// 따라서 이를 구분하기 위해 self를 명시한다.
struct Point{
    var x = 0.0, y = 0.0
    
    func isToRightOf(x: Double) -> Bool{
        return self.x > x
    }
}

/// 구조체와 열거체는 값 타입이다.
/// 따라서 메소드 내에서 인스턴스의 프로퍼티 값을 변경할 수 없다.
/// 하지만, mutating 키워드를 이용해 이를 해결할 수 있다.
/// 만약, 상수 인스턴스라면 mutating 메소드를 호출할 수 없다.
struct Point{
    var x = 0.0, y = 0.0
    
    mutating func moveTo(x deltaX: Double, y deltaY: Double){
        self.x += deltaX
        self.y += deltaY
    }
}

var somePoint = Point()
somePoint.moveTo(x: 4, y:5) // 4.0, 5.0

let somePoint2 = Point() // 값 타입을 가리키는 상수이므로 mutating 메소드를 호출할 수 없다.

/// mutating 메소드에서 새로운 인스턴스를 할당할 수 있다.
/// 아래의 예는 위의 예와 완전히 동일하다.
struct Point{
    var x = 0.0, y = 0.0
    
    mutating func moveTo(x deltaX: Double, y deltaY: Double){
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

/// 또한, 열거형에서도 위와 동일한 연산을 할 수 있다.
enum TristateSwitch{
    case low, high, off
    
    mutating func next(){
        switch self{
        case .low:
            self = .high
        case .high:
            self = .off
        case .off:
            self = .low
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off

/*------------------------------------------*/

/// - Type Methods
/// 타입 메소드는 타입에 종속된 메소드이다.
/// 스위프트에서 타입 메소드는 클래스, 열거형, 구조체에 모두 사용가능하다.
/// static 키워드로 정의할 수 있으며, 클래스의 경우 class 키워드를 이용한다면 상속이 가능하도록 구현할 수 있다.
/// 타입 메소드의 self 키워드는 타입 그 자체를 의미한다.
/// 또한 타입 메소드에서 타입 메소드와 타입 프로퍼티 호출은 .앞에 타입명을 붙이지 않고, 마치 프로퍼티처럼 호출할 수 있다.
/// 타입 메소드에서는 인스턴스 프로퍼티에 접근이 불가능하다.
struct LevelTracker{
    var currentLevel = 1
    
    static var highestUnlockedLevel = 1
    
    static func unlock(_ level: Int){
        if level > highestUnlockedLevel{
            highestUnlockedLevel = level
        }
    }
    static func isUnlocked(_ level: Int) -> Bool{
        level <= highestUnlockedLevel
    }
    
    // 리턴 값이 무시되도 좋은 경우, 사용하는 attribute
    // _ = x.advance(to:) 와 동일
    @discardableResult
    mutating func advance(to level: Int) -> Bool{
        if LevelTracker.isUnlocked(level){
            currentLevel = level
            return true
        }else{
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

let player1 = Player(name: "Lee")
player1.complete(level: 1)
let player2 = Player(name: "Park")
player2.complete(level: 2)

