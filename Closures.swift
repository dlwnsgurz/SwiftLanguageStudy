//
//  Closure.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/04.
//

import Foundation

// - Topic: Closures

/// 클로저는 기능을 수행하는 블록이다.
/// 함수나 메소드도 클로저의 일종이며, C나 ObjC에서 블록 혹은 다른 언어에서의 람다식과 비슷하다.

/// - Clousre Expressions
var names = ["Jack", "Anna", "Eva", "Alex", "Chris"]
/// sorted메소드에 인자로 전달된 클로저이다.
/// 아래 예시들과 같이 따로 정의되지 않고 인자로 들어가는 클로저를 인라인 클로저라고 한다.
let sortedNames = names.sorted(by: {(s1: String, s2: String) -> Bool in
    return s1 < s2
})

/// 위의 표현은 타입추론을 이용해 더 줄일 수 있다.
let sortedNames = names.sorted(by: {s1, s2 in return s1 > s2})

/// 위 표현 또한 implicit return을 이용해 더 줄일 수 있다.
let sortedNames = names.sorted(by: {s1, s2 in s1 > s2})

/// 위의 표현 또한 단축 인자 이름을 통해 더 줄일 수 있다.
let sortedNames = names.sorted(by: {$0 > $1})

/// 위의 표현 또한 더 연산자표현으로 더 줄일 수 있다.
/// 이 경우에 String 타입의 연산자(>)가 이미 정의되어 있으므로 사용할 수 있다.
let sortedNames = names.sorted(by: >)

/*------------------------------------------*/

/// - Trailing Closures
/// 만약, 함수의 마지막 인자가 클로저이고 그 클로저가 매우 길다면 후위 클로저 문법을 사용할 수 있다.
/// 후위 클로저 문법을 사용하는 경우, 인자 레이블은 생략할 수 있다.
/// 또한 여러개의 후위 클로저 문법을 사용할 수 있다.
func someFunctionThatTakesAClosure(closure: () -> Void){
    
}

/// 위의 함수를 후위 클로저 없이 호출할 때
someFunctionThatTakesAClosure(closure: {
  // 여기에 클로저의 내용이 들어간다.
})

/// 만약 위의 함수를 후위 클로저 문법을 이용해 호출한다면,
someFunctionThatTakesAClosure(){
    // 여기에 클로저의 내용이 들어간다.
}

/// 위에 있던 sortedName 또한 후위 클로저 문법으로 표현할 수 있다.
let reversedNames = names.sorted(){$0 > $1}

/// 만약 이 경우와 같이 클로저 하나만 인자로 전달되고, 이를 후위 클로저료 표현했다면,
/// ()도 생략할 수 있다.
let reversedNames = names.sorted{$0 > $1}


/// 위와 같은 표현들은 인라인 클로저를 한 줄에 작성할 수 없을 경우에 효율적으로 사용할 수 있다.
/// Array에 map 메소드도 인자로 클로저를 받는데, 위의 표현으로 간편하게 줄일 수 있다.
/// 다음은 map메소드에 후행 클로저 문법을 적용한 예이다.
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]
let strings = numbers.map{ (number) -> String in
    var number = number
    var output = ""
    repeat{
        output = digitNames[number % 10]! + output
        number /= 10
    }while number > 0
    return output
}
/// 위의 예를 설명해보자면, map 메소드는 인자로 클로저 하나만을 받는다.
/// 클로저를 하나만 받으므로 후위 클로저 문법을 사용해 ()를 생략하고 {}내에 클로저를 작성했고,
/// (parameter: type) -> return Type in CODE 꼴로 작성해야 하지만,
/// 매개변수의 타입은 스위프트의 타입추론 기능으로 생략하였다.
/// 따라서, numbers원소가 하나씩 map에 대응되어 strings 배열이 생성되었다.

/// 함수의 인자에 클로저가 여러개 있는경우
/// 후행 클로저 문법을 사용할 수 있다, 하지만 첫번째 클로저만 인자레이블이 생략 가능하다.
func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
    if let picture = download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}

loadPicture(from: someServer) { picture in
    someView.currentPicture = picture
} onFailure: {
    print("Couldn't download the next picture.")
}

/*------------------------------------------*/

/// - Caputuring Value
/// 스위프트의 클로저는 값 캡쳐 기능을 제공한다.
/// makeIncremeter 함수내의 incrementer 클로저는 output 이라는 값을 참조하고 있다.
/// 이 값은 makeIncrementer가 종료될 때까지 사라지지 않으므로, 매 호출시 amout 만큼 증가된 값을 return 한다.
/// incrementer 클로저는 output에 대한 참조를 가지고 있다.

func makeIncrementer(forIncrement amount: Int) -> () -> Int{
    var output = 0
    func incrementer() -> Int{
        output += amount
        return output
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
let incrementBySeven = makeIncrementer(forIncrement: 7)

print(makeIncrementer(forIncrement: 10)()) // 10 makeIncrement 호출된 후 종료
print(makeIncrementer(forIncrement: 10)()) // 10 makeIncrement 호출된 후 종료
print(makeIncrementer(forIncrement: 10)()) // 10 makeIncrement 호출된 후 종료
print(incrementByTen()) // 10
print(incrementByTen()) // 20
print(incrementByTen()) // 30
print(incrementBySeven()) // 7
print(incrementByTen()) // 40

/// - Closures Are Reference Type
/// 스위프트의 클로저는 Reference이다.
/// 위의 예를 보자면, incrementByTen과 incrementBySeven을 상수로 선언했음에도 불구하고 incrementer가 리턴하는 값이 매번 증가한다.
/// 이는 스위프트의 클로저가 reference 타입이기때문이다.
/// 아래의 경우에는 anotherIncrementByTen과 incrementByTen의 참조가 같기때문에 동일한 결과가 나타난다.
let anotherIncrementByTen = incrementByTen
print(anotherIncrementByTen()) // 50
print(incrementByTen()) // 60

/*------------------------------------------*/

/// - Escaping Closures
///
/// 탈출 클로저란?
/// 함수에 인자로 전달된 클로저가 외부에 저장(실행)되거나, 함수가 종료된 후에도 실행될 때
/// 이 클로저를 탈출클로저라고 한다.
/// @escaping을 타입 앞에 붙힌다.
/// 논 Escaping 클로저의 경우 스택에 할당되지만, 탈출 클로저의 경우 항상 호출가능해야 하기때문에
/// 힙에 할당된다.
/// 탈출클로저의 경우 self를 명시적으로 적어야한다.
var completionHandlers: [()->Void] = []
func someFuctionWithEscapingClosure(completionHandler: @escaping () -> Void){
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"
let instance2 = instance
instance2.

completionHandlers.first?()
print(instance.x)
// Prints "100"

/*------------------------------------------*/

/// - AutoClosure
/// 자동 클로저란 인자 값이 없으면서, 특정 표현을 감싸 다른 함수의 인자로 전달 될 수 있는 클로저다.
/// 자동 클로저는 실제로 호출되기 전까지 절대 실행되지 않는다.
///
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
// 함수를 {} 감쌌다. 하지만 remove 함수는 실행되지 않는다.
// 또한, 위 상수는 클로저이며 타입은 () -> String 타입이다.
// 왜냐하면, 자동 클로저이므로 인자가 없고 표현내의 값이 자동클로저의 return 타입이 되기 때문이다.

print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"

/// 자동 클로저를 사용하지 않고, 직접 클로저를 인자로 전달한 경우이다.
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"

/// 자동 클로저를 사용해, 인자를 전달하는 경우는 다음과 같다.
func serve(customer customerProvide: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
