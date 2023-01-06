//
//  Basic Operator.swift
//  SwiftPractice
//
//  Created by LEE on 2022/12/30.
//

import Foundation

// - Topic : Basic Operator
///
/// 

/// - Assignment Operator
/// 여타 다른 프로그래밍 언어(C, Obj C...) 와 다르게, 스위프트의 할당 연산자는 값을 return
/// 하지 않는다.
let (x,y) = (1, 2)
if x = y{
    // This isn't valid, because x = y doesn't return a value
}

/*------------------------------------------*/
/// - Arithmetic Operators
///
/// 다른 언어와 마찬가지로, 스위프트는 다음 4가지의 수 연산이 있다.
/// addtion(+), subtraction(-), multiplication(*), divisor(/)
/// 하지만, 다른 언어와 다르게 스위프트는 오버플로우를 허용하지 않는다.
/// 문자열에서 +는 concatenation 연산이다.
"hello, " + "world" // "hello, world"


/// a % b 연산은 remainder를 return 한다.
/// a = (b X some Value) + remainder 방정식으로 수행한뒤 remainder 값을 리턴한다.
/// 이때 b의 값이 음수인지 양수인지 상관없이 같은 값을 return 한다.

/*------------------------------------------*/
/// - Compound Assignment Operators

/// C언어와 마찬가지로, 복합 할당 연산자가 제공된다.
/// 하지만, 복합 할당 연산자도 마찬가지로 값을 return 하지 않는다.

let b = a += 2 // This isn't Valid

/*------------------------------------------*/
/// - Comparison Operators
/// 다른 프로그래밍 언어에서 제공되는 비교연산이 마찬가지로 제공된다.
/// === 연산도 존재하는데 이는 같은 객체를 참조하는지 비교한다.

/// 튜플에서의 비교 연산자는 조금 주의할 필요가 있다.
/// 튜플에서 비교 연산은 왼쪽값부터 차례대로 비교한다.
/// 만약 두 값이 같다면 다음 값의 비교로 넘어간다.

(1, "zebra") < (2, "apple") // true
(3, "apple") < (3, "bird") // true
(4, "dog") == (4, "dog") // true

/// 만약 튜플에서 서로 다른 타입의 값을 비교하려고 한다면, 에러가 발생한다.
/// 또한, 비교 연산자가 제공되지 않는 타입에 대해 수행한다면 에러가 발생한다.
("blue", false) < ("purple", true) // Error

/// 튜플에서 비교연산자가 가능한 최대 원소의 개수는 6개이다. 이 이상 원소에 대해
/// 값을 비교하고자한다면, 직접 정의해서 사용해야 한다.

/*------------------------------------------*/
/// - Ternary Conditional Operator

/// 삼항 조건 연산자는 question ? answer1 : answer2
/// 의 형태를 취한다.
/// 잘 사용한다면, 한 눈에 보기 편하지만 중첩해서 사용한다면 이해하기 어려운 코드가
/// 될 수 있다. 따라서 적절하게 사용해야 한다.

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

/*------------------------------------------*/
/// - Nil-Coalescing Operator
///
/// nil 병합 연산자는 a ?? b
/// 의 형태를 취한다.
/// 만약 옵셔널인 a가 nil이라면 b의 값이 되고, a가 nil이 아니라면 a의 값이 된다.
/// 만약 a가 nil이 아닌 경우, b를 실행하지 않는다.
a != nil ? a! : b // 과 동일한 연산이다.

let defaultColorName = "red"
let userDefinedColorName: String?

let colorNameToUse = userDefinedColorName ?? defaultColorName

/*------------------------------------------*/
/// - Range Operators
///
/// 범위 연산자는 크게 4가지가 있다.
/// 첫번쨰는 닫힌 범위 연산자이다.
for index in 1...5{
    print("index is \(index)")
}

/// 두번쨰는 반개방 범위 연산자이다.
let members = ["Anna", "Alex", "Brian", "Jack"]
let count = members.count
for name in member[0..<count]{
    print("Person \(name+1) is called \(member[name])")
}

/// 세번쨰는 단측 범위 연산자이다.
/// 요소의 끝까지 탐색하거나, 시작부터 탐색하고자 할떄 유용하게 사용할 수 있다.
/// 꼭 인덱스 에서만 사용할 필요는 없다.
for name in members[2...]{
    print(name)
}
// Brian
// Jack

for name in members[...2]{
    print(name)
}
// Anna
// Alex
// Brian

/// 다음과 같이 사용할 수도 있다.
for name in members[..<2]{
    print(name)
}
// Anna
// Alex

let range = ...5
range.contains(7) // false
range.contains(-3) // true
range.contains(4) // true

/*------------------------------------------*/

/// - Logical Operator

/// 논리 연산자는 Boolean Value에 대해서만 사용이 가능하다.
/// ||, && 연산모두 왼쪽부터 처리하며, 괄호를 통해 읽기 쉽도록 할 수 있다.
/// 읽기 쉬운 코드를 작성하는 것이 간결한 코드를 작성하는 것보다 중요하다.
