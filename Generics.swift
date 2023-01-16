//
//  Generics.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/16.
//

import Foundation

// - Topic: Generics
/// 제네릭 코드는 재사용성이 높고, 유연하여 스위프트 표준 라이브러리에서 많이 사용되고 있다.
/// 우리가 사용하는 딕셔너리, 배열, set 등의 라이브러리는 모두 제네릭으로 작성되어 있기 때문에,
/// 타입에 제한 없이 사용할 수 있다.

/// - The Problem That Generics Solve
/// 아래의 두 Int형 타입의 값을 바꾸는 함수의 경우 다른 타입의 값들을 교환할 경우, 컴파일 에러가 발생한다.
/// 즉, Int형 타입의 값이 아닌 다른 타입의 값을 교환하려 하는 경우에 중복된 코드를 작성해야함을 의미한다.
/// 이와 같은 경우에 제네릭으로 코드를 작성해 중복을 줄일 수 있다.
func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let tempInt = a
    a = b
    b = tempInt
}
var someInt = 3
var someInt2 = 4
swapTwoInts(&someInt, &someInt2)
print("someInt: \(someInt), someInt2: \(someInt2)")


func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/*------------------------------------------*/

/// - Generic Functions
/// 제네릭 함수의 경우 <T> 와 같이 <>안의 문자가 추론될 타입의 별칭처럼 사용된다.
/// <T> 의 경우에 함수 내에서 T는 임의의 타입임을 의미한다.
/// 함수 호출 시점에 함수에 인자로 전달된 값의 타입에 따라 T가 어떤 타입이 될지 결정된다.
func swapTwoValues<T>(_ a: inout T, _ b: inout T){
    let temp = a
    a = b
    b = a
}

var someString1 = "ASD"
var someString2 = "BDC"
/// 임의의 타입 T가 String 타입으로 추론된다.
swapTwoValues(someString1,someString2)
print("someString1 = \(someString1), someString2 = \(someString2)")

/// - Note: 스위프트에서는 swap(_:,_) 함수를 기본제공해주므로, 사용할 수 있도록 하자.

/*------------------------------------------*/

/// - Type parameters
/// 위에 작성한 제네릭 함수에서 T를 타입 파라미터라고한다.
/// 타입 파라미터는 콤마(,)로 구분에 <>내에 여러 개 작성할 수 있다.
/// 함수 뒤에 <>내에서 타입 파라미터를 표기해야, 해당 파라미터로 코드를 작성할 수 있다.

/*------------------------------------------*/

/// - Naming Type Parameters
/// 일반적으로 타입 파라미터는 작성한 제네릭 코드와 관계를 고려해 지어야한다.
/// 예를 들어 딕셔너리의 경우 <Key, Value> 이고, 배열의 경우에는 <Element>이다.
/// 하지만 특별한 관계를 찾을 수 없고, 별다른 의미를 나타내지 않는다면 위에 작성한 함수처럼
/// T 혹은 U나 V와 같은 타입 파라미터를 작성하는게 좋다.
/// 또한, 반드시 대문자로 작성해 값이 아닌 타입임을 명시해야한다.

/*------------------------------------------*/

/// - Generic Types
/// 스택으로 예를 들어 설명해보자.
/// 첫번째 스택 자료구조의 경우 Int 타입의 스택 자료구조만 이용할 수 있지만,
/// 이를 제네릭으로 작성한다면 모든 타입에 대해 스택 자료구조를 이용할 수 있다.
struct IntStack{
    var item: [Int] = []
    
    mutating func push(_ element: Int){
        item.append(element)
    }
    
    mutating func pop() -> Int{
        return item.removeLast()
    }
    
    var size: Int{
        return item.count
    }
}

struct Stack<Element>{
    var item: [Element] = []
    
    mutating func push(_ element: Element){
        item.append(element)
    }
    
    mutating func pop() -> Element{
        return item.removeLast()
    }
    
    var size: Int{
        return item.count
    }
}

var stringStack = Stack<String>() // 빈 String 타입 스택 생성

/*------------------------------------------*/

/// - Extending a Generic Type
/// extension을 사용해 기능을 확장하고자 할 때 타입 파라미터를 명시할 필요 없다.
/// 기존 정의에서 사용한 타입 파라미터를 그대로 사용하면 된다.
extension Stack{
    var topItem: element?{
        return item.isEmpty ? nil : item[size - 1]
    }
}

/*------------------------------------------*/

/// - Type Constraints
/// 위의 swapTwoValues() 함수와 Stack은 모든 타입에 대해 사용할 수 있다.
/// 하지만, 모든 타입이 아닌 제약이 걸린 타입만 사용할 수 있도록 코드를 작성해야할 때도 있다.
/// 예를 들어, 특정 클래스를 상속한 타입이거나, 특정 프로토콜을 따르는 타입처럼말이다.
/// 딕셔너리의 키 타입의 경우 키 값의 유일함을 보장해야 하므로, Key 타입은 표준 라이브러리에 있는Hashable 프로토콜을 따라야한다.
/// 참고로, 스위프트의 기본 자료형은 Hashable 프로토콜을 따른다.
class SomeClass{}
protocol SomeProtocol{}
// 첫번쨰 타입 파라미터는 SomeClass의 서브 클래스인 조건이 있고,
// 두번째 타입 파라미터는 SomeProtocol을 따르는 타입이어야 한다.
func someFuction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U){
    
}

/// 아래의 함수는 문자열 배열에서 특정 문자열을 찾는 함수이다.
/// 하지만, 이 경우에는 문자열 배열이 아닌 경우 이 함수를 사용할 수 없다.
func findIndex(ofString valueToFind: String, in array: [String]) -> Int?{
    for (index, value) in array.enumerated(){
        if value == valueToFind {
            return index
        }
    }
    return nil
}

/// 아래의 함수는 위의 함수를 제네릭 함수로 작성한 것이다.
/// 하지만, 이 경우에 컴파일이 되지 않는다.
/// 왜냐하면 타입 파라미터인 T가 만약 직접 작성한 복잡한 타입일 경우 == 연산에 대한 동작을 정의하지 않았기 때문이다.
func findIndex(of valueOfFind: T, in array: [T] ) -> Int?{
    for (index, value) in array.enumerated(){
        if value == valueOfFind{
            return index
        }
    }
    return nil
}

/// 아래의 코드는 위의 코드를 수정한 것이다.
/// 타입 파라미터인 T는 Equatable 프로토콜을 따라야하므로, == 연산자에 대한 동작이 정의되어있다.
func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int?{
    for (index, value) in array.enumerated(){
        if value == valueToFind{
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])


/*------------------------------------------*/

/// - Associated Types
/// 프로토콜에서 연관된 타입을 설정해, 이 프로토콜을 따르는 타입에 제약을 줄 수 있다.
protocol Container{
    associatedtype Item
    mutating func append(_ item :Item)
    var count: Int{ get }
    subscript(i: Int) -> Item { get }
}

/// 아래는 Container 프로토콜을 따르도록 만들어진 DoubleStack 구조체이다.
/// Container의 연관된 타입인 Item이 타입 파라미터로 지정된 프로퍼티와 메소드에 대해
/// 기존의 기능을 래핑해서 프로토콜을 따르도록 하였다.
/// 만약, typealias 문이 없어도 스위프트의 타입 추론에 의해 문제 없이 동작한다.
struct DoubleStack: Container{
    var items: [Double] = []
    
    mutating func push(_ item: Double){
        items.append(item)
    }
    
    mutating func pop() -> Double{
        return items.removeLast()
    }
    
    // Conformance to the Container Protocol
    typealias Item = Double
    mutating func append(_ item: Item) {
        self.push(item)
    }
    
    var count: Int{
        return items.count
    }
    
    subscript(i: Int) -> Double{
        return items[i]
    }
}

/// 아래의 경우 프로토콜에 Item 타입을 구조체의 타입 파라미터인 Element로 작성해 요구사항을 충족시켰다.
/// 스위프트가 프로토콜의 연관된 타입인 Item 타입을 Element 타입 파라미터로 취급해 잘 동작한다.
struct Stack<Element>: Container{
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ element: Element){
        items.append(element)
    }
    
    mutating func pop() -> Element{
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    mutating func append(_ item: Element){
        self.push(item)
    }
    
    var count: Int{
        items.count
    }
    
    subscript(i: Int) -> Element{
        return items[i]
    }
}

/// 스위프트의 Array 컬렉션은 위에 작성한 Container 프로토콜을 이미 준수한다.
/// 즉, append(), count, 서브스크립트가 이미 구현되어 있다. (비록 Container 프로토콜에서는 연관된 타입으로 작성되어 있다.)
/// 따라서 extension을 이용해 프로토콜을 따르도록 할 수 있다.
extension Array: Container {} // 스위프트의 Array가 Container 프로토콜을 따른다.

/// 또한, 프로토콜의 연관된 타입에도 제약을 걸 수 있다.
/// 아래의 코드는 Container 프로토콜의 연관된 타입이 Equatable 프로토콜을 따라야 함을 의미한다.
protocol Container{
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

/// 추가로, 프로토콜은 또다른 프로토콜의 내부에 요구 사항으로 나타날 수 있으며, 연관된 타입도 마찬가지이다.
protocol SuffixableContainer: Container{
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ item: Int) -> Suffix
}

extension Stack: SuffixableContainer{
    
    func suffix(_ size: Int) -> Stack{
        var result = Stack()
        for index in (count-size)..<count{
            result.append(items[index])
        }
        return result
    }
}

var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
print(suffix)
// suffix contains 20 and 30

/*------------------------------------------*/

/// - Generic Where Clauses
/// where절을 활용하면 메소드, 서브스크립트, 타입 파라미터에 대한 요구사항을 정의할 수 있습니다.
/// 또한 연관된 타입에 대한 요구사항도 정의할 수 있다.
/// 아래의 함수의 경우에는 컨테이너의 종류가 달라도, 연관 타입이 갖고 Container 프로토콜만 따를 수 있다면 함수에 인자로 전달할 수 있다.
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable{
    
    guard someContainer.count == anotherContainer.count else{
        return false
    }
    
    for i in 0..<someContainer.count{
        if someContainer[i] != anotherContainer[i]{
            return false
        }
    }
    
    return true
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

/// 함수의 인자로 전달되는 타입이 Stack<String>이고, Array<String> 임에도 불구하고
/// 함수의 타입 파라미터와 연관된 타입이 함수 정의부의 요구 사항을 만족시키므로 호출할 수 있다.
if allItemsMatch(stackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// Prints "All items match."

/*------------------------------------------*/

/// - Extensions with a Generic Where Clause
/// 제네릭 코드로 정의된 타입에 대해 조건을 만족시키는 경우에만 확장된 기능을 제공하도록 할 수 있다.
/// 아래의 extension 문은 Stack 구조체의 타입 파라미터가 Equatable 프로토콜을 따르는 경우에만 isTop 메소드를 사용할 수 있다.
extension Stack where Element: Equatable{
    func isTop(_ item: Element) -> Bool{
        guard let topItem = items.last{
            return false
        }
        return topItem == item
    }
}

if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

/// 만약 Container 프로토콜을 따르지만, 원소가 Equatable 프로토콜을 따르지 않는 경우,
/// 컴파일 에러가 발생한다.
struct NotEquatable { }
var notEquatableStack = Stack<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
notEquatableStack.isTop(notEquatableValue)  // Error

/// extension 문을 프로토콜에도 사용해, 프로토콜이 요구 사항을 만족할 때만 확장된 기능을 제공하도록 할 수도 있다.
extension Container where Item: Equatable{
    func startWith(_ item: Item) -> Bool{
        return count >= 1 && self[0] == item // 서브스크립트 사용.
    }
}

if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
// Prints "Starts with something else."

/// 위의 예시의 경우, 프로토콜의 연관 타입이 특정 조건을 따르는 모든 타입에 확장된 기능을 제공하도록 했다.
/// 여기에 추가로, 컨테이너의 연관된 타입이 특정 타입일 경우에만 확장된 기능을 제공하도록 extension문과, where절을 사용할 수 있다.
extension Container where Item == Double{
    func average() -> Double{
        if items.isEmpty {
            return 0.0
        }
        var sum: Double = 0
        for index in 0..<count{
            sum += self[index]
        }
        return sum / Double(count)
    }
}

print([1260.0, 1200.0, 98.6, 37.0].average())
// Prints "648.9"

/*------------------------------------------*/

/// - Contextual Where Clauses
/// 제네릭을 사용해 코드를 작성하는 extension문에서 타입 파라미터에 제약 사항을 걸지 않고,
/// extension문내에서 제약 사항을 걸 수 있다.
/// 아래의 extension문의 경우, Container 프로토콜을 따르는 타입 중 원소가 Int 타입인 컨테이너는 average() 메소드를 사용할 수 있으며,
/// 원소의 타입이 Equatable 프로토콜을 따르는 경우 endsWith() 메소드를 사용할 수 있다.
/// 이를 상황별 where 절이라고한다.
extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}
let numbers = [1260, 1200, 98, 37]
print(numbers.average())
// Prints "648.75"
print(numbers.endsWith(37))
// Prints "true"

/// 아래의 코드는 하나의 extension문에 하나의 기능만을 추가한 것이며, 위의 코드와 동일한 역할을 수행한다.
/// 상황별 where 절을 적용하지 않았다.
extension Container where Item == Int {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
}
extension Container where Item: Equatable {
    func endsWith(_ item: Item) -> Bool {
        return count >= 1 && self[count-1] == item
    }
}

/*------------------------------------------*/

/// - Associated Types with a Generic Where Clause
/// 프로토콜의 연관된 타입에도 where절을 이용해 제약을 추가할 수 있다.
/// Sequence 프로토콜이 표준 라이브러리에서 반복자를 사용하듯이 Container에 반복자를 사용하고 싶다면, 다음과 같이하면 된다.
/// 아래의 경우에는 Iterator 타입은 IteratorProtocol을 따르기만 하고, Iterator가 순회하는 원소가 Container의 원소와 같은 타입이어야한다.
protocol Container{
    ///ddd
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript (i: Int) -> Item { get }
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

/// 만약 연관된 타입에 새로운 제약조건을 달아 새로운 프로토콜을 생성하고 싶다면, 다음과 같이 할 수 있다.
/// 아래의 코드는, Container타입에 새로운 제약을 추가해 Container 프로토콜을 상속하는 새로운 프로토콜을 선언한 것이다.
/// 새로운 프로토콜의 원소는 Comparable 프로토콜을 따라야한다.
protocol ComparableContainer: Container where Item: Comparable {}

/*------------------------------------------*/

/// - Generic Subscripts
/// 서브스크립트에도 제네릭과 제네릭 where절을 사용할 수 있다.
/// 서브스크립트의 타입 파라미터는 Sequence 프로토콜을 준수해야하며, Indices타입의 반복자가 순회하는 원소가 Int형이어야한다.
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result: [Item] = []
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
