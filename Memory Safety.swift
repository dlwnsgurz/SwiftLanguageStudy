//
//  Memory Safety.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/18.
//

import Foundation

// - Topic: Memory Safety
///
/// 스위프트는 자동적으로 메모리 충돌을 방지해준다.
/// 만약, 코드에 메모리 충돌이 발생한다면 런타임 에러나 컴파일 에러가 발생한다.

/// - Understanding Conflicting Access to Memory
/// 변수의 값을 설정하거나, 함수의 인자에 값을 전달할 때 메모리 읽기 접근이 나타난다.
/// 메모리의 접근 충돌은 한 메모리 공간에 동시에 접근하는 경우에 발생한다.
/// 아래에서 설명하는 메모리 충돌은 동시성 코드나 다중 쓰레드 환경에서 발생하는 충돌이 아니고,
/// 단일 쓰레드에서 발생할 수 있는 메모리 충돌이다.
/// 또한, 읽기 접근은 메모리의 위치를 변경시키고 쓰기 접근은 메모리의 위치를 변경시키지 않는다.

// A write access to the memory where one is stored.
var one = 1

// A read access from the memory where one is stored.
print("We're number \(one)!")

/// 아래의 접근은 즉각접근이다.
/// myNumber에 쓰기 접근으로 1이 저장된다.
/// myNumber에 읽기 접근을 해, 값인 1을 number에 쓰고, number에 쓰기 접근을 해 1을 더한뒤 다시 number에 읽기 접근을 해 값인 2를 return 한다.
/// 이후 리턴한 값 2를 쓰기 접근한 myNumber에 저장한다.
func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)
// Prints "2"

/*------------------------------------------*/

/// - Conflicting Access to In-Out Parameters
/// 스위프트는 모든 in-out 파라미터에 대한 장기 쓰기 접근을 가지고 있다.
/// non in-out 파라미터가 평가된 후, 전달된 파라미터 순으로 in-out 파라미터에 대한 장기 쓰기 접근이 이루어진다. (함수가 종류될 때까지, 쓰기 접근 중)
/// 아래의 코드를 보자.
/// 전역 변수인 stepSize가 in-out 파라미터로 전달되어 함수가 호출되면 stepSize 메모리의 위치에 쓰기 접근이 이루어진다.
/// 함수의 바디 내에서는 stepSize에 대한 읽기 접근이 다시 이루어졌다.
/// 따라서, 두 접근이 충돌해 런타임 에러가 발생한다.
var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

increment(&stepSize)
// Error: conflicting accesses to stepSize

/// 아래의 코드는 값의 복사본을 만들어, 위의 코드의 메모리 충돌을 해결한 것이다.
/// 새로운 메모리 공간을 할당해 stepSize의 값을 저장했다.(쓰기접근)
/// 이 복사본을 in-out 파라미터로 전달해 쓰기 접근을 한다.
/// 함수의 바디내에서는 복사본에 대한 쓰기 접근이 계속 유지되는 동안, 원본에 대한 읽기 접근이 이루어진다. (다른 메모리 공간)
/// 원본에 대한 읽기 접근이 종료되고 복사본에 새로운 값이 할당되고 장기 쓰기 접근이 끝난다.
/// 다시 복사본에 읽기 접근을 해 값을 읽어와 원본에 저장한다.

// Make an explicit copy.
var copyOfStepSize = stepSize
increment(&copyOfStepSize)

// Update the original.
stepSize = copyOfStepSize
// stepSize is now 2

/// 또한, 함수의 다중의 in-out 파라미터에 단일 인자를 전달한다면, 동일한 메모리에 쓰기 접근이 동시에 발생하므로,
/// 메모리 충돌 에러가 발생한다.
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)  // OK
balance(&playerOneScore, &playerOneScore)
// Error: conflicting accesses to playerOneScore

/// - Note: 연산자는 함수이다. 만약, balance함수의 연산자를 <^>로 정의한다면,
/// playerOneScore <^> playerOneScore 는 동일한 에러가 발생한다.

/*------------------------------------------*/

/// - Conflicting Access to self in Methods
/// 구조체 내의 mutating 메소드는 구조체 내의 값을 변화시킨다.
/// 따라서 구조체 메소드가 호출된다면, self에 대한 장기 쓰기 접근이 메소드 종료시까지 이뤄진다.
/// 즉 self에 대한 쓰기 접근이 마치 in out 함수를 호출했을 때와 같이 나타난다.
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK
/// oscar가 shareHealth 메소드를 호출했다(mutating)
/// 따라서, 함수 종료 시점까지 oscar 메모리에 대한 장기 쓰기 접근이 이루어진다.
/// 또한 메소드 내에서 balance 함수가 호출된다.
/// 이 때, in-out 파라미터로 maria가 전달되어 maria 메모리에 대해서도 장기 쓰기 접근이 이루어진다.(balace 함수 종료 시점까지)
/// 두 쓰기 접근은 각각 다른 메모리 공간에 접근하기때문에 에러가 발생하지 않는다.
oscar.shareHealth(with: &oscar)
// Error: conflicting accesses to oscar
/// 그러나 위의 메소드는 동일 메모리 공간에 쓰기 접근을 하게되므로, 에러가 발생한다.

/*------------------------------------------*/

/// - Conflicting Access to Properties
/// 구조체, 튜플, 열거형과 같은 타입은, 여러 값의 집합으로 이루어져있다.
/// 따라서 해당 타입의 요소에 대한 쓰기 접근은 타입 인스턴스 전체에 대한 쓰기 접근이 발생한다.
/// 즉, 요소 일부에 대한 값 변경 시 전체가 변경된다.
/// in-out 파라미터로 playerInformation의 각각에 요소를 전달해 쓰기 접근을 하지만,
/// 이는 튜플 자체에 대한 쓰기 접근이 2번 발생한 것이므로 에러가 발생한다.
var playerInformation = (health: 10, energy: 10)
balance(&playerInformation.health, &playerInformation.energy)
// Error: conflicting access to properties of playerInformation

/// 아래의 경우는 구조체 인스턴스에 쓰기 접근이 오버랩되는 예시이다.
/// in-out 파라미터에 의해 쓰기 접근이 오버랩됨.
var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)  // Error

/// 만약, 구조체 인스턴스가 지역변수라면 메모리 중복 접근을 허용한다.
/// 스위프트가 각 프로퍼티가 서로 상호작용하지 않을 것을 알고 있기때문이다.
func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // OK
}

/// - Note: 아래의 3가지 경우, 구조체 인스턴스에 대한 중복접근을 허용한다.
/// 구조체 인스턴스의 연산 프로퍼티, 클래스 인스턴스 프로퍼티가 아닌 저장된 프로퍼티에 접근할 때.
/// 지역번수인 구조체 인스턴스에 중복 접근할 때.
/// 구조체가 클로저에 의해 캡쳐되지 않거나, nonescaping 클로저에 의해 캡쳐될 때.
4
