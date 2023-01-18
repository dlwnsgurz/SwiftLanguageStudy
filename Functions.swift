//
//  Functions.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/04.
//

import Foundation

// - Topic: Functions

/// 스위프트에서 함수는 몇 가지 기능을 제공한다.
/// 첫번째는 레이블 이름이다. 함수를 호출하는 시점에 명시할 수 있도록 되어있으므로 가독성이 좋다.
/// 두번째는 디폴트 값을 제공하기때문에 함수를 간편하게 정의하고, 호출할 수 있다.

/// - Defining and Calling Fuctions
/// func 키워드를 통해 함수를 정의할 수 있다.
/// -> 키워드로 함수의 return 타입을 정의할 수 있다.
func greet(person: String) -> String {
    let greeting = "Hello, \(person)!"
    return greeting
}
print(\(greeting("Anna"))) // Hello, Anna!

/*------------------------------------------*/

/// - Fuction Parameters and Return Values
/// 매개변수가 없는 함수를 정의할 수 있다.
/// 호출또한 매개변수 없이 호출한다.
func sayHelloWorld() -> String {
    return "Hello, World!"
}

print(sayHelloWorld())

/// 매개변수가 여러 개인 함수를 정의할 수 있다.
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return // greetAgain(person: person)
    }else{
        return greet(person: person)
    }
}

/// 리턴 값이 없는 함수를 정의할 수 있다.
/// 사실 Void라는 튜플() 타입을 반환하는 것과 마찬가지이다.
func greet(person: String) {
    print("Hello \(person)!")
}

/// 리턴 값이 있는 함수의 호출에서, 리턴 값을 이용하지 않을 수 있다.
func printAndCount(string: String) -> Int{
    print(string)
    return string.count
}

func printWithoutCount(string: String){
    let _ = printAndCount(string: string)
}

/// 튜플로 리턴해 다중 값을 가질 수도 있다.
func minMax(array: [Int]) -> (min: Int, max: Int){
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1...]{
        if value > currentMax{
            currentMax = value
        }else if value < currentMin{
            currentMin = value
        }
    }
    return (currentMin, currentMax)
}


let bound = minMax(array: [-1,2,6,-6,8])
print("min value is \(bound.min), max value is \(bound.max)")

/// 또한 옵셔널 튜플을 리턴할 수 있다.
/// 괄호밖에 ?를 붙이면 된다. ex) (Int, Int)? (String, Int, Int)?
/// 옵셔널 튜플타입은 튜플 내의 옵셔널이 있는 것과는 다르다. vs (Int?, Int?)
func minMax(array: [Int]) -> (min: Int, max: Int)?{
    if array.isEmpty{
        return nil
    }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1...]{
        if value > currentMax{
            currentMax = value
        }else if value < currentMin{
            currentMin = value
        }
    }
    return (currentMin, currentMax)
}

/// 또한 함수 내의 실행문이 한 줄로 표현할 수 있다면, return 키워드를 생략할 수 있다.
/// 아래 두 함수는 완전 동일한 역할을 한다.
func greeting(person: String) -> String{
    return "Hello, \(person)!"
}

func greetingAnother(person: String) -> String {
    "Hello, \(person)!"
}

/*------------------------------------------*/

/// - Fuction Argument Labels and Parameter Names
/// 함수 매개변수의 이름은 유일해야 하며, 인자 레이블은 호출시에 가독성을 높힐 수 있다.
func someFuction(firstParameterName: Int, secondParameterName: Int){
    
}

func someFuction(argumentLabel firstParameterName: Int){
    
}

/// 인자 레이블을 언더스코어로 생략할 수 있다.
func someFuction(_ parameter: Int){
    //
}
someFuction(3)

/// 매개변수에 기본 값을 지정할 수 있다.
/// 기본 값이 지정되지 않은 매개변수가 반드시 앞에 와야한다.
func someFuction1(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
        
}

someFuction1(parameterWithoutDefault: 3)    //  3, 12
someFuction1(parameterWithoutDefault: 3, parameterWithDefault: 4)   // 3, 4


/// 가변 매개변수를 매개변수로 삼는 함수를 정의할 수 있다.
/// 가변 매개변수는 0개 이상의 원소가 전달되어야 한다.
/// 가변 매개변수는 함수 내부에서 상수 배열처럼 다루어진다.
/// 아래의 경우 number는 [Double]형 상수로 취급된다.
/// 가변 매개 변수뒤에 첫번째 매개변수는 반드시 인자레이블이 있어야한다.
func arithmeticMean(_ numbers: Double...) -> Double{
    var total: Double = 0
    for number in numbers{
        total += number
    }
    return total / numbers.count
}

/// 함수 내부에서 매개변수의 값을 변경해도 원본의 값은 변하지 않는다.
/// 만약 이러한 연산을 수행하고 싶다면, inout 키워드를 이용하면 된다.
/// 상수나 리터럴은 inout 매개변수에 들어올 수 없고 오직 변수만 들어올 수 있다.
/// 매개변수의 타입 앞에 inout 키워드를 붙인다. 가변 매개변수에는 사용 불가능하다.
/// 또한 inout 매개변수는 기본 값을 가질 수 없다.
/// 호출하는 시점에는 인자앞에 &를 붙여 값이 변함을 명시한다.
func swapTwoInts(_ a: inout Int, _ b: inout Int){
    var temp = a
    a = b
    b = temp
}

var someInt1 = 3
var someInt2 = 7
swapTwoInts(&someInts1, &someInts2)

/*------------------------------------------*/

/// - Fuction Types
/// 모든 함수는 타입을 갖는다.
/// 함수의 타입은 매개변수의 타입, 리턴 타입으로 표현된다
/// 예를 들어 다음 2개의 함수는 모두 (Int, Int) -> Int 타입을 가진다.
func addTwoInts(_ a: Int, _ b: Int) -> Int{
    a+b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int{
    a*b
}

/// 또한 아래의 함수는 () - > Void 타입이다.
func fuction(){
    
}

/// 함수의 타입이 존재하므로, 이를 변수나 상수에 할당할 수 있다.
var mathFuction : (Int, Int) -> Int = addTwoInts
print("result is \(mathFuction(2,3))") // result is 5

/// mathFuction 은 변수이므로 동일한 함수 타입을 갖는 multiplyTwoInts 함수를 할당할 수 있다.
mathFuction = multiplyTwoInts

/// 스위프트의 타입 추론은 함수의 타입에 대해서도 가능하다.
/// 아래의 상수의 경우 (Int, Int) -> Int 타입으로 추론된다.
let adder = addTwoInts

/// 함수의 타입이 존재하므로, 함수의 인자에 또 다른 함수를 전달할 수 있다.
func printMathResult(_ mathFuction: (Int, Int) -> Int, _ a: Int, _ b: Int){
    print("Result is \(mathFuction(a,b))")
}

/// 마찬가지로 함수의 타입이 존재하므로 인자가 아닌 리턴으로 사용할 수 있다.
func stepForword(_ input: Int) -> Int{
    input + 1
}

func stepBackword(_ input: Int) -> Int{
    input - 1
}

func chooseStepFuction(backword: Bool) -> (Int) -> Int{
    
    backword ? stepBackword : stepForword
}

let currentValue = 3
let moveNearerToZero = chooseStepFuction(backword: current > 0) // moveNearerToZero's type is (Int) -> Int and refers stepBackword

/// 움직인 횟수를 출력해보자
print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!

/*------------------------------------------*/

/// - Nested Functions
/// 함수 내의 함수가 정의 가능하다.
func chooseStepFuction(backword: Bool) -> (Int) -> Int{
    func stepForword(_ input: Int) ->Int{ input + 1}
    func stepBackword(_ input: Int) ->Int{ input - 1}
    return backword ? stepBackword : stepForword
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
