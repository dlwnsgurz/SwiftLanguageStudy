//
//  Strings and Characters.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/02.
//

import Foundation

// - Topic : Strings and Characters
///
///
///

/// - Strings Literals
///
/// String 타입의 리터럴은 큰 따옴표 ("")로 감싸서 표현할 수 있다.
/// 만약, 내용이 많아 여러줄로된 리터럴을 만들려면 큰따옴표 3개로 감싸면 된다.
let multilineStringLiteral = """
    Hello My Name Is LEE
    I'm Living in Seoul
    
    Thank You.
"""

/// 만약 줄 바꿈 없이 만들려면? \ 를 이용하면 된다.
let mulitilineStringLiteral2 = """
    Hello My Name Is LEE \
    I'm Living in Seoul
    
    Thank You.
"""

/// String 타입의 문자 하나는 유니코드로 표현된다.
/// 이는 \u{1-8자리의 16진수} 로 접근할 수 있다.
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"

/// 만약 문자열 내의 특수 리터럴 문자들 효과를 적용하기 싫다면 ""를 #문자로 감싸면 된다.
var greeting = #"hello "my name is Lee""#

/// - Initializing an Empty String
/// 빈 문자열을 만드는 방법은 2가지이며, 둘은 동일한 문자열을 갖는다.
let emptyString = ""
let emptyString2 = String()

/// - String Mutability
/// 상수로 선언된 문자열은 컴파일 에러가 발생한다.
let nonMutabilityString = "hello"
nonMutabilityString += "deer"


/// - Strings are Value Type
/// 스위프트의 문자열은 값 타입으로 함수나 메소드에 인자로 전달되어 변경된 경우,
/// 원본의 값은 변하지 않는다.

/// - Working with Character
/// for - loop 로 문자열을 순회할 수 있다.
/// 각 문자는 Character 타입이다.
for char in "Dog!"{
    print(char)
}
// D
// o
// g
// !

/// 문자열을 Type Annotation과 함께 Character로 둘 수 있다.
let characterD: Character = "D"

/// Character 배열을 인자로 전달하여 문자열을 생성할 수 있다.
let characters: [Character] = ["h","e","l","l","o"]
let greetingString = String(characters)

/// - Concatenating Strings and Characters
/// String 타입은 + 연산자를 통해 concatenating할 수 있다.
/// 또한 append() 메소드를 이용해 String, Character 타입의 값을 붙힐 수 있다.
var helloString = "hello"
let tempCharacter: Character = "!"
helloString.append(tempCharacter)
helloString.append("!!")

/// - String Interpolation
/// 만약 문자열 보간법을 사용하고 싶다면, \(값)을 사용하면 된다.

/// - Unicode
/// 문자열내의 각 문자들은 아스키 코드가 아닌 유니코드이다.
/// 하나의 문자열은 여러개의 서로다른 유니코드 문자들로 쪼개질 수 있다.
/// 예) 한글, 국기

/// - Counting Characters
/// 문자열 내의 문자의 개수는 count 프로퍼티르 얻어낼 수 있다.
/// 하지만, 유니코드의 특성때문에 문자열 내의 문자의 수를 계산하기 위해서는 반드시 문자열을 순회해야한다.
/// 따라서, count 프로퍼티는 그 자체로 O(N)의 시간복잡도를 가진다.

/// - Accessing and Modifying a String
/// 위에 언급했듯이, 스위프트의 문자열은 유니코드의 특성때문에 정수 인덱스로 접근할 수 없다.
/// 대신 String.Index로 접근할 수 있다.
/// startIndex와 endIndex가 같다면, 빈 문자열이다.
let greetingInGerman = "Guten Tag!"
greetingInGerman[greetingInGerman.index(after: greetingInGerman.startIndex)] // u
greetingInGerman[greetingInGerman.index(before: greetingInGerman.endIndex)] // !
greetingInGerman[greetingInGerman.startIndex] // G
greetingInGerman[greetingInGerman.index(greetingInGerman.startIndex, offsetBy: 4)] // n
let index = greetingInGerman.index(greeting.startIndex, offsetBy: 7)
greetingInGerman[index] // a

/// 만약 범위 밖의 문자에 접근하면 런타임 에러가 발생한다.
greetingInGerman[greeting.endIndex]
greetingInGerman.index(after: greeting.endIndex)

/// indices 프로퍼티로 String.Index를 순서대로 뽑아낼 수 있다.
for index in greetingInGerman.indices{
    print("\(greetingInGerman[index]) in Guten Tag!", terminator: "")
}

/// - Note:
/// startIndex, endIndex 프로퍼티와 index(before:), index(after: ) 메소드는 Collection 프로토콜을 따르는 클래스에서 사용할 수 있다.
/// Array, Dictionary, Set이 그 예다.

/// 문자열이나 문자를 삽입하는 방법
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex) // 문자 삽입. hello!
welcome.insert(contentsOf: "there", at: welcome.index(before: welcome.endIndex)) // hello there!

/// 문자열이나 문자를 삭제하는 방법
welcome.remove(at: welcome.index(before: welcome.endIndex)) // hello there
let range = welcome.startIndex..<welcome.index(welcome.startIndex, offsetBy: 3)
welcome.removeSubrange(range)

/// - Note: insert(at:), insert(contentsOf,at), remove(at:), removeSubrange() 메소드는
/// RangeReplacableCollection 프로토콜을 따르는 클래스에서 사용할 수 있다.
/// Array, Dictionary, Set이 그 예다.

/// - Substring
/// String 타입은 문자열들이 저장되는 메모리가 따로 존재한다.
/// SubString 타입은 String타입이나, 다른 SubString 타입들이 존재하는 메모리를 재활용한다.
/// 따라서, Substring을 오래사용하는 경우 String 타입으로 변환해주어야 메모리 손실이 덜 하다.
/// String과 Substring 은 모두 StringProtocol을 따른다.

/// - Comparing Strings
/// 스위프트에서 문자열을 비교하는 방법은 3가지이다.
/// 첫번째는 문자들 비교이다.
/// 유니코드의 값 비교가 아니라, 언어적 의미가 동일하다면 이는 같은 문자여롤 취급한다.
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
print(eAcuteQuestion == combinedEAcuteQuestion) // true

/// 하지만, 영어에서 사용하는 "A"와 ,러시아에서 사용하는 "A"는 언어적 의미가 다르다.
/// 게다가 유니코드 값 까지 다르다. 따라서, 이는 같은 문자가 아니다.

/// 두번째 문자열 비교 방식은 hasPrefix, hasSuffix방식으로 위의 방식과 동일한 로직을 이용한다.

/// - Unicode Representation Of Strings
/// 문자열 내에 유니코드로 접근할 수 있다.
/// 8비트의 utf8, 16비트의 utf16, 32비트의 utf32 형식으로 접근이 가능하다.

let dog = "Dog!!🐶"

/// UTF8 방식은 UInt8의 Collection인 String.UTF8View 타입.
for codeUnit in dog.utf8{
    ///
}

/// UTF16 방식은 UInt16의 Collection인 String.UTF16View 타입.
for codeUnit in dog.utf16{
    ///
}

/// UTF32 방식은 unicodeScalr의 Collection인 UnicodeScalarView 타입.
/// 각 unicodeScalar는 21비트이며, UInt32로 이루어져있다.
for codeUnit in dog.unicodeScalars{
    print(codeUnit.value)   //  유니코드 스칼라 값
    print(codeUnit) // 유니코드 문자
}
