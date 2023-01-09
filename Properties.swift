//
//  Properties.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/09.
//

import Foundation

// - Topic: Properties
///
/// 스위프트 언어에서 프로퍼티는 다른 언어에서 멤버와 비슷한 역할을 한다.
/// 클래스, 구조체, 열거형에서는 값을 계산해주는 계산 프로퍼티를 사용할 수 있다.
/// 연산 프로퍼티는 저장 프로퍼티와 다르게 값만 계산해주고, 이 프로퍼티는 클래스, 구조체에서만 사용할 수 있다.

/// - Stored Properties
struct FixedLengthRange{
    var startPage: Int // 가변 저장 프로퍼티
    let length: Int // 상수 저장 프로퍼티
}

/// startPage는 변경이 가능하지만, length는 변경이 불가능하다.
var somePage = FixedLengthRange(startPage: 6, length: 3) // 6,7,8
somePage.startPage = 4 // 4,5,6

let somePage2 = FixedLengthRange(startPage: 2, length: 4) // 2,3,4,5
// 구조체는 값타입이기 떄문에 인스턴스를 let으로 선언하면 가변 저장 프로퍼티라도 값의 변경이 불가능하다.


/// 지연 저장 프로퍼티는 lazy 키워드를 통해 선언할 수 있다.
/// 지연 저장 프로퍼티는 let아닌 var로 선언해야 하는데 이는 지연저장 프로퍼티는 값을 항상 갖고 있지 않고 최초 접근시에만 값이 생성되기 때문이다.
/// 따라서 복잡한 작업이 필요한 경우 지연 저장 프로퍼티를 이용해 시간을 줄일 수 있다.
class DataImporter{
    // 이 클래스를 초기화하는데 매우 많은 시간이 소요된다고 하자.
    var fileName = "file.txt"
}


class DataManager{
    lazy var dataImporter = DataImporter()
    var data: [String] = []
}

let dataManager = DataManager()
print(dataManager.data.append("hello"))
print(dataManager.dataImporter.fileName) // DataManager에 dataImporter가 초기화된다. 최초 접근 했기 때문.

/// - Note: 만약 멀티스레드상황에서 지연 저장 프로퍼티에 접근해 초기화가 시도 된다면, 초기화가 한번만 된다는 것을 보장할 수 없다.

/*------------------------------------------*/

/// - Computed Properties
/// 저장 프로퍼티는 실제 값을 저장하지 않고 연산을 통해 return 해준다.
/// 모든 저장 프로퍼티는 반드시 var로 선언해야 한다.
/// getter와, 옵션에따라 setter를 설정할 수 있다.
/// 클래스, 구조체, 열거형에서 사용할 수 있다.
struct Point{
    var x = 0.0, y = 0.0
}

struct Size{
    var width = 0.0, height = 0.0
}

struct Rect{
    var origin = Point()
    var size = Size()
    var center: Point{
        get{
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point(x: centerX, y:centerY)
        }set(newCenter){
            origin.x = newCenter.x - size.width / 2
            origin.y = newCenter.y - size.height / 2
        }
    }
}

var square = Rect(origin: Point(x: 10, y: 10), size: Size(width: 10, height: 10))
let initialSquareValue = square.center // 15.0, 15.0

square.center = Point(x:15, y:15) // 10.0, 10.0

/// 스위프트에서 계산 프로퍼티의 setter에 인자를 전달하지 않았다면, 자동으로 newValue이름이 할당되어 접근할 수 있는 Shorthand Form을 제공한다.

struct AlternativeRect{
    var origin = Point()
    var size = Size()
    var center: Point{
        get{
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point(x: centerX, y: centerY)
        }set{
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

/// 전에 말햇듯이 return문까지 한 문장으로 작성한다면, return을 생략할 수 이싿.
struct CompactRect{
    var origin = Point()
    var size = Size()
    var center: Point{
        get{
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }set{
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

/// 읽기 전용 계산 프로퍼티또한 가능하다.
/// 반드시 var키워드를 통해 선언해야한다.
/// volumn의 경우 가로, 세로, 높이에 종속적이다. 따라서 읽기 전용으로 선언하여 임의로 값의 변경이 불가능하다.
struct Cuboid{
    var height = 0.0, width = 0.0, depth = 0.0
    var volumn: Double{
        height * width * depth // 읽기 전용 계산 프로퍼티는 get,set 모두 생략으로 선언이 가능하다.
    }
}

/*------------------------------------------*/

/// - Property Observers
/// 프로퍼티 옵저버는 프로퍼티의 값의 변화를 살필 수 있다.
/// 값의 변화를 관찰하는 것이 목적이기 때문에, 연산 프로퍼티에는 사용이 불가능하다. 왜냐하면 연산프로퍼티는 set에서 관찰할 수 있기때문이다.
/// 만약 동일한 값으로 변경이 된다고 해도 프로퍼티 옵저버는 이를 관찰한다.
/// wiiSet, didSet으로 저장 프로퍼티에 프로퍼티 옵저버를 붙힐 수 있다.
/// willSet은 값이 변화하기 직전에 호출되며, 상수 인자를 전달할 수 있으며, 전달하지 않은 경우에는 자동으로 newValue이름이 붙는다.
/// didSet은 값이 변화하고난 직후에 호출되며, 상수 인자를 전달할 수 있으며, 전달하지 않은 경우에는 자동으로 oldValue이름이 붙는다.
/// 상속받은 저장 프로퍼티에도 옵저버를 붙힐 수 있으며, 만약 상속 받은 연산프로퍼티라면 옵저버를 붙힐 수 있다.
/// - Note: 부모 클래스에 붙어있는 프로퍼티 옵저버는 부모 클래스의 초기화가 이루어진 후 값의 변화를 살필 수 있다.

class StepCounter{
    var totalStep: Int = 0{
        willSet{
            print("총 발걸음 수가 \(newValue) 발자국으로 변경될 예정입니다.")
        }didSet{
            if totalStep > oldValue{
                print("총 발걸음 수가 \(totalStep - oldValue) 발자국 늘어났습니다.")
            }
        }
    }
}

let stepCounter = StepCounter()

// 총 발걸음 수가 200 발자국으로 변경될 예정입니다.
stepCounter.totalStep = 200
// 총 발걸음 수가 200 발자국 늘어났습니다.

// 총 발걸음 수가 360 발자국으로 변경될 예정입니다.
stepCounter.totalStep = 360
// 총 발걸음 수가 160 발자국 늘어났습니다.

/// - Note: 만약 함수의 in-out 인자에 옵저버가 있는 프로퍼티를 전달하면 항상 willSet, didSet이 호출된다.
/// 왜냐하면,  값의 복사/ 덮어쓰기가 일어나기 때문이다.

/*------------------------------------------*/

/// - Property Wrappers
/// 프로퍼티 래퍼는 프로퍼티를 감싼다는 의미이다.
/// 이는 여러 프로프티에 대해 중복된 연산이 필요한 경우, 유용하게 사용될 수 있다.

@propertyWrapper
struct TwelveOrLess{
    var number: Int = 0
    var wrappedValue: Int{
        get{ number }
        set{ number = min(newValue, 12) }
    }
}

struct SmallRectagle{
    @TwelveOrLess var width: Int
    @TwelveOrLess var height: Int
    
}
// 위와 아래는 동일한 경우이다. 만약 프로퍼티 래퍼가 없다면, 아래처럼 코드를 작성해야하며, 동일한 연산을 해야하는 경우가 많아진다면, 이는
// 매우 불편해진다.
struct SmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}


var smallRectagle = SmallRectagle()
smallRectagle.width = 14 // 12
smallRectagle.height = 14 // 12

/// 위의 프로퍼티 래퍼의 경우 인스턴스를 생성할 때 값이 항상 0으로 초기화된다.
/// 따라서, 프로퍼티 래퍼에서 생성자를 정의해 이를 해결할 수 있다.

@propertyWrapper
struct SmallNumber{
    var number: Int
    var maximum: Int
    var wrappedValue: Int{
        get{ number}
        set{ number = min(newValue, 12)}
    }
    init(){
        number = 0
        maximum = 12
    }
    init(wrappedValue: Int){
        number = min(wrappedValue, 12)
        maximum = 12
    }
    init(wrappedValue: Int, maximumNumber: Int){
        number = min(wrappedValue, 12)
        self.maximum = maximumNumber
    }
        
}

struct UnitRectangle {
    @SmallNumber var height: Int = 1 // var height: SmallNumber = SmallNumber(wrappedValue: 1)
    @SmallNumber var width: Int = 1 // var width: SmallNumber = SmallNumber(wrappedValue: 1)
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// Prints "1 1"

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

/*------------------------------------------*/
 
/// - Global and Local Variables
/// 프로퍼티감시자(willSet,didSet)나 연산 프로퍼티의 경우 지역변수나 전역변수 모두에서 사용할 수 있다.
/// 하지만, 프로퍼티 래퍼의 경우, 지역변수나 연산 변수에 사용할 수 없다.
/// 지역 상수와 지역 변수는 지연 저장 되지 않지만, 전역 상수나 변수는 지연 저장된다.

/*------------------------------------------*/

/// - Type Properties
/// 타입 프로퍼티는 타입에 종속된 프로퍼티이다.
/// 인스턴스가 몇개가 있는 타입 프로퍼티는 하나만 존재한다.
/// 타입 저장 프로파티느 지연 저장 기능이 있기때문에 최초 접근시에 초기화된다.
/// 또한, 여러 쓰레드에서 동시에 접근해도 초기화가 단 한번된다.
/// 타입 저장 프로퍼티는 열거형에서도 사용 가능하다.

struct SomeStructure{
    var structTypeProperty = "구조체 타입 저장 프로퍼티"
    var structTypeComputedProperty : Int{
        return 1 // 읽기 전용 연산 프로퍼티
    }
}

enum SomeEnumertation{
    var enumTypeProperty = "열거형 타입 저장 프로퍼티"
    var enumTypeComputedProperty: Int{
        return 3 // 읽기 전용 연산 프로퍼티
    }
}

class SomeClass{
    var classTypeProperty = "클래스 타입 저장 프로퍼티"
    var classTypeProperty: Int{
        return 5
    }
    var
}

/// 타입 프로퍼티를 다음과 같이 이용할 수 있다.
class AudioChannel{
    static let thresholdLevel = 10
    static var maximumChannelLevel = 0
    var currentLevel: Int = 0{
        didSet{
            if currentLevel > AudioChannel.thresholdLevel{
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maximumChannelLevel{
                AudioChannel.maximumChannelLevel = currentLevel
            }
        }
            
    }
}
