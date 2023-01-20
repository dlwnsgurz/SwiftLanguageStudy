//
//  Structures and Classes.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/06.
//

import Foundation

// - Topic: Structures and Classes
/// 다른 프로그래밍 언어와 다르게 스위스트에서 구조체와 클래스는
/// 기능적으로 많이 유사하다

/// - Comparing Structures and Classes
/// - Note: 공통점
/// - 프로퍼티를 통해 값을 저장할 수 있다.
/// - 메소드를 통해 동작을 수행할 수 있다.
/// - 서브스크립트를 통해 값에 접근할 수 있다.
/// - 생성자를 정의할 수 있다.
/// - 기본 구현을 확장해 기능을 추가할 수 있다.
/// - 프로토콜을 따를 수 있다.
///
/// - Note: 차이점
/// - 클래스에서만 상속이 가능하다.
/// - 타입 캐스팅을 통해 런타임에 인스턴스의 타입을 확인할 수 있다.
/// - 할당한 데이터를 회수하기위해 소멸자를 정의할 수 있다.
/// - 래퍼런스 카운팅에 의해 클래스의 인스턴스가 여러 객체를 갖도록 할 수 있다.

/// 구조체와 클래스를 정의할 때 struct 키워드와 class 키워드를 각각 사용하면된다.
/// 타입명을 정의할때는 UpperCamelCase를 사용해야 한다.
/// 구조체는 기본적으로 멤버와이즈 이니셜라이저를 제공한다.
struct Resolution{
    var width = 0
    var height = 0
}

class VideoMode{
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name = String?
}

/// 각각의 구조체와 클래스에 대한 인스턴스는 다음과 같이 생성할 수 있다.
let someResolution = Resolution()
let someVideomode = VideoMode()

/*------------------------------------------*/

/// - Structures and Enumerations are Value Types
/// Integer, Float 외에 컬렉션 타입의 경우도 값 타입이다.
/// 따라서 함수의 인자로 전달되거나 리턴 값으로 전달될 때 래퍼런스가 아닌 값이 복사된다.
let hd = Resolution(width: 1280, height: 780)
var cinema = hd
/// 위의 예에서 hd는 구조체의 인스턴스 상수이다.
/// cinema는 hd의 인스턴스를 그대로 값 복사를 하였다. 값의 복사를 한 것이기때문에 둘이 서로 다른 인스턴스이다.
/// 만약 cinema의 값을 변경한다면, hd의 값은 변하지 않는다.
/// cinema는 hd의 "값"만 복사한 다른 인스턴스이기 때문이다.

/// 열거형도 값 타입이다.
enum CompassPoint{
    case north, west, east, south
    mutating func changeDirection(){
        self = .west
    }
}

var rememberedDirection = CompassPoint.east
let tempDirection = rememberedDirection
rememberedDirection.changeDirection()

/// rememeberDircectin 의 값을 변경해도
/// tempDirection의 값이 변경되지 않는다.
/// tempDirection 인스턴스는 remeberDirection 과 다르다.
print("\(rememberedDirection)")
print("\(tempDirection)")

/*------------------------------------------*/

/// - Classes Are Reference Types
/// 구조체, 열거형과는 다르게 클래스는 참조 타입이다.
/// 이는 코드를 이해하기 어렵게 할 수 있다. (원본을 찾기 힘들 수 있다는 뜻)
let tenEighty = VideoMode()
tenEighty.frameRate = 25.0
tenEighty.interlaced = true
tenEighty.resolution = Resolution(width: 1, height: 1)
tenEighty.name = "1080i"

let alsoTenEighty = tenEighty
alsoTenEighty.name = "1080i2"

print("alsoTenEighty.name = \(alsoTenEighty.name), tenEighty.name = \(tenEighty.name)")
// alsoTenEighty.name = 1080i2, tenEighty.name = 1080i2

/// 스위프트는 두 인스턴스가 같은 인스턴스인지 연산하는 비교 연산자가 존재한다
/// ===, !== 로 두 인스턴스가 같은지, 같지 않은지 비교할 수 있다.
