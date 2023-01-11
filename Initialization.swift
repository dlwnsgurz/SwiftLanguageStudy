//
//  Initialization.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/10.
//

import Foundation

// - Topic: Initialization

/// - Setting Initial Values for Stored Properties
/// 생성자의 리턴값은 없다.
/// 클래스와 구조체 내의 모든 저장 프로퍼티는 인스턴스가 생성되기 전에 값이 존재해야한다.
/// 이를 위해 생성자내에서 값을 할당하던가, 저장 프로퍼티의 기본값이 할달 되어 있어야 한다.
/// 만약, 생성자를 통해 값을 할당하는 경우, 프로퍼티 감시자가 시행되지 않는다.
/// 또한, 만약 어떤 저장프로퍼티가 항상 일정한 기본값을 갖는 경우라면, 생성자를 통해
/// 초기화를 하기보다는 기본값을 미리 주는 것이 좋다.
/// 결과적으로는 같을 지라도, 가독성이 좋고(타입 추론), 이 후에 상속을 할 때 편할 수 있다.
/// 또한, 생성자는 메소드의 이름처럼 구분할 수 있는 것이 뚜렷하게 있지 않다, 따라서 매개변수 이름과 타입으로 구분한다.

/*------------------------------------------*/

/// - Customizing Initialization
/// 초기화 인자를 받아 초기화를 진행할 수 있다.
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius is 0.0

/// 생성자는 메소드와 다르게 인자의 타입과 인자들로만 구별될 수 있다.
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

/// 만약 직접 정의한 객체의 프로퍼티가 초기화시에 값이 할당될 수 없는 경우
/// 해당 프로퍼티를 옵셔널 타입으로 정의할 수 있다.
/// 옵셔널 타입으로 정의하고, 초기화시 값을 할당하지 않았다면
/// nil로 된다.
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// Prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."

/// 상수 프로퍼티는 초기화시 값을 넣어 할당해 줄 수 있다.
/// 서브 클래스에서 상위 클래스의 상수 프로퍼티 값 변경이 불가능하다.

/*------------------------------------------*/

/// - Default Initializer
/// 만약, 하나의 생성자도 정의되어 있지 않다면 자동으로 디폴트 생성자가 정의된다.
/// 모든 저장 프로퍼티의 기본 값이 정의되어 있어야한다.
class ShoppingListItem {
    var name: String? // nil이 된다.
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

/// 구조체는 하나의 생성자도 정의되어 있지 않다면 멤버와이즈 생성자로 추가로 제공한다.
/// 모든 프로퍼티를 인자로 할 수 있으며, 기본 값이 제공되어 있는 경우에는 심지어 생략도 할 수 있다.
struct Size {
    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 2.0)
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// Prints "0.0 0.0"

/*------------------------------------------*/

/// - Initializer Delegation for Value Types
/// 구조체와 열거형의 경우 상속을 제공하지 않는다.
/// 따라서 초기화 위임에 대해 신경쓰게 별로 없다.
/// 하지만, 클래스는 상속 기능이 있기때문에 초기화에 있어서 쉽지않다.
/// 구조체와 열거형의 경우 생성자내에서 다른 생성자를 호출하고자 한다면, self.init()을 호출하면 된다.
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {} // 기본 생성자로, Rect 인스턴스를 생성한다.
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size) // 초기화 위임
    }
}

/*------------------------------------------*/

/// - Class Inheritance and Initialization
/// 클래스내에서 초기자는 크게 2가지이다.
/// 첫번째는 지정 초기자로 프로프터를 초기화하는 역할을 한다. 즉 반드시 한 개 이상 존재해야 한다.
/// 두번째는 편의 초기자로 다른 지정 초기자를 호출하는 역할을 한다.
/// - Note : 지정 초기자는 반드시 상위 클래스의 지정 초기자를 호출해야하며, 편의 초기자는 반드시 동일 클래스의 지정 초기자를 호출해야한다.
///
/// 스위프트는 클래스의 초기화를 진행할 때, 2단계로 구분하여 진행한다.
/// 첫번째는 객체를 위한 메모리가 할당되고, 최상위 클래스에 도달할 때까지 동일 계층에 모든 프로퍼티가 하위 클래스부터 쭉 초기화 되어 올라간다.
/// 비로소 상위클래스의 모든 프로퍼티가 초기화되면 비로소 self.메소드, 프로퍼티 등이 호출 가능하다.
/// 두번째는 비로소 편의 초기자등이 self인스턴스에 접근이 가능해지면서 커스터마이징이 가능하다.

/// 이것을 보장하기위해 스위프트는 4단계 확인 절차를 걸친다.
///
/// 1. 지정 초기자를 실행하고 상위 클래스에게 초기화를 위임하기전에 모든 저장 프로퍼티가 초기화되어 있어야한다. (객체의 메모리는 모든 프로퍼티가 초기화되어야 유효하다)
/// 2. 상속받은 프로퍼티에 값을 할당하기전에 반드시 지정초기화로 상위 클래스의 지정 초기자를 호출해 초기화를 해야한다. (초기화를 하기전에 하위 클래스에서 상속받은 프로퍼티에 값을 할당할 수 없다.)
/// 3. 편의 초기자는 프로퍼티에 값을 할당하기전에 반드시 지정초기자를 호출해, 초기화를 진행해야한다.
/// 4. 이니셜라이저는 모든 프로퍼티가 초기화 되기 전까지는 self의 메소드, 프로퍼티등에 접근이 불가능하다.
///
/// 상위 클래스의 편의 초기자는 하위 클래스에서 호출될 수 없다. 따라서 하위클래스에서 상위 클래스의 초기자는 override를 붙이지 않아도 된다.
/// 반대로, 상위 클래스의 지정 초기자는 하위 클래스의 편의 초기자로 오버라이드가 가능하다.
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
    init(){
        print("Vehicle init")
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

/// 만약 초기자 프로세스 2단계(프로퍼티 커스터마이징)을 수행하지 않는다면, 상위 클래스의 초기자 호출을 생략해도 된다.
class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        print("color assingn")
        self.color += "green"
        print("color changed")
        super.init()
        super.numberOfWheels = 4
        // super.init() implicitly called here
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

let hover = Hoverboard(color: "red")

/// 추가적으로, 상위 클래스는 하위 클래스에게 초기자를 상속해주지 않는다.
/// 만약 하위 클래스에 있는 프로퍼티가 기본 값이 있을 경우, 아래의 2가지 규칙이 적용된다.
/// 1. 만약 하위 클래스에서 지정 초기자가 정의되지 않는다면, 상위 클래스의 지정 초기자가 상속된다.
/// 2. 만약 상위 클래스의 지정 초기자를 모두 오버라이드로(편의 초기자로도 OK, 상속도 OK) 구현햇다면, 상위 클래스의 편의 초기자가 자동 상속된다.
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

/*------------------------------------------*/

/// - Failable Initializers
/// 실패가능한 이니셜라이저도 정의할 수 있다.
/// init뒤애 ?를 붙여 init?(parameter)로 정의한다. 실패가능한 초기자와 초기자를 동시에 정의할 수 없다.
/// 실패가능한 초기자는 nil을 return 하도록 정의하면된다. 그렇다고 해서 그냥 초기자가 return 값이 있는 것은 아니다.
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// Prints "12345.0 conversion to Int maintains value of 12345"

let valueChanged = Int(exactly: pi)
// valueChanged is of type Int?, not Int

if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value")
}
// Prints "3.14159 conversion to Int doesn't maintain value"

/// 구조체의 경우 다음과 같이 실패가능한 이니셜라이저를 활용할 수 있다.
struct Animal{
    let species: String
    init?(species: String){
        if species.isEmpty{ return nil}
        self.species = species
    }
}

/// 열거형의 경우 다음과 같이 실패가능한 이니셜라이저를 활용할 수 있다.
enum Temperature{
    case kelvin, celsius, fahrenheit
    init?(symbol: Character){
        switch symbol{
        case "K": self = .kelvin
        case "C": self = .celsius
        case "F": self = .fahrenheit
        default:
            return nil
        }
    }
}

/// 열거형에서는 rawValue로 열거형 인스턴스를 열거형? 타입으로 생성할 수 있다.
/// 따라서 위의 열거체를 단순화해서 다음과 같이 정의할 수 있다.
enum TemperatureUnit: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

/// 구조체, 열거형, 클래스에서 실패가능한 이니셜라이저는 실패가능한 이니셜라이저에게 초기화를 위임할 수 있으며,
/// 실패 가능한 이니셜라이저는 실패 가능하지 않은 이니셜라이저에게도 위임할 수 있다.
/// 이 과정에서 만약 nil을 return 한다면, 그 즉시 초기화가 중단된다.
class Product{
    let name: String
    init?(name: String){
        if name.isEmpty{ return nil}
        self.name = name
    }
}

class CartItem: Product{
    let quantity: Int
    init?(name: String, quantity: Int){
        if quantity < 1 { return nil}
        self.quantity = quantity
        super.init(name: name)
    }
}

/// 상위 클래스의 실패 가능한 초기자를 하위 클래스에서 일반 초기자로 오버라이딩 할 수 있다.
/// 하지만, 그 반대는 성립히지 않는다.
class Document{
    var name: String?
    
    init(){}
    init?(name: String){
        if name.isEmpty{ return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document{
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String){
        super.init()
        if name.isEmpty{
            self.name = "[Untitled]"
        }else{
            self.name = name
        }
    }
}

/// 상위 클래스의 실패가능한 초기자를 하위클래스에서 실패하지 않는 초기자로 오버라이드 했을떄
/// init!() 을 호출해 옵셔널 타입으로 인스턴스가 생성되지 않도록 할 수 있다.
class UntitledDocument: Document{
    override init(){
        super.init(name: "[Untitled]")!
    }
}

/// 암시적 추출 옵셔널 처럼 init!() 초기자를 정의할 수 있다.
/// init?을 init!에 위임하거나, 그 반대도 가능하다.
/// 또한 init? 초기자를 init! 초기자로 오버라이딩 할 수 있으며, 그 반대도 가능하다.
/// 또한, init이 init!으로 초기호를 위임할 수도 있다.

/*------------------------------------------*/

/// - Required Initializers
/// 서브 클래스에서 구현해야 하는 상위 클래스의 이니셜라이저를 정의할 때 required 키워드를 붙이면 된다.
/// 서브 클래스에서는 그 이니셜라이저를 구현할 때 override 키워드를 붙힐 필요 없이 required 키워드만 붙이면 된다.
/// 그렇다고 해서 꼭 구현해야 된다는 것은 아니다.
class SomeClass{
    required init() {}
}

class SomeSubClass: SomeClass{
    
}

/*------------------------------------------*/

/// - Setting a Default Property Value with a Closure or Function
/// 클로저를 통해 프로퍼티의 기본 값을 할당할 수 있다.
/// 이때 클로저의 return 값이 프로퍼티의 기본 값으로 할당된다.
/// 클로저의 {} 뒤에 ()는 그 즉시 실행을 의미하기때문에, 다른 프로퍼티들이 초기화 되기전에 클로저가 실행된다.
/// 따라서, 클로저 내부에서 인스턴스의 프로퍼타와 메소드에 접근이 불가능하다.
/// 즉, self 키워드를 사용할 수 없다.

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }() // ()는 즉시 실행을 의미, 만약 생략한다면 클로저 자체가 프로퍼티가 되고 return 값이 의미 없어진다.
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
