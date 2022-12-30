//
//  main.swift
//  SwiftPractice
//
//  Created by LEE on 2022/12/28.
//

import Foundation

// Topic : Costant & Variable

/// - Declaring Constant and Variable
///
/// - Note
/// 상수는 미래에 변할 가능성이 없는 데이터를 저장할 때 사용하며,
/// 변수는 미래에 언젠간 변할 가능성이 있는 데이터를 저장할 때만 사용해야한다.
///

/// 최대 로그인 횟수는 변하지 않으므로 상수로 선언
let maximumNumberOfLoginAttempt = 10

/// 현재 로그인 횟수는 언젠가 증가하므로 변수로 선언
var currentLoginAttempt = 0

/// 다음과 같이 콤마(,)를 통해 한 줄에 변수나 상수를 선언할 수 있다.
var A = 10, B = 20, C = 4.5

/*------------------------------------------*/
/// - Type Annotation

/// 변수나 상수에 쿨론(:)을 통해 타입 지정을 할 수 있다.
/// 이는 welcomeMessage 변수에 어느 문자열이건 저장될 수 있음을 의미한다.
var welcomeMessage: String
welcomeMessage = "Hello"

/// 콤마(,) 를 통해 여러 상수나 변수에 대해 타입 지정을 할 수 있다.
var red, green, blue: Double
/*------------------------------------------*/
/// - Naming Constants and Variables

/// 변수나 상수는 숫자로 시작할 수 없다.
/// 변수나 상수는 저장된 값을 변경하기 위해 동일한 이름으로 재선언 될 수 없다.
/// 변수나 상수의 이름에는 유니코드문자가 올 수 있다.

/// - Note :
///  Swift에 미리 지정된 키워드로 변수나 상수이름을 저장할 수 있다. ` ` 로 감싸면 가능하다. 하지만 강제되는 상황이 아니라면 무조건 피하는 것이 좋다.
var 😀 = "Smile"

/*------------------------------------------*/

/// - Printing Constants and Variables

/// print(_seperator: terminates:) 함수를 통해 변수나 상수에 저장된 값을 확인할 수 있다.
/// 만약 개행을 하고 싶지 않다면 terminates = "" 를 전달함으로써 개행을 안할 수 있다.
/// 이는 default 값으로 개행 값을 print() 함수가 갖기 때문이다.
let greetingInFrench = "Bonjour!"
print(greetingInFrench) // prints Bonjour!

/// 만약 문자열과 함께 상수나 변수에 저장된 값을 함께 출력하고 싶다면?
print("hello in French is \(greetingInFrench)")

/*------------------------------------------*/

/// - Comments

/// /* 주석 */ 을 통해 여러줄 주석을 수행할 수 있으며,
/// /*주석/*주석2*/*/ 과 같이 중첩된 주석을 사용할 수 있다.

/*------------------------------------------*/

/// - Semicolons

/// 스위프트는 주석을 사용할 필요가 없다.
/// 하지만, 둘 이상의 명렁어를 한 줄에 쓰기 위해선 Semicolon을 사용해야한다.
let cat = "🐈"; print(cat)

///  - Integer

/// 스위프트에서 정수형은 Signed와 Unsigned로 나뉠 수 있다.
/// 또한 각각에 대해 비트 폼을 정할 수 있다.(8, 16, 32, 64)

/// 32비트 체제에서는 UInt는 UInt32와 같다.
/// 64비트 체제에서는 UInt는 UInt64와 같고, 이는 Int도 마찬가지다.
 
/// 다음 property를 통해 최대값, 최소값을 구할 수 있다.
let maxValue = UInt8.max
let minValue = UInt8.min

/// - Note :
/// 일반적으로 음수일 가능성이 없는 정수값을 저장하는 경우에도 UInt 자료형보다는
/// Int 자료형을 사용하는 것이 일반적이고, 이는 스위프트의 타입 추론에서도 적용된다.

/*------------------------------------------*/

/// - Type Inference

/// 스위프트의 타입추론 기능을 통해 우리는 변수나 상수를 선언할 때 수고를 줄일 수 있다.

/// 정수의 경우에는 Int 형으로 타입이 추론된다.
let myAge = 25

/// 실수의 경우에는 항상 Double 형으로 타입이 추론된다.
let myHeight = 174.8

/// 이 경우에는 Double 형으로 값이 추론된다.
let PI = 3 + 0.141414

/*------------------------------------------*/

/// - Numeric Literal

/// 정수 리터털 표현방법은 크게 4가지이다.
/// 1. 통용되는 리터럴 방식
/// 2. 0b prefix를 이용한 2진수
/// 3.0o prefix를 이용한 8진수
/// 4. 0x prefix를 이용한 16진수

let decimalInteger = 12321
let binaryInteger = 0b10010
let octalInteger = 0o153742
let hexadecimalInteger = 0x15F35d

/// 실수 리터럴 표현방법은 크게 3가지이다.
/// 1. 통용되는 리터럴 방식
/// 2. 10진수 지수 표현방식(e, E)
/// 3. 16진수 지수 표현방식(p, P)

let decimalDouble = 312.42
let exponentDouble = 32.2e5
let hexadecimalDouble = 0xf.ap4

/// 또한 숫자 리터럴은 읽기 쉽도록 _ 나 0 을 추가할 수 있다.

let paddedDouble = 000123.456
let oneMillion = 1_000_000

/*------------------------------------------*/

/// - Numeric Type Conversion

/// UInt8과 같은 특수한 정수형 타입은 저장할 수 있는 값의 범위가 정해져있다.
/// 따라서 특수한 경우에만 사용하는 것이 적절하며, 이를 통해 코드의 의도를 쉽게 파악할 수 다.

/// 타입() 생성자를 통해 형변환이 가능하며, 이는 생성자의 인자에 여러 타입이 미리 정의되어
/// 있음을 알 수 있다.
/// extension 키워드를 통해 우리가 이것을 직접 확장할 수 있다.
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

/// 실수와 정수 사이의 변환도 마찬가지이다.
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine

/// 부동 소수점을 정수로 변환하는 경우에는 무조건 버림 연산을 수행한다.
let piInteger = Int(pi) // piInteger equals 3

/*------------------------------------------*/

/// - Type Alias

/// 타입에 새로운 별칭을 부여할 수 있다.
/// typealias 키워드를 통해 타입의 별칭을 지정할 수 있다.

typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

/*------------------------------------------*/

/// - Booleans

/// 변수나 상수를 선언할 때 스위프트의 타입 추론 기능으로 인해 타입 지정을 할 필요 없다.
/*------------------------------------------*/

/// - Tuples
///
/// 튜플은 주로 함수의 리턴값으로 여러 개의 값을 리턴할 때 유용하게 사용할 수 있다.
///
/// 튜플에서 개별의 값을 분해할 때 크게 3가지 방법이있다.
let http404Error = (404, "Not Found")

// 첫번째 방법, 언더케이스(_)로 불필요한 값은 분해하지 않을 수 있다.
let (errorCode, descrption) = http404Error
let (errorCodeRetrived, _) = http404Error

// 두번째 방법, 인덱스를 통한 접근 방법
let errorNumber = http404Error.0
let errorMessage = http404Error.1

// 세번째 방법, 선언시에 이름을 지어줄 수 있다.
let http200Error = (statusCode: 200, description: "OK")

let code = http200Error.statusCode
let message = http200Error.description

/*------------------------------------------*/

/// - Optional
///
/// 스위프트에서 옵셔널은 모든 타입에 적용이 가능하다.
/// 옵셔널은 다음 2가지를 의미한다.
/// 첫번쨰, 값을 가지고 있다
/// 두번째, 값을 가지고 있지 않다.

/// convertNumber의 타입은 Int가 아닌 Int?로 추론된다.
/// 문자열 "123" 은 123 리터럴로 변환이 가능하지만 "hello" 같은 경우에는
/// 정수로 바꿀 수 없다. 따라서 nil이 들어갈 수 있도록
/// 옵셔널로 타입 추론이 된다.
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

/// 옵셔널이 아닌 타입에는 nil이 들어갈 수 없다.
/// 만약 초기값 없이 옵셔널 타입으로만 선언한다면 자동으로 nil이 저장된다.
/// - Note: nil은 값이 아니라 값이 없는 상태를 의미한다.
var serverResponseCode: Int? = 404
serverResponseCode = nil

/// nil이 저장된다.
let serverAnswer: String?

/// 옵셔널 타입에서 값을 추출하는 3가지 방법
/// 첫번째는 if조건문과 강제 언래핑을 이용하는 방법으로
/// 만약, nil이 들어있는 경우에 강제 언래핑을 한다면 런타임에러가 발생한다.
if convertedNumber != nil{
    print("convertNumber contains some integer")
}

if convertedNumber != nil{
    print("convertedNumber is \(convertedNumber!)")
}

/// 두번째는 옵셔널 바인딩으로, if let 구문을 이용해 시행한다.
/// 옵셔널 바인딩은 블록 내에서만 값의 변경이 가능하므로 guard구문과 차이가 있다.

if let actualNumber = Int(possibleNumber){
    print("possibleNumber is \(actualNumber)")
}

let myNumber = Int(possibleNumber)
if let myNumber = myNumber{
    print("my number is \(myNumber)")
}
/// 다음과 같이 줄일 수 있다.
if let myNumber{
    print("my number is \(myNumber)")
}

/// 옵셔널 바인딩은 조건문과 함께 사용할 수 있으며,
/// 콤마(,)를 통해 구분한다.
/// 또한 nil이나 조건이 false인 경우 탈출한다.
if let firstNumber = Int("4"), let secondNumber = Int("123"), firstNumber < secondNumber{
    print("\(firstNumber) < \(secondNumber)")
}

/// 상수뿐만 아니라 변수로도 옵셔널 바인딩이 가능하지만,
/// 이 경우에는 원본값의 변경이 일어나지 않는다.
if var mySecondNumber = myNumber{
    print("available")
}
/// 세 번째는 암시적 추출 옵셔널이다.
/// 암시적 추출 옵셔널은 타입명뒤에 ?가 아닌 !가 붙는다.
/// 암시적 추출 옵셔널은 nil이 될 수 있는 타입이지만, nil이 되지 않을 확실한 상황인 경우에 사용한다.

let possibleString: String? = "An Onptional String"
let forcedString: String = possibleString!

let assumedString: String! = "An implicitly unwrapped optional String"
let implicitString: String = assumedString

/// 스위프트는 암시적 추출 옵셔널을 처리하는 순서가 있다.
/// 처음에는 반드시 암시적 추출 옵셔널도 일반 옵셔널으로 처리한다.
let optionalString = assumedString // optional type

/// 하지만 일반 옵셔널로 처리할 수 없는 경우에는 내부 값으로 인해 변경된다.
let valueString: String = assumedString // 이 경우에는 valueString이 String 타입이므로 값이 벗겨진다.

/*------------------------------------------*/

/// - Error Handling
///
/// swift의 에러 핸들링은 do 구문 내에서 이루어진다.
/// 따라서, 발생하는 여러 케이스의 에러에 대해 catch문으로 분기하여 개별적으로 처리할 수 있다.

func canThrowError() throws{
    
}

do{
    try canThrowsError()
    // no error was thrown
    catch{
    // an error was thrown
    }
}

func makeASandwich() throws{
    // ...
}

do{
    try makeASandwich()
    eatSandwich()
    catch SandwichError.outOfCleanDishes{
        washDishes()
    }
    catch SandwichError.missingIngredients(let buyGroceries(ingredients)
}
