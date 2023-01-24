//
//  Access Control.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/25.
//
import Foundation

// - Topic: Access Control

/// 스위프트에서는 클래스, 구조체, 열거형 또는 사용자 정의 타입에 대한 접근 제어 수준을 설정할 수 있다.
/// 타입 자체에 대한 접근 제어 수준뿐만 아니라, 내부의 메소드, 서브스크립트, 프로퍼티에 대해서도 접근 제어 수준을 설정할 수 있다.
/// 스위프트는 기본 접근 제어 수준을 제공해주므로, 단일 앱을 작성하는 경우에 이에 대해 신경쓸 필요는 없다.

/// - Modules and Source Files
/// 스위프트에서 접근 제어 모델은 모듈과 소스파일을 기본으로 한다.
/// 모듈이란, 단일 단위로 빌드되고 제공되는 프레임워크나 어플리케이션을 의미한다.
/// 스위프트의 import문을 통해 다른 모듈을 빌드에 추가할 수 있다.
/// 소스파일은 하나의 모듈을 구성하는 .swift 형식의 파일로, 하나의 모듈에는 여러 개의 소스파일이 존재할 수 있다.

/*------------------------------------------*/

/// - Access Levels
/// 스위프트에서는 5개의 접근 제어 수준을 제공한다.
/// 첫번째와 두번째는 open과 public으로, 외부 모듈에서도 사용 가능하다.
/// 세번째는 internal로, 모듈 내부에서만 사용 가능하다.
/// 네번째는 file-private으로, 정의한 소스코드 파일 내부에서만 사용 가능하다.
/// 다섯번째는 private으로, 정의 내부에서만 사용 가능하다.
/// - Note: 스위프트에서는 public 변수를 internal, fileprivate 타입을 지정할 수 없다.
/// 즉, 더 높은 접근 제어 수준을 갖도록 정의할 수 없다.
/// 또한, 함수의 경우에도 매개변수나 반환타입보다 더 높은 제어 수준의 타입을 지정할 수 없다.
/// 예) 매개변수나 반환타입이 public이지만, 함수 자체를 private으로 정의할 수 없다.

/*------------------------------------------*/

/// - Access Control Syntax
/// 엔터티의 선언 시작 부분에 접근 제어 수준 키워드를 붙여 접근 제어 수준을 지정할 수 있다.
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

/// 만약 접근 제어 수준을 명시하지 않았다면, 자동으로 internal 접근 제어 수준으로 지정된다.
class SomeInternalClass {}              // implicitly internal
let someInternalConstant = 0            // implicitly internal

/*------------------------------------------*/

/// - Custom Types
/// 사용자 정의 타입에도 접근 제어 수준을 지정하려면, 선언 시작 부분에 명시하면 된다.
/// 타입 자체에 대한 접근 제어 수준이 타입 내부의 프로퍼티와 메소드 등에도 자동으로 지정된다.
/// 하지만, public 접근 제어 수준의 타입을 정의하는 경우에는 타입 내부 멤버들은 자동으로 internal 접근 제어 수준이 지정된다.
/// 이는, API를 정의하는 경우 내부 구현을 숨길 수 있도록 하기 위해서이다.
public class SomePublicClass {                  // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class SomeInternalClass {                       // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass {        // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass {                // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

/// 튜플 타입의 경우, 명시적으로 구현된 타입이 아니다.
/// 따라서, 튜플 타입의 접근 제어 수준은 가장 제한된 접근 제어 수준을 갖도록 지정된다.
/// 예를 들어, 한 원소가 fileprivate이고, 다른 원소는 public인 경우 해당 튜플의 접근 제어 수준은 fileprivate이다.

/// 함수 타입의 접근 제어 수준은 매개변수와 반환 타입의 접근 제어 수준에 의해 결정된다.
/// 둘 중 가장 제한적인 접근 제어 수준이 함수 자체의 접근 제어 수준이 되며,
/// 그 접근 제어 수준이 internal이 아닌 이상, 반드시 함수의 정의 맨 앞에 접근 제어 수준을 명시해야 컴파일이 된다.
/// 튜플의 접근 제어 수준이 private이므로, 해당 함수의 접근 제어 수준은 private이어야한다.
func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
}

/// 따라서, private 키워드를 붙여 접근 제어 수준을 명시해야한다. (internal이 아니므로)
/// 만약, 함수의 키워드를 public이나 internal로 한다면 어차피 호출을 올바르게 하지 못하므로 컴파일 에러가 발생한다.
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
}

/// 열거형의 경우에는 내부의 모든 케이스가 동일한 접근 제어 수준을 가져야한다.
/// 아래의 열거형의 경우 모든 케이스의 접근 제어 수준은 public이다.
public enum CompassPoint {
    case north
    case south
    case east
    case west
}

/// 열거형의 연관 값과 원시 값의 경우, 반드시 열거형보다 높은 접근 제어 수준을 가져야한다.
/// 예를 들어, internal 열거형의 경우 연관 값이나 원시 값은 private 접근 제어 수준을 지정될 수 없다.

/// 중첩된 타입의 경우, 이를 포함한 타입의 접근 제어 수준과 동일하다.
/// 단, 포함한 타입의 접근 제어 수준이 public인 경우에 중첩된 타입의 접근 제어 수준은 internal이다.
/// public으로 하고 싶다면, public을 명시해야한다.

/*------------------------------------------*/

/// - Subclassing
/// 기본적으로 상속을 통한 오버라이딩은 더 높은 접근 제어 수준을 가질 수 있다.
/// 하지만, 서브 클래스가 슈퍼 클래스보다 더 높은 접근 제어 수준을 가질 수 없다.
/// 예를 들어 internal인 클래스를 상속하는 public 클래스를 정의할 수 없다.
/// 아래의 경우, 서브 클래스의 접근 제어 수준이 internal이다.
/// 하지만, 슈퍼 클래스의 fileprivate 메소드를 서브 클래스에서 internal로 재정의 하고 있다.
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {}
}

/// 상위 클래스의 멤버에 대한 호출이 보장된 상황에서
/// 하위 클래스에서 상위 클래스의 멤버를 호출할 수 있다.
/// 아래의 경우, 같은 파일에서 작성되었으므로 super.someMethod()를 호출할 수 있다.
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

/*------------------------------------------*/

/// - Constants, Variables, Properties, and Subscripts
/// 상수, 변수, 프로퍼티, 서브스크립트는 타입보다 더 높은 접근 제어 수준을 지정할 수 없다.
/// 예를 들어 private 접근 제어 수준의 타입으로 정의된 public 프로퍼티는 불가능하다.
/// internal이 아닌 경우, 반드시 접근 제어 수준을 명시해야한다.
private var privateVariable = SomePrivateClass()

/// 상수, 변수, 프로퍼티, 서브스크립트에 대한 getter와 setter의 접근 제어 수준은 해당 타입을 따라간다.
/// 상수, 변수, 프로퍼티, 서브스크립트에 대해 setter는 getter보다 더 제한된 수준의 접근 제어 수준을 정의할 수 있다.
/// 아래의 구조체는 문자열이 몇 번 수정되었는지 저장 프로퍼티 numberOfEdits로 알 수 있다.
/// numberOfEdits 프로퍼티 자체의 접근 수준은 internal이지만, 쓰기 접근의 경우 private이므로, 해당 구조체 외부에서는 값을 수정할 수 없다.
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

/// 또한, 필요한 경우 프로퍼티의 getter와 setter에 서로 다른 접근 제어 수준을 설정할 수 있다.
/// 아래의 numberOfEdits 프로퍼티의 읽기 접근 수준은 public이지만, 쓰기 접근 수준은 private이다.
public struct TrackedString {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

/*------------------------------------------*/

/// - Initializers
/// 사용자 정의 초기화 구문은 타입 자체의 접근 제어 수준과 같거나 낮아야한다.
/// 하지만, required 초기화 구문은 클래스 자체와 동일한 접근 제어 수준을 가져야 한다.
/// 기본 초기화 구문같은 경우에 internal로 정의되며, 타입 자체가 public인 경우에도 마찬가지다.
/// 따라서, public을 명시해 public 접근 제어 수준을 갖도록 해야한다.

/// 구조체의 멤버 와이즈 초기화 구문은 모든 저장 프로퍼티가 private인 경우 private, filepriavte인 경우, fileprivate이다.
/// 만약, public 구조체의 멤버 와이즈 구문또한 public으로 해두고 싶다면 반드시 public을 명시해야한다.
/// 그렇지 않고, 저장 프로퍼티의 접근 제어 수준이 각기 다르다면 internal 접근 제어 수준을 갖는다.

/*------------------------------------------*/

/// - Protocols
/// 프로토콜에 접근 제어 수준을 설정하고 싶다면, 프로토콜을 정의할 때 명시해야한다.
/// 프로토콜에 명시된 요구 사항은 기본적으로 프로토콜 자체의 접근 제어와 같다.
/// 또한 프로토콜을 따르기 위해서는 프로토콜에 명시된 요구 사항과 같은 접근 제어 수준으로 요구를 만족해야한다.
/// 만약, 기존 프로토콜을 상속하는 새로운 프로토콜을 정의한다면, 하위 프로토콜은 상위 프로토콜보다 더 높은 접근 제어 수준을 설정할 수 없다.
/// 또한, 프로토콜을 구현하는 타입의 경우에 프로토콜의 접근 제어 수준보다 낮은 접근 제어 수준의 타입을 정의할 수 있다.
/// 예를 들어 타입이 public 이지만, 프로토콜이 internal인 경우에 이 해당 타입에 대한 프로토콜의 준수성은 internal이다.
/// 따라서 외부 모듈에서 이 타입은 프로토콜을 준수하지 않는다.

/*------------------------------------------*/

/// - Extensions
