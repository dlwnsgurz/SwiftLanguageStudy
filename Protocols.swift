//
//  Protocols.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/13.
//

import Foundation

// - Topic: Protocols
/// 프로토콜은 구조체, 클래스, 열거형에 구현해야 하는 청사진을 제공한다.
/// 프로토콜을 준수하는 타입들은 프로토콜에 의해 프로퍼티, 메소드, 일부 작업들을 반드시 구현해야한다.
/// 또한 프로토콜 확장을 통해 이미 프로토콜을 준수하는 타입에 대해 추가 구현을 요구할 수도 있다.

/*------------------------------------------*/

/// - Protocol Syntax
/// protocol 키워드를 통해 정의할 수 있으며 클래스, 열거형, 구조체와 비슷하게 정의한다.
protocol SomeProtocol{
    // ...
}

/// 여러개의 프로토콜을 준수할 수 있다.
class SomeClass: SomeProtocol, AnotherProtocol{
    
}

/// 클래스의 상속과 동시에 이루어지는 경우, 클래스 명을 먼저 쓴다.
class SomeSubClass: SomeSuperClass, SomeProtocol

/*------------------------------------------*/

/// - Property Requirements
/// 프로토콜에서 프로퍼티 요구는 오로지 이름과 타입에만 의존한다.
/// 요구한 각 프로퍼티에 대해 gettable, settable을 정의할 수 있다.
/// 읽기 - 쓰기 프로퍼티를 요구한 경우, 프로토콜을 따르는 타입은
/// 상수 저장 프로퍼티나, 읽기 전용 연산 프로퍼티로는 정의할 수 없다.
/// 읽기 프로퍼티를 요구한 경우, 모든 종류의 프로퍼티를 정의할 수 있다.
protocol SomeProtocol{
    var mustBeSettable: Int {get set}
    var doseNotNeedToBeSettable: Int { get }
    
}
/// 또한 타입 프로퍼티 구현을 요구할 수 있다.
/// 프로토콜에는 static 프로퍼티만 요구할 수 있으며, 이를 구현하는 클래스에서 class 키워드를 사용할 수 있다.
protocol AnotherProtocol{
    static var someTypeProperty: Int { get set }
}

/// 아래의 프로토콜은 이 프로토콜을 따르는 타입이 반드시
/// fullName이름을 갖는 String 타입의 프로퍼티를 구현해야함을 의미한다.
/// 또한 읽기 전용으로 구현해야한다.
protocol FullNamed{
    var fullName: String { get }
}

struct Person: FullNamed{
    var fullName: String

}

var john = Person(fullName: "john Appleseed")
john.fullName = "h"

class StarShip: FullNamed{
    var prefix: String?
    var name: String
    
    var fullName: String{
        return (prefix != nil) ? name + " " + prefix! : name
    }
    init(name: String, prefix: String? = nil){
        self.name = name
        self.prefix = prefix
    }
}

var ncc1701 = StarShip(name: "ENTERPRISE",prefix: "UCC")
print(ncc1701.fullName)

/*------------------------------------------*/

/// - Method Requirements
/// 프로토콜에서는 인스턴스메소드 ,타입 메소드를 요구할 수 있다.
/// 메소드의 body는 정의할 필요 없다.
/// 타입 메소드의 경우 클래스는 class 키워드를 이용할 수 있다.
/// 프로토콜을 따르는 타입에서는 메소드를 구현할 때, 가변 매개변수를 사용할 수 있다.
/// 요구된 메소드를 구현할 때는 프로토콜의 메소드 정의와 완전히 같아야한다.(매개변수이름, 매개변수타입, 인자레이블)
protocol SomeProtocol{
    static func someTypeMethod()
}

protocol RandomNumberGenerator{
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"

/*------------------------------------------*/

/// - Mutating Method Requirements
/// 프로토콜 내에서 mutating 메소드를 요구할 수 있다.
/// mutating 키워드를 func 앞에 붙여 사용하며, 구조체나 열거형은 mutating 키워드를 붙힌 채로 메소드를 구현할 수 있다.
/// 클래스의 경우에는 mutating 키워드를 붙힐 필요 없다.
protocol Togglable{
    
    mutating func toggle()
    init()
}

enum OnOffSwitch: Togglable{
    case on, off
    
    mutating func toggle() {
        switch self{
            case .on: self = .off
            case .off: self = .on
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on

/*------------------------------------------*/

/// - Initializer Requirements
/// 프르토콜에 이니셜라이저를 선언해 클래스가 이를 구현하도록 요구할 수 있다.
/// 프로토콜을 따르는 클래스는 반드시 앞에 required 키워드를 붙여야하며,
/// 그 클래스의 서브 클래스도 반드시 붙여 구현해야 한다.
/// 클래스에서는 프로토콜의 이니셜라이저를 편의 이니셜라이저로도 구현할 수 있다.
/// final 클래스의 경우에는 required 키워드를 붙힐 필요 없다.
protocol SomeProtocol{
    init()
}

class SomeClass: SomeProtocol{
    required init(){
        
    }
}

/// 만약 프로토콜과 상위 클래스의 동일한 이니셜라이저를 제공해야 한다면,
/// required와 override 키워드를 함께 사용해 구현한다.
class SomeSubClass: SomeProtocol, SomeClass{
    required override init(){
        
    }
}

/// 또한, 프로토콜은 실패 가능한 이니셜라이저의 구현을 요청할 수 있다.
/// 이를 구현하는 일반 이니셜라이저로 구현할 수도 있으며, 아니면 암시적 언래핑된 실패가능한 이니셜라이저로 구현한다.
protocol AS{
    init?()
}

class asas: AS{
    required init(){}
}

/*------------------------------------------*/

/// - Protocols as Types
/// 프로토콜도 타입처럼 취급될 수 있다.
/// 이때 "타입 T가 프로토콜을 따른다" 라는 것의 타입으로 생각하는 것이 좋다.
/// 예를 들어 Int 타입이 프로토콜 P를 구현할 떄, Int 타입을 "프로토콜 P를 따르는 타입" 이라고 생각하자.
/// Dice의 generator 프로퍼티는 RandomNumberGenerator 타입이다.
/// 이는 generator 프로퍼티에는 RandomNumberGenerator 프로토콜을 따르는 모든 타입이 올 수 있다.
/// roll() 메소드에서는 generator 프로퍼티의 random() 메소드를 호출했다.
class Dice{
    var side: Int
    let generator: RandomNumberGenerator
    
    init(side: Int, generator: RandomNumberGenerator){
        self.side = side
        self.generator = generator
    }
    
    func roll() -> Int{
        return Int(generator.random() * Double(side)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}
// Random dice roll is 3
// Random dice roll is 5
// Random dice roll is 4
// Random dice roll is 5
// Random dice roll is 4

/*------------------------------------------*/

/// - Delegation
/// 델리게이션 디자인 패턴은 클래스나 구조체의 책임 일부를 다른 타입의 인스턴스에게 넘기는 것을 의미한다.
/// 생략..

/*------------------------------------------*/

/// - Adding Protocol Conformance with an Extension
/// 이미 존재하는 타입에 프로토콜을 준수하게 하고 extension을 통해
/// 그 프로토콜이 요구하는 기능을 추가할 수 있다.
/// 이미 존재하는 그 타입의 인스턴스는 확장 기능을 만족하게 된다.
protocol TextRepresentable{
    var textualDescription: String { get }
}

extension Dice : TextRepresentable{
    var textualDescription: String{
        return "A \(side) - sided dice"
    }
}
/// Dice 타입의 인스턴스는 textualDescription 프로퍼티에 접근할 수 있다.
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
// Prints "A 12-sided dice"

/// 조건에 따라 프로토콜을 준수하도록 extension을 활용할 수 있다.
/// 아래의 코드는 배열에 TextRepresentable 프로토콜을 따르는 원소가 저장될 때마다 배열이 TextRepresentable 프로토콜을 따른다.
extension Array: TextRepresentable where Element: TextRepresentable{
    var textualDescription: String{
        let itemAsText = self.map{ $0.textualDescription }
        return "[" + itemAsText.joined(separator: ", ") + "]"
    }
}

let myDice = [d6, d12]
print(myDice.textualDescription)
// Prints "[A 6-sided dice, A 12-sided dice]"

/// 만약, 어떤 타입이 프로토콜의 요구 사항을 이미 만족시켰을떄
/// 빈 extension을 통해 그 타입이 프로토콜을 따르도록 할 수 있다.
struct Hammer{
    var name: String
    var textualDescription: String{
        return "Hammer name: " + self.name
    }
}

extension Hammer: TextRepresentable{} // Hammer가 TextRepresentable 프로토콜을 따른다.

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// Prints "A hamster named Simon"

/// - Adopting a Protocol Using a Synthesized Implementation
/// 스위프트의 기본 타입은 Equatable, Hashable, Comaparable 프로토콜을 따른다.
/// Equatable 프로토콜은 ==, != 연산자에 대한 합성된 구현을 제공한다.
/// 스위프트는 다음 3가지에 대해 자동으로 합성된 Equatable 구현을 제공한다. 따라서 Equatable 구현을 할 필요가 없다.
/// 1. Equatable 프로토콜을 준수하는 저장된 프로퍼티만 있는 구조체.
/// 2. Equatable 프로토콜을 준수하는 연관값을 가지는 열거형
/// 3. 연관된 값이 없는 열거형
struct Vector3D: Equatable{
    var x = 0.0, y = 0.0, z = 0.0
    init(x: Double, y: Double, z: Double){
        self.x = x; self.y = y; self.z = z
    }
    func print(){
        
    }
}


let vector1 = Vector3D(x: 1, y: 2, z: 3)
let vector2 = Vector3D(x: 1, y: 2, z: 3)
print(vector1 == vector2) // 저장된 프로퍼티가 모두 Equatable 프로토콜을 준수하므로, 자동 제공된다.

/// Hashable 프로토콜을 따르려면 hash(int:) 메소드를 구현해야 한다.
/// 하지만, 스위프트는 다음 3가지의 경우에 대해 자동으로 합성된 구현을 제공한다.
/// 따라서, 사용자 정의 타입이 다음 조건을 만족하면 Hashable 프로토콜의 요구를 직접 구현할 필요 없다.
/// 1. Hashable 프로토콜을 준수하는 저장된 프로퍼티만 있는 구조체
/// 2. Hashable 프로토콜을 준수하는 연관 값을 가지는 열거형
/// 3. 연관된 값이 없는 열거형

/// Comparable 프로토콜을 따르려면 비교 연산자에 대한 구현을 해야한다.
/// 하지만 스위프트는 다음의 경우에 대해 자동으로 비교 연산자에 대한 합성된 구현을 제공한다.
/// 따라서, 사용자 정의 타입이 다음 조건을 만족하면 Hashable 프로토콜의 요구를 직접 구현할 필요 없다.
/// 원시 값을 가지지 않는 열거형의 경우 Comparable 프로토콜에 대한 합성된 구현을 제공하며,
/// 만약 연관 값이 있는 경우 그 연관 타입은 Comparable 프로토콜을 따라야 한다.
/// - Note: 열거형은 case 나열 순서가 우선으로 비교된다.
enum SkillLevels: Comparable{
    case beginner
    case intermediate
    case expert(stars: Int)
    
}

var levels = [SkillLevels.beginner, SkillLevels.intermediate, SkillLevels.beginner, SkillLevels.expert(stars: 3), SkillLevels.expert(stars: 5)]

for level in levels.sorted(){
    print(level)
}

/*------------------------------------------*/

/// - Collections of Protocol Types
/// 프로토콜 타입을 따르는 타입들로 이루어진 Collection을 사용할 수 있다.
/// 배열, 딕셔너리, 집합 등이 가능하다.
/// 아래의 경우, 루프내의 상수들이 사실 Dice, game 등의 타입이여도 프로토콜이 요구한 기능에 대해서만 접근할 수 있다.
/// 왜냐하면 배열 타입이 Protocol 타입이기 때문이다.
var things : [TextRepresentable] = [d12,simonTheHamster]
for thing in things{
    print("\(thing.textualDescription)")
}

/*------------------------------------------*/

/// - Protocol Inheritance
/// 프로토콜은 하나 이상의 프로토콜을 상속 받을 수 있으며
/// 상속을 받은 뒤 기능을 더 추가할 수도 있다.
protocol InheritingProtocol: SomeProtocol, AnotherProtocol{
    
}

protocol PrettyTextRepresentable: TextRepresentable{
    var prettyTextualDescription: String { get }
}

/// 다음과 같이 extension을 해 PrettyTextualDescription 프로토콜의 기능을 구현할 수 있다.
/// 이 때 TextRepresentable 프로토콜이 요구하는 textualDescription 프로퍼티도 접근을 하는데
/// 이는  PrettyTextualDescription 프로토콜을 따르면 반드시 TextRepresentable 프로토콜을 따르기 때문이다.
extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

/*------------------------------------------*/

/// - Class-Only Protocols
/// 만약, 클래스만 따를 수 있는 프로토콜을 정의하고 싶으면 프로토콜이 AnyObject를 상속하면 된다.
/// 만약 이 프로토콜을 열거형이나 구조체가 따르고자 한다면, 컴파일 에러가 발생한다.
/// 이 방법은 주로 참조 타입 방식이 필요할 때 사용한다.
/// 아래의 프로토콜은 클래스 타입만 따를 수 있다.
protocol SomeClassProtocol: AnyObject{
    
}

/*------------------------------------------*/

/// - Protocol Composition
/// 어떤 타입이 여러 개의 프로토콜을 따르도록 하는 것이 유용할 수 있다.
/// 어떤 타입이 여러 개의 프로토콜을 모두 만족한다면 & 연산자를 통해 이를 표현할 수 있다.
/// 프로토콜 개수에 대한 제한도 없다. 하지만, 슈퍼 클래스의 경우 하나만 가능하다.
/// 하지만, 이는 새로운 프로토콜을 생성하는 것은 아니다.
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
// 이 함수의 인자는 Named 프로토콜과 Aged 프로토콜 모두를 따라야 한다.
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// Prints "Happy birthday, Malcolm, you're 21!"

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
// 이 함수의 인자는 Location 클래스의 서브 클래스이며, Named 프로토콜을 따라야 한다.
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
// Prints "Hello, Seattle!"

/*------------------------------------------*/

/// - Checking for Protocol Conformance
/// 타입 캐스트 문법과 마찬가지로 is와 as로 프로토콜에 대한 타입을 검사할 수 있다.
/// is의 경우에 해당 타입이 protocol을 따를 시 return true, 따르지 않는다면 return false
/// as는 다운 캐스팅 연산자로, as?는 protocol을 따를 시 옵셔널로 된 프로토콜 타입을, 따르지 않는다면 nil을 return
/// as!는 protocol을 따를 시 프로토콜 타입으로, 따르지 않는다면 런타임 에러를 발생시킨다.
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal{
    var legs: Int
    init(legs: Int){
        self.legs = legs
    }
}
// objects 배열의 원소는 동일한 프로토콜을 모두 따르지 않으므로 프로토콜 배열이 될 수 없다.
// 하지만, 모두 클래스 타입이므로 AnyObject 배열이 될 수 있다.
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

/// 루프에서 HasAre 프로토콜을 따르는 배열의 원소는 HasArea 타입으로
/// ojbectWithArea 상수에 저장된다.
/// 따라서 area 프로퍼티에만 접근이 가능하다.
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
// Area is 12.5663708
// Area is 243610.0
// Something that doesn't have an area

/*------------------------------------------*/

/// - Optional Protocol Requirements
/// 스위프트에서는 옵셔널 프로토콜도 정의가 가능하다.
/// 옵셔널 프로토콜은 ObjC와 상호 운용 하므로, 프로토콜 이름 앞에 @objc가 붙어야 한다.
/// 또한 요구 사항 앞에서 모두 @objc가 붙어야 한다.
/// 옵셔널 프로토콜은 NSObject 프로토콜을 따르는 클래스만 따를 수 있다.
/// 또한, 이 클래스는 해당 프로토콜을 따른다고 해서 구현할 필요는 없다.
/// 또한, 이 프로토콜의 요구 사항들은 모두 옵셔널로 래핑 된다.
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int // ((Int) -> Int)?
    @objc optional var fixedIncrement: Int { get } // Int?
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

// NSObject(@objc 클래스)를 상속하고, 옵셔널 프로토콜을 상속하는 클래스.
class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
// 3
// 6
// 9
// 12


class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
// -3
// -2
// -1
// 0
// 0

/*------------------------------------------*/

/// - Protocol Extensions
/// 프로토콜 확장인 그 프로토콜을 따르는 모든 타입에 기능을 구현해줄 수 있다.
/// 메소드, 서브스크립트, 연산 프로퍼티, 초기자를 추가할 수 있다.
/// RandomNumberGenerator 프로퍼티를 따르는 모든 타입에 randomBool()를 추가한다.
/// 따라서 이 프로토콜을 따르는 모든 타입에서 randomBool()를 호출할 수 있다.
/// extension으로 프토토콜에 요구 사항을 추가하거나, 다른 프로토콜을 상속하도록 할 수 없다.
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And here's a random Boolean: \(generator.randomBool())")
// Prints "And here's a random Boolean: true"

/// 프로토콜 확장은 그 프로토콜을 따르는 타입에 기본 구현을 제공할 수 있다.
/// 아래의 경우, PrettyTextRepresentable 프로토콜을 따르는 타입에 prettyTextualDescription 프로퍼티가 기본 구현된다.
/// 만약, 그 프로토콜을 따르는 타입에 이 프로퍼티가 구현되어 있다면, 아무일도 일어나지 않는다.
extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

/// 프로토콜 확장은 조건에 따라 프로토콜을 따르는 타입에, 여러 기능의 기본 구현을 제공할 수 있다
/// 아래의 경우 Collection의 모든 원소가 Equatable 프로토콜을 따르는 경우에만 allEqual()메소드를 사용할 수 있다.
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}
// 둘다 [Integer] 타입이고, 각 원소가 Int로 Equatable 프로토콜을 따르기 때문에,
// [Integer] 타입은 allEqual() 메소드를 기본 제공 받는다.
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]

print(equalNumbers.allEqual())
// Prints "true"
print(differentNumbers.allEqual())
// Prints "false"
