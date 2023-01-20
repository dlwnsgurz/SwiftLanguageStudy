//
//  Inheritance.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/10.
//

import Foundation

// - Topic: Inheritance
///
/// 스위프트에서 클래스는 상속기능을 제공한다.
/// 서브스크립트, 메소드, 프로퍼티를 모두 오버라이드 할 수 있다.
/// 또한, 프로퍼티 감시자는 상속한 모든 프로퍼티에 연결할 수 있다.

/// - Defining a Base Class
/// 자바나, ObjC의 클래스는 최상위 클래스를 상속하지만, 스위프트는 그렇지 않다.
/// 아무것도 상속하지 않는 클래스를 만들었다면, 그 클래스를 Base Class라고 한다
class Vehicle{
    var currentSpeed = 0.0
    var description: String{
        return "traveling at \(currentSpeed)miles per hours"
    }
    
    func makeNoise(){
        
    }
}

/*------------------------------------------*/

/// - Subclassing
/// 하위 클래스는 상위 클래스의 메소드, 프로퍼티등을 모두 가진다.
class Bicycle: Vehicle{
    var hasBraket = false
}

let someBicycle = Vehicle()

/*------------------------------------------*/

/// - Overriding
/// 상위 클래스의 인스턴스 메소드, 타입 메소드, 인스턴스 프로퍼티, 타입 프로퍼티를
/// 하위 클래스에서 재정의해 다른 동작을 수행하도록 변경할 수 있다.
/// override 키워드를 붙이면 가능하며, 이는 키워드를 붙이면 컴파일러가 확인한다.
/// 오버라이딩을 했지만, 상위 클래스의 메소드, 프로퍼티등에 접근하고자 한다면
/// super.method(), super.property, super[someIndex]

/// 메소드 오버라이딩은 다음과 같이 할 수 있다.
class Train: Vehicle{
    override func makeNoise() {
        print("Choo Choo")
    }
}

/// 모든 프로퍼티를 연산 프로퍼티로 오버라이딩 할 수 있다.
/// 하지만, 상위 클래스에서 읽기 전용 프로퍼티였던 경우에 읽기-쓰기 전용 프로퍼티로 오버라이딩 할 수 없다.
class Car: Vehicle{
    var gear = 1
    override var description: String{
        return super.description + "in gear : \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// Car: traveling at 25.0 miles per hour in gear 3

/// 마찬가지로, 모든 프로퍼티에 프로퍼티 감시자를 붙여 재정의 할 수 있다.
/// 단, 읽기 전용 연산 프로퍼티는 값의 변경이 안되기 때문에 프로퍼티 감시자를 붙여 오버라이딩 할 수 없다.
/// 또한 상수 프로퍼티에 프로퍼티 감시자를 붙여 오버리이딩 할 수 없다.
class AutomaticCar: Car{
    override var currentSpeed: Double{
        didSet{
            gear = Int(currentSpeed / 1.0) + 1
        }
    }
}

/*------------------------------------------*/

/// - Preventing Overrides
/// final 키워드를 메소드, 프로퍼티 등의 앞에 붙혀 오버라이딩을 금지 시킬 수 있으며,
/// 만약 시도하는 경우 컴파일 에러가 발생한다.
/// 만약 클래스 전체를 오버리이딩을 못하게 하고자 한다면 class 키워드 앞에 final을 붙히면 된다.
