//
//  Automatic Reference Counting.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/17.
//

import Foundation

// - Toplic: Automatic Reference Counting

/// 스위프트는 앱의 메모리 사용량을 추적하기위해 ARC (자동 참조 카운팅)를 사용한다.
/// 일반적으로 코더는 ARC에 대해 신경쓸 필요가 없지만,
/// 종종 ARC가 코드에 추가정보를 요구할 때가 있다.
/// 이번 챕터에서는 그 부분에 대해 알아본다.


/// - How ARC Works
/// 클래스의 인스턴스를 생성할 때마다 ARC는 메모리를 할당한다.
/// 이 메모리는 인스턴스의 타입에 대한 정보와, 저장 프로퍼티에 대한 정보를 가지고 있다.
/// 그 후, 인스턴스가 더이상 사용되지 않을 때 ARC는 메모리를 해제해 메모리 공간을 확보한다.
/// 그러나, 여전히 사용되는 인스턴스를 할당 해제한다면 우리는 그 인스턴스의 프로퍼터와 메소드에 접근할 수 없다.
/// ARC는 인스턴스가 사라지지 않도록 많은 양의 프로퍼티, 변수, 상수가 클래스의 인스턴스에 참조되고 있는지 추적한다.
/// 만약, 클래스의 인스턴스에 참조가 하나라도 존재한다면 ARC는 인스턴스를 할당 해제하지 않는다.
/// 이를 위해 프로퍼티, 변수, 상수에 클래스의 인스턴스를 할당할 떄 강한참조를 하게 만들어 할당 해제를 막는다.

/*------------------------------------------*/

class Person{
    let name: String
    init(name: String){
        self.name = name
        print("\(name) is being initialized")
    }
    deinit{
        print("\(name) is being deinitialized")
    }
    
}

/// 아래 3개의 변수에는 nil이 할당되어 있으며, 아무것도 참조하지 않는 상태이다.
var reference1: Person?
var reference2: Person?
var reference3: Person?

/// 한 개의 강한 참조가 생성된다.
reference1 = Person(name: "John Appleseed")
// Prints "John Appleseed is being initialized"

/// 총 3개의 강한 참조가 생성되어있다.
reference2 = reference1
reference3 = reference1

/// 처음 할당한 인스턴스를 포함해, 변수가 참조하고 있는 인스턴스에 nil을 할당하였지만,
/// ARC는 해당 인스턴스의 메모리 할당을 해제하지 않는다.
/// 왜냐하면, 아직 1개의 강한 참조가 남아있기 때문이다.
reference1 = nil
reference2 = nil

/// 마지막 남은 인스턴스의 강한참조가 사라졌기때문에 해당 인스턴스에 대한 메모리 할당 해제가 이루어진다.
reference3 = nil

/*------------------------------------------*/

/// - Strong Reference Cycles Between Class Instances
/// 클래스의 인스턴스가 강한 참조가 없는 지점에 도착하지 않는 경우가 있다.
/// 이 경우에 강한 참조가 없어지지 않기때문에, ARC가 메모리 할당 해제를 하지않는다.
/// 따라서, 메모리 누수가 발생한다. 이를 강한 참조 사이클이라고 한다.
/// Person 클래스의 apartment 프로퍼티는 자가 소유가 없을 수도 있으므로 옵셔널이고
/// Apartmet 클래스의 tenent 프로퍼티는 소유주가 없을 수도 있으므로 옵셔널이다.
class Person{
    let name: String
    var apartment: Apartment?
    init(name: String){
        self.name = name
        print("\(name) is being initialized")
    }
    deinit{
        print("\(name) is being deinitialized")
    }
    
}

class Apartment{
    let unit: String
    var tenent: Person?
    init(unit: String){
        self.unit = unit
        print("\(unit) apartment is being initialized")
    }
    
    deinit{
        print("\(unit) apartment is being deinitialized")
    }
}

/// 강한 참조 2개가 발생.
/// 각각 Person 인스턴스와, Apartment 인스턴스의 참조를 가지고 있다.
var john: Person? = Person("john")
var apartment: Apartment? = Apartment("house")

/// 강한 참조 2개가 추가로 발생
john?.apartment = apartment
apartment?.tenent = john

/// 클래스 인스턴스에 대해 강한 참조가 아직 존재해(강한 참조 사이클)
/// 메모리 할당 해제가 되지 않는다.
/// 메모리 할당 해제를 하고 싶다면, 그 인스턴스를 참조하고 있으면 안된다.
john = nil
apartment = nil

/*------------------------------------------*/

/// - Resolving Strong Reference Cycles Between Class Instances
/// 스위프트는 클래스의 인스턴스 사이의 강한 참조 사이클을 해결하기 위해 2가지 방법을 제공한다.
/// 약한 참조와, 미소유 참조이다.

/// 먼저 약한 참조부터 확인해보자.
/// 약한 참조는 강한 참조를 만들지 않는다. 따라서 클래스의 인스턴스의 한 프로퍼티가 약한 참조 프로퍼티인 경우에,
/// 클래스의 인스턴스 할당 해제를 시도 한다면 해당 인스턴스가 갖고 있는 약한 참조도 ARC에 의해 nil로 바뀐다.
/// 따라서, weak 키워드와 함께 옵셔널 변수로 선언해야한다.
/// 약한 참조 프로퍼티에 감시자가 붙어 있는 경우, 약한 참조 프로퍼티가 nil로 되어도 프로퍼티 감시자는 호출되지 않는다.
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

/// 강한 참조 2개 생성.
/// 각각 Person 인스턴스, Apartment 인스턴스를 참조
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

/// Person 인스턴스는 Apartment 인스턴스의 프로퍼티에 대해 강한 참조를 한다.
/// Apartment 인스턴스는 Person 인스턴스의 프로퍼티에 대해 약한 참조를 한다.
john!.apartment = unit4A
unit4A!.tenant = john

/// Person 인스턴스의 프로퍼티에 강한 참조를 하고 있지 않으므로 메모리 할당 해제.
john = nil
// Prints "John Appleseed is being deinitialized"

/// Aoartment 인스턴스 자체에 대한 강한 참조만 남으므로, 메모리 할당 해제.
unit4A = nil
// Prints "Apartment 4A is being deinitialized"

/// 강한 참조 사이클을 만들지 않기 위해 사용할 수 있는 두 번쨰 방법은
/// 미소유 참조이다. 약한 참조와의 차이점은 미소유 참조는 항상 값이 존재할 것이라고 가정한다는 점이다.
/// 아래의 두 클래스는 Customer와, CreditCard이다.
/// 이 두 클래스의 관계는 위 두클래스의 관계와 다르다.
/// CreditCard의 경우 항상, Customer를 가지고 있어야한다. 즉 옵셔널이 아니어야 한다.
/// 하지만, Customer는 CreditCard를 갖고 있을 수 있고 갖고 있지 않을 수 있다.
/// 또한, CreditCard 인스턴스 생성시에 카드번호와 Customer의 인스턴스가 항상 필요하다.
/// unowned 프로퍼티는 weak 프로퍼티와 다르게 옵셔널이면 안된다.
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

/// john을 할당 해제를 시도한다면, john을 강함 참조하고 있는 게 아무 것도 없다.
/// 따라서 메모리 해제가된다. 그러면 john이 가지고 있는 모든 참조가 사라지므로 CreditCard 인스턴스도 메모리해제된다.
var john: Customer?
john = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
// Prints "John Appleseed is being deinitialized"
// Prints "Card #1234567890123456 is being deinitialized"

/// - Note: 위의 예시는 안전한 미소유 참조에 대한 예시이다.
/// 성능 상의 이유로 안전하지 않은 미소유 참조를 하고자 한다면, unowned(unsafe)를 사용해 성능을 높힐 수 있지만,
/// 런타임에러에 대한 처리를 해주어야 한다.
/// unowned 참조의 경우 일반적으로 nil로 되지 않기때문에 해당 인스턴스에 접근하지 않도록 주의해야한다. (이미 메모리는 해제되었기 때문이다.)

/// unowned 참조타입을 옵셔널타입으로 할 수 있다.
/// 이 경우, nil이 가능하다는 것만 뺀다면 unowned랑 똑같다.
///
class Department{
    var name: String
    var courses: [Course]
    init(name: String){
        self.name = name
        self.courses = []
    }
}

class Course{
    let name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, department: Department){
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

let department = Department(name: "Horticulture")

let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]

/// 위에서는 강한 참조 사이클을 해결할 수 있는 두 가지 방법에 대해 알아보았다.
/// 첫번째는 weak 참조로, 두 인스턴스의 프로퍼티가 둘 다 nil이 될 수 있는 참조를 할 경우 사용한다.
/// 두번째는 unowned 참조로, 두 인스턴스의 프로퍼티중 하나만 nil이 될 수 있는 경우에 주로 사용한다.
/// 마지막으로 아래에서 소개할 세 번째는, 두 프로퍼티 모두 nil이 아닌 경우로 암시적 옵셔널 언래핑을 이용한다.
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
    deinit{
        print("country destroyed")
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
    deinit{
        print("city destroyed")
    }
}
/// 위의 코드를 천천히 살펴보자.
/// Country 인스턴스의 경우, 반드시 수도를 하나 가져야한다.
/// 마찬가지로, City 인스턴스도 반드시 국가에 속해있어야 하므로 국가프로퍼티를 가져야한다.
/// 즉, 두 인스턴스가 nil이 아닌 프로퍼티를 갖는 것이 확실하므로 암시적 옵셔널로 이를 해결할 수 있다.
/// Country 인스턴스를 생성할 때 초기자의 인자로, Country의 이름과 수도의 이름을 인자로 받는다.
/// 이후 이름을 설정한 뒤, 수도의 이름은 암시적 옵셔널이므로 자동으로 nil이 할당되 자신의 인스턴스 키워드인 self를 전달이 가능해진다. (모든 저장 프로퍼티가 기본 값을 가지므로..)
/// 이렇게 하면 두 클래스의 인스턴스 생성을 한 문장으로 가능해지며, 옵셔널 체이닝도 없고, 강한 참조 사이클도 발생하지 않는다.

var country: Country? = Country(name: "Canada", capitalName: "Ottawa")
print("\(country!.name)'s capital city is called \(country!.capitalCity.name)")
country = nil
// country destroyed
// city destroyed

/*------------------------------------------*/

/// - Strong Reference Cycles for Closures
/// 클로저에 의해 강한 참조 사이클이 발생할 수도 있다.
/// 인스턴스의 프로퍼티가 클로저이고, 그 클로저가 self.someProperty, self.someMethod()와 같이 자신 인스턴스를 참조하고 있다면,
/// 강한 참조 사이클이 발생한다.
/// 왜냐하면, 클로저도 참조 타입이기 때문이다.
/// 아래의 클래스는 HTML 태그 요소내에 텍스트를 가질 수 있는 클래스이다.
/// html을 렌더링하는 asHTML 지연  프로퍼티는 클로져로 선언되었다.
/// 지연 프로퍼티로 선언한 이유는 클로저의 바디내에 self는 초기화가 완료된 인스턴스에서만 호춣이 가능하기때문이며,
/// 클로저를 갖는 이유는, 특정 HTML 태그 요소에 대해 다른 String을 return할 수 있도록 하기때문이다.
class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

/// 아래의 코드의 경우 h1 태그에 대해 렌더링을 다른 메시지로 할 수 있도록
/// 프로퍼티의 return 값을 수정하는 코드이다.
let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// Prints "<h1>some default text</h1>"

/// paragraph 변수의 경우, 자기 자신의 프로퍼티인 클로저와 강한 참조 사이클을 갖고 있다.
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"

/// 강한 참조 사이클을 가지고 있기때문에 클로저와 클래스 인스턴스 모두 메모리 할당이 해제되지 않는다.
paragraph = nil

/*------------------------------------------*/

/// - Resolving Strong Reference Cycles for Closures
/// 두 클래스의 인스턴스간의 강한 참조 사이클을 해결하였듯이,
/// 클로저의 바디내에서 캡쳐 리스트를 작성해, 약한 참조 혹은 미소유 참조를 명시할 수 있다.
/// - Note: 스위프트의 클로저의 바디에서는 self를 명시하도록 하는데, 이는 프로그래머의 의도와 다르게
/// 강한 참조 사이클이 발생하지 않도록 배려하기 위한 것이다.
/// 클로저의 캡쳐 리스트는 다음과 같이 정의할 수 있다.
lazy var someClosure = {
    [unowned self, weak delegate = self.delegate]
    (index: Int, stringToProcess: String) -> String in
    // closure body...
}

/// 만약 인자 타입을 추론할 수 있다면..
lazy var anotherClosure = {
    [unowned self, weak delegate = self.delegate] in
    // closure body...
}

/// 위의 약한 참조와 미소유 참조를 구분하였듯이,
/// 클로저 내의 참조하는 인스턴스가 nil이 될 수 있으면, 약한 참조를..
/// nil이 될 수 없다면(즉, 할당 해지 되기 전에 nil이 될 가능성이 있다면..) 미소유 참조로 정의한다.
class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"

/// 강한 참조 사이클이 없기때문에 메모리 할당 해제가 성공한다.
paragraph = nil
// Prints "p is being deinitialized"

