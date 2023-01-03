//
//  Control Flow.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/03.
//

import Foundation

// - Topic: Control Flow

/// - For-in Loops
/// for-in 루프로 Array의 iterate가 가능하다.

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!x

/// 또한 Dictionary에서는 (key,value) 쌍을 for-loop로 iterate가 가능하다.
/// 이때 (key,value) 는 상수로, 변경이 불가능하다.

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// cats have 4 legs
// ants have 6 legs
// spiders have 8 legs

/// numeric range 또한 for-loop에서 사용할 수 있다.
/// 이때 index 는 상수이다. (값의 변경이 불가능하다.)
for index in 1...5{
    print("index is \(index)")
}

/// 만약 for-loop 내에 값이 필요없다면, 언더스코어(_)를 사용할 수 있다.
/// 이는 코드를 읽는 사람에게 반복문 내의 값이 필요하지 않다는 메시지를 줄 수 있으므로,
/// 반복문 내의 값이 필요없다면 이용하도록 하자.
let base = 1
let power = 3
let end = 10
for _ in 1...end{
    base *= power
}

/// 당연히, for-loop에서는 반닫힌 range도 가능하다.
let minutes = 60
for tickMark in 0..<minutes{
    //
}

/// stride(from: to: by:) 함수를 이용해 간격있는 range를 생성할 수 있다.
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval){
    ///
} // (0,5,10.......50,55)

/// stride(from: through: by:) 함수를 이용해 끝 값까지 포함하는 range를 생성할 수 있다.
let finalNumber = 12
let firstNumber = 3
let numberInterval
for index in stride(from: first, through: finalNumber, by: numberInterval){
    //
}
        
/*------------------------------------------*/

/// - While Loops
/// While 루프는 반복횟수가 정해진 for-loop와 다르게, 얼마나 반복할지 모를 때 사용하는 것이 바람직하다.
/// while은 조건을 검사하고, 조건이 참이면 반복하며 조건이 거짓이면 반복문을 빠져나온다.
/// repeat - while문은 우선 statement를 실행하고, 조건이 참이면 또 실행하며 조건이 거짓인 경우에는 반복문을 빠져나온다.

/*------------------------------------------*/

/// - Conditional Statements
/// 스위프트에는 2가지 조건문이 존재한다.
/// if문과 switch문으로, switch문은 주로 if문보다 더 복잡한 경우의 분기가 필요할 때 사용한다.
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// Prints "It's very cold. Consider wearing a scarf."

/// switch 문은 말그대로 switch이다.
/// case로 분기하여 실행하고, 만약 case에 포함되지 않은 값이라면 defalut문으로 분기한다.
/// 따라서 가능한 모든 경우를 case로 분기시켜야하며, 그럴 수 없다면 반드시 마지막에 default case로 분기할 수 있도록 해야한다.

let someCharacter : Character = "a"
switch someCharacter{
case "a":
    print("")
case "z":
    print("")
default:
}

/// 또한 스위프트의 스위치문은 C나 ObjC와 다르게 한 case로 분기하면, 그 아래 모든 case가 실행되지 않는다.
/// 따라서 break을 명시할 필요가 없다.
/// 만약 C처럼 그 아래 case또한 분기시키고자 한다면 fallthrought 키워드로 가능하며, 필요에 따라 break도 사용가능하다.

/// 만약 case 조건을 2개 이상으로 합치고 싶다면 ,를 이용하면된다.
/// 만약 case내의 statement가 없다면, 컴파일 에러가 발생한다.

switch someCharacter{
case "a":
case "A":
    print("")
default:
    //
}

switch someCharacter{
case "a", "A":
    print("")
default:
    print("")
}

/// 스위프트 스위치문의 case에는 간격이 올 수도 있다.
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// Prints "There are dozens of moons orbiting Saturn."

/// 스위치 문에서도 tuple을 사용할 수 있다.
/// 또한 간격이 올 수도 있다.

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// Prints "(1, 1) is inside the box"

/// 스위프트의 스위치문에는 값 바인딩을 사용할 수 있다.
/// 해당 값을 변수나, 상수로써 사용할 수 있기때문이다.
/// var로 선언한 경우 원본의 값은 변하지 않는다.
/// 아래의 경우에는 default가 필요없는데 이는 맨아래 case문이 모든 경우를 포함하고 있기 때문이다.
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2"

/// 또한 스위치문은 where 키워드로 추가적인 조건을 달 수 있다.
/// 이 경우도 마찬가지로, 마지막 case가 모든 경우를 포함하기 때문에 default문을 작성할 필요 없다.
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

/// 또한 case를 ,로 묶은 경우에도 값 바인딩을 사용할 수 있다
/// 이 경우에는 몇 가지 주의할 점이 있다.
/// 첫번쨰. 묶은 조건들은 같은 이름의 변수나 상수를 가져야한다.
/// 두번째, 묶인 조건들의 바인딩 된 값들은 같은 타입을 가져야한다.
/// 이렇게 함으로써 body내에서는 항상 바인딩 된 값에 접근할 수 있다.
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

/*------------------------------------------*/

/// - Control Transfer Statements
/// 스위프트에는 5가지 흐름 제어 문이 있다
/// 첫번째는 continue문이다.
/// continue문은 loop를 즉시 종료하고, 루프의 처음으로 돌아간다.
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)
// Prints "grtmndsthnklk"

/// 두번째는 break문이다.
/// break문은 switch나 loop문에서 사용할 수 있으며, 그 즉시 종료한다.
/// 스위치 문에서 break문은 활용도가 높다.
/// 만약 case로 분기해야하지만 특별한 연산이 필요가 없는 경우 break문을 사용하면 된다.
/// 아래의 스위치문은 case로 분기가 성공하면, 옵셔널 바인딩을 통해 그 값을 사용하려하지만,
/// 만약 case문에 존재하지 않는 문자가 들어온다면, possibleIntegerValue가 그대로 nil이면 되므로
/// default: 문에서 break문을 작성하였다.
let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}

/// 스위프트의 스위치문은 C와 다르게 fallthrough가 디폴트가 아니다.
/// 따라서 프로그래머의 실수를 줄여주어 정확한 코드를 작성할 수 있다.
/// 하지만 의도적으로 fallthrough문을 통해 스위치 문을 작성할 수 있다
/// - Note: fallthorugh는 case의 조건을 검사하지 않고 바로 실행한다.
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// Prints "The number 5 is a prime number, and also an integer."

/*------------------------------------------*/

/// - Early Exit
/// 조기종료를 위해 guard문을 이용할 수 있다.
/// guard 문은 if문과 비슷하지만 몇 가지 특징이 있다.
/// 1. 종료해야하는 조건과 그에 해당하는 명령을 뭉쳐서 둘 수 있기때문에 가독성이 올라간다.
/// 2. 옵셔널 바인딩을 통해 벗겨낸 옵셔널 값은 {}내에서만 사용이 가능하지만 guard문의 경우 그렇지 않다.
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }

    print("Hello \(name)!")

    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."

/*------------------------------------------*/

/// - Checking API Availability

/// 스위프트는 Checking API Availability 기능을 제공한다.
/// 만약 SDK에서 사용할 수 없는 내장 API를 사용한다면 스위프트는 컴파일 오류를 발생시킨다.
/// if문이나 guard문을 통해 사용할 수 있는 API인지 검사할 수 있다.


/// *은 필수로 붙여야하며, 아래 조건문은 iOS 10버전이상, macOS 10.12 버전 이상에서 사용가능하다는 뜻이다.
if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}

/// 또한 unavailable문으로 처리할 수 있다.
/// 아래의 코드는 동일한 동작을 한다.
if #available(iOS 10, *) {
} else {
    // Fallback code
}

if #unavailable(iOS 10) {
    // Fallback code
}
