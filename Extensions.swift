//
//  Extensions.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/12.
//

import Foundation

// - Topic: Extensions

/// 스위프트는 extension 기능을 제공해 기존에 존재하는 클래스, 열거형, 구조체에 기능을 추가할 수 있다.
/// - Note: extension을 통해 다음을 수행할 수 있다.
/// 연산 프로퍼티와, 타입 연산 프로퍼티를 추가할 수 있다.
/// 인스턴스 메소드와, 타입 인스턴스 메소드를 추가할 수 있다.
/// 새로운 초기자를 제공할 수 있다.
/// subscript를 정의할 수 있다.
/// 중첩된 타입을 정의하고 사용할 수 있다.
/// 기존 타입이 프로토콜을 따르도록 할 수 있다.

/*------------------------------------------*/

/// - Extension Syntax
/// extention을 통해 어느 타입에 기능을 추가한다면, 그 타입의 인스턴스에서
/// 확장한 기능을 바로 사용할 수 있다.
extension SomeType{
    // adding new functionlity..
}

/// 기존에 타입이 프로토콜을 따르도록 할 수 있다.
extension SomeType: SomeProtocol, AnotherProtocol{
    //
}

/*------------------------------------------*/

/// - Computed Properties
/// extension을 이용해 연산 프로퍼티와 타입 연산 프로퍼티를 추가할 수 있다.
/// 하지만, 저장 프로퍼티나 프로퍼티 감시자는 추가할 수 없다.
extension Double{
    var km: Double{ return self * 1000}
    var m: Double{ return self }
    var cm: Double{ return self / 100 }
    var mm: Double{ return self / 1000}
    var ft: Double{ return self / 3.28084}
}

let oneInch = 25.4.mm
let threeFeet = 3.ft
let aMarathon = 42.km + 195.m

/*------------------------------------------*/

/// - Initializers
/// 구조체나, 열거형, 클래스에서는 이니셜라이저를 확장할 수 있다.
/// 하지만, 클래스의 경우 편의 이니셜라이저만 추가가 가능하다.
/// 디이니셜라이저는 추가할 수 없다.
/// 값 타입의 경우(구조체, 열거형), 모든 프로퍼티가 기본 값이 있고, 사용자 정의 이니셜라이저가 없는 경우 extension을 통해
/// 멤버와이즈 이니셜라이저와 디폴트 이니셜라이저를 호출할 수 있다.
/// 만약, 사용자 정의 이니셜라이저가 기존 값 타입 구조체, 열거형에 있다면 호출할 수 없다.
struct Size{
    var width = 0.0, height = 0.0
}

struct Point{
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}
// Size와 Point구조체는 프로퍼티의 기본값이 정의되있고, 사용자 정의 이니셜라이저가 없으므로,
// 디폴트이니셜라이저와, 멤버와이즈 이니셜라이저가 제공된다.
// extension을 통해 이를 호출할 수도 있다.
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
   size: Size(width: 5.0, height: 5.0))

extension Rect{
    init(center: Point, size: Size){
        let originX = center.x - (size.width / 2.0)
        let originY = center.y - (size.height / 2.0)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)

/// - Note: extension을 통해 어느 타입의 기능을 확장했다면, 이전에 생성된 인스턴스에도 적용되어 있는지 확인할 필요가 있다.

/*------------------------------------------*/

/// - Methods
/// extension을 통해 해당 타입에 인스턴스 메소드나 타입 메소드를 추가할 수 있다.
extension Int{
    func repeatition( task: () -> Void){
        for _ in 0..<self{
            task()
        }
    }
}

3.repeatition{
    print("hello")
}

3.repeatition(task: { print("hello") })

/*------------------------------------------*/

/// - Subscript
/// extension으로 해당 타입에 서브스크립트 기능을 추가할 수 있다.
/// 다음은 오른쪽부터 계산한 인덱스의 정수를 return하는 서브스크립트이다.
/// 만약, return할 수 없다면, 0을 return한다.
extension Int{
    subscript (baseIndex: Int) -> Int{
        var baseDigit = 1
        for _ in 0..<baseIndex{
            baseDigit *= 10
        }
        return (self / baseDigit) % 10
    }
}

/*------------------------------------------*/

/// - Nested Types
/// 클래스, 열거형, 구조체에 extension으로 중첩된 타입을 추가할 수 있다.
extension Int{
    enum Kind{
        case zero, positive, negative
    }
    
    var kind: Kind{
        switch self{
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default :
            return .negative
        }
    }
}
/// 위의 중첩된 열거형과 읽기 전용 연산 프로퍼티를 Int 타입에 적용할 수 있다.
func printIntegerKind(_ numbers: [Int]){
    for number in numbers{
        switch number.kind{
        case .negative:
            print("-", terminator: " ")
        case .positive:
            print("+", terminator: " ")
        case .zero:
            print("0", terminator: " ")
        }
    }
}

printIntegerKind([1,2,-7,-2,4,0,2,0])
