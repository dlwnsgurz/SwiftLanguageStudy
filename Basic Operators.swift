//
//  Basic Operator.swift
//  SwiftPractice
//
//  Created by LEE on 2022/12/30.
//

import Foundation

// - Topic: Basic Operators

/// - Terminology
/// 스위프트에는 3가지 종류의 연산자가 있다.
/// 첫번째는 단항 연산자로 타겟 앞이나 뒤에 붙는다 (ex. +a, a!)
/// 두번쨰는 이항 연산자로 두 타겟의 사이에 붙는다. (ex. a-b, a%b)
/// 세번째는 삼항 연산자다. (ex. a ? b : c)

/*------------------------------------------*/

/// - Assignment Operator
/// 다른 프로그래밍 언어(C, Obj C...) 와 다르게, 스위프트의 할당 연산자는 값을 return하지 않는다.
let (x,y) = (1, 2) // x = 1, y = 2

if x = y{
    // This isn't valid, because x = y doesn't return a value
}

/*------------------------------------------*/

/// - Arithmetic Operators
/// 다른 프로그래밍 언어와 마찬가지로, 스위프트는 다음 4가지의 산술 연산이 있다.
/// addtion(+), subtraction(-), multiplication(*), divisor(/)
/// 하지만, 다른 프로그래밍 언어와 다르게 스위프트는 오버플로우를 허용하지 않는다.
/// 문자열에서 +는 concatenation 연산이다.
"hello, " + "world" // "hello, world"

/// a % b 연산은 remainder를 return 한다.
/// a = (b X some Value) + remainder 방정식으로 수행한뒤 remainder 값을 리턴한다.
/// 이때 b의 값이 음수인지 양수인지 상관없이 같은 값을 return 한다.

/*------------------------------------------*/

/// - Compound Assignment Operators
/// C언어와 마찬가지로, 복합 대입 연산자가 제공된다.
/// 하지만, 복합 대입 연산자도 마찬가지로 값을 return 하지 않는다.
let b = (a += 2) // This isn't Valid

/*------------------------------------------*/

/// - Comparison Operators
/// 다른 프로그래밍 언어에서 제공되는 비교 연산자가 마찬가지로 제공된다.
/// 비교 연산자는 Bool 타입의 값을 리턴한다(true, false)
/// === 연산도 존재하는데 이는 같은 객체를 참조하는지 비교한다.

/// 튜플에서의 비교 연산자는 두 튜플의 요소가 같은 타입, 같은 개수를 가져야 사용할 수 있다.
/// 튜플에서의 비교 연산자는 조금 주의할 필요가 있다.
/// 튜플에서 비교 연산은 왼쪽값부터 차례대로 비교한다.
/// 만약 두 값이 같다면 다음 값의 비교로 넘어간다. (두 요소의 값이 같다면, 비교 연산을 적용하지 않고 다음 요소의 비교로 넘어간다.)
/// 모든 요소가 같다면 같은 튜플이다.
(1, "zebra") < (2, "apple") // true
(3, "apple") < (3, "bird") // true
(4, "dog") == (4, "dog") // true

/// 만약 튜플에서 서로 다른 타입의 값을 비교하려고 한다면, 에러가 발생한다.
/// 또한, 비교 연산자가 제공되지 않는 타입에 대해 수행한다면 에러가 발생한다.
("blue", false) < ("purple", true) // Error

/// 튜플에서 비교 연산자가 가능한 최대 요소의 개수는 6개이다.
/// 7개 이상의 요소의 값을 비교하고자한다면, 직접 정의해서 사용해야 한다.

/*------------------------------------------*/

/// - Ternary Conditional Operator
/// 삼항 조건 연산자는 question ? answer1 :  answer2 형태의 연산자다.
/// 잘 사용한다면, 한 눈에 보기 편하지만 중첩해서 사용한다면 이해하기 어려운 코드가 될 수 있다. 따라서 적절하게 사용해야 한다.
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

/*------------------------------------------*/

/// - Nil-Coalescing Operator
/// nil 병합 연산자는 a ?? b 형태의 연산자다.
/// 만약 옵셔널인 a가 nil이라면 b의 값이 반환되고, a가 nil이 아니라면 a의 값이 반환된다.
/// 만약 a가 nil이 아닌 경우, b를 실행하지 않는다.
a != nil ? a! : b // 과 동일한 연산이다.

let defaultColorName = "red"
let userDefinedColorName: String?

let colorNameToUse = userDefinedColorName ?? defaultColorName

/*------------------------------------------*/

/// - Range Operators
/// 범위 연산자는 크게 4가지가 있다.
/// 첫번째는 닫힌 범위 연산자이다.
for index in 1...5{
    print("index is \(index)")
}

/// 두번째는 반열림 범위 연산자이다.
let members = ["Anna", "Alex", "Brian", "Jack"]
let count = members.count
for name in 0..<count{
    print("Person \(name+1) is called \(member[name])")
}

/// 세번쨰는 단측 범위 연산자이다.
/// 요소의 끝까지 탐색하거나, 시작부터 탐색하고자 할 때 유용하게 사용할 수 있다.
/// 꼭 인덱스에서만 사용할 필요는 없다.
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

/// - Logical Operators
/// 논리 연산자는 Boolean 타입의 값에 대해서만 사용이 가능하다.
/// ||, && 연산모두 왼쪽부터 처리하며, 괄호를 통해 읽기 쉽게 할 수 있다.
/// 읽기 쉬운 코드를 작성하는 것이 간결한 코드를 작성하는 것보다 중요하다.
/// || 연산자는 하나의 식이 true인 경우, 다음 식을 검토하지 않고,
/// && 연산자는 하나의 식이 false인 경우, 다음 식을 검토하지 않는다.
