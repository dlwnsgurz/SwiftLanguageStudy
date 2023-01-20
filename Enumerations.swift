//
//  Enumeration.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/05.
//

import Foundation

// - Topic: Enumerations
///
/// 열거형은 여러 값의 묶음으로 이루어진 하나의 타입이다.
/// 이때 해당 값들은 연관성이 높다고 할 수 있다.
/// 프로토콜을 준수할 수 있으며, 연산 프로퍼티와 인스턴스 메소드도 열거형내에 정의할 수 있다.

/// - Enumertion Syntax
/// 열거형은 enum 키워드를 이용해 정의할 수 있다.
/// C의 경우, 각각의 케이스는 0,1,2.. 의 값을 가지지만 스위프트는 그렇지 않다.
///
enum Compass{
    case north
    case east
    case south
    case west
}

enum Planet{
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

/// 이때 directionToHead의 타입은 Compass 타입이다.
var directionToHead = Compass.north

/// 스위프트의 타입 추론에 의해 생략도 가능하다.
directionToHead = .south

/*------------------------------------------*/

/// - Matching Enumeration Values with a Switch Statement
/// 스위프트의 열거형은 Swift문과 조합해 사용할 수 있다.
switch directionToHead{
case .north:
    print("This is North-Dir")
case .east:
    print("This is East-Dir")
case .south:
    print("This is South-Dir")
case .west:
    print("This is West-Dir")
}

/// 만약, 열거형 내의 모든 케이스를 커버하지 않았다면 컴파일 에리가 발생한다.
/// default 를 통해 해결할 수 있다.

/*------------------------------------------*/

/// - Iterating over Enumeration Cases
/// 열거형내의 모든 case애 대한 값을 Collection으로 얻을 수 있다.
/// 열거형 선언시에 CaseIterable 프로토콜을 따르고,
/// allCases프로퍼티를 통해 모든 케이스에 해당 하는 값이 원소로 있는 Collection을 얻을 수 있다.
enum Beverage: CaseIterable{
    case coffee, juice, tea
}

let Beverages = Beverage.allCases

for beverage in Beverages{
    print(beverage)
}

/*------------------------------------------*/

/// - Associated Values
/// 열거형의 각 케이스에는 연관 값을 정의할 수 있다.
/// Barcode 열거형은 upc케이스외, qrCode케이스를 가진다.
/// 각각의 케이스는 4개의 Int 타입의 튜플과 String 타입의 연관 값을 가진다.
enum Barcode{
    case upc(Int,Int,Int,Int)
    case qrCode(String)
}

/// 연관 값을 이용해보자.
var myBarcode = Barcode.upc(123,412,13,243)
myBarcode = .qrCode("adnjasndj")

/// 연관 값에 이름을 지어줄 수도 있다.
enum AppleProduct{
    case IPad(model: String, version: Double)
    case Mac(model: String, version: Double)
    case IPhone(model: String, version: String)
}
let a = [1,2,3,4,5]

/// switch문과 관련값을 이용해 보자.
switch myBarcode{
case let .upc(a,b,c,d):
    print("\(a) \(b) \(c) \(d)")
case .qrCode(let sentence):
    print("\(sentence)")
}

/*------------------------------------------*/

///- Raw Values
/// 스위프트도 C나 ObjC처럼 case 마다 Raw Values를 할당할 수 있다.
/// 각 케이스마다 raw Value는 유일해야한다.
/// 연관 값과 차이점은, 연관 값의 경우에는 사용자가 변경할 수 있는 반면에,
/// 원시 값은 고정되어 있다.
enum ASCIIControlCharacter: Character, CaseIterable{
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

/// 열거형의 원시 값이 Int타입이지만 각 케이스별로 원시 값이 할당되어 있지 않다면,
/// 스위프트는 자동으로 0부터 케이스에 원시 값을 할당한다.
/// venus = 2, earth = 3, mars = 4.....
enum PlanetOrder: Int{
    case mercury = 1,venus, earth, mars, jupiter, saturn, uranus, neptune
}

/// 열거형의 원시 값이 String타입이지만 각 케이스별로 원시 값이 할당되어 있지 않다면,
/// 스위프트는 자동으로 케이스명이랑 똑같은 문자열을 원시 값으로 할당한다.
enum CompassPoint: String {
    case north // = "north"
    case south // = "south"
    case east // = "east"
    case west // = "west"
}

let earthOrder = Planet.earth.rawValue // 3
var sunsetDirection = CompassPoint.east.rawValue // east

/// 다시 한번 말하지만, 열거형의 원시 값(Raw Value)는 변경할 수 없으며 각 케이스마다 구분되는 값이다.
/// 따라서 열거형 타입으로된 인스턴스를 생성할 때, 스위프트는 rawValue를 인자로 하는 생성자를 제공한다.
let uranus = PlanetOrder(rawValue: 7) // uranus
/// 위의 경우에서 만약 rawValue로 정의되지 않은 값이 넘어온다면, 해당 상수는 nil이 된다.
/// 따라서 rawValue를 인자로 하는 생성자로 열거형 인스턴스를 생성한다면 옵셔널을 반환한다.
/// 정리하자면, uranus의 값은 PlanetOrder.uranus이고, 타입은 PlanetOrder?이다.

/// 아래의 예를 통해 이해해보자.
let positionToFind = 11
if let somePlanet = PlanetOrder(rawValue: positionToFind){
    switch somePlanet{
    case .earth:
        print("mosly harmless")
    default:
        print("harmful")
    }
}else{
    print("No. There are no position you'd input")
}

/*------------------------------------------*/

/// - Recursive Enumerations
/// 재귀적 열거형은 어느 열거형의 케이스에 해당하는 연관 값이 또다른 열거형 인스턴스인 경우이다.
/// 이때 연관 값을 다른 열거형 인스턴스로 갖는 case 앞에 indirect 키워드를 붙혀줘야 한다.
enum ArithmeticExpression{
    case number(Int)
    indirect case addtion(ArithmeticExpression, ArithmeticExpression)
    indirect case mulityplication(ArithmeticExpression, ArithmeticExpression)
}

/// 혹은 enum 키워드 앞에 indirect를 붙여 모든 케이스에 붙힌 것과 같은 동일한 효과를 낼 수 있다.
indirect enum ArithmeticExpression{
    case number(Int)
    case addtion(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

/// (4 + 5) * 2 를 재귀적으로 표현해 보자.
let four = ArithmeticExpression.number(4)
let five = ArithmeticExpression.number(5)
let sum = ArithmeticExpression.addtion(four,five)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

/// 위를 계산하는 함수
func evaluate(_ expression: ArithmeticExpression) -> Int{
    switch expression{
    case let .number(value):
        return value
    case let .addtion(exp1, exp2):
        return evaluate(exp1) + evaluate(exp2)
    case let .multiplication(exp1, exp2):
        return evaluate(exp1) * evaluate(exp2)
    }
}

print(evaluate(product))
