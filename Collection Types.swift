//
//  Collection Types.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/03.
//

import Foundation

// - Topic: Collection Types
///
/// 스위프트의 컬렉션 타입은 3가지다.
/// 첫번째는 Arary로, 순서가 있는 자료구조이다.
/// 두번째는 Set으로, 순서가 없는 자료구조이다.
/// 세번쨰는 Dictionary로, 순서가 없이 key - value 쌍으로 이루어져있다.
/// 스위프트의 컬렉션타입은 정의되지 않은 타입이 저장되는 것을 막으므로, 사용자는 안전하고 자신있게 사용할 수 있다.

/// - Mutablility of Collections
/// 만약 컬렉션 타입 내의 원소들이 추가, 삭제, 변경의 연산이 필요하다면 변수로 선언해야한다.
/// 만약  추가,삭제,변경 연산이 필요하지 않다면 상수로 선언해 성능을 높힐 수 있다.

/*------------------------------------------*/

/// - Arrays
/// 스위프트의 Arrays는 Foundation의 NSArray와 연관이 있다.
/// Array의 생성자는 2가지이다.
/// 주로, 두번째 방법을 선호한다.
let someInts1 : Array<Int> = []
let someInts2 : [Int] = []

/// []리터럴로 빈 Array로 만들 수 있다.
var someInts: [Int] = []
someInts.append(contentsOf: 3)
someInts.append(contentsOf: 4)
someInts = [] // 초기화

/// 반복되는 원소로 Array를 만들 수 있다.
var someDoubles = Array(repeating: 0.0, count: 3) // [0.0, 0.0, 0.0]

/// 동일한 타입의 두 배열을 더해 Array를 만들 수 있다.
var someDoubles2 = Array(repeating: 1.0, count: 3) // [1.0, 1.0, 1.0]
var addedDoubles = someDoubles + someDoubles2 // [0.0, 0.0, 0.0, 1.0, 1.0, 1.0]

/// 동일한 타입의 원소를 가진 Array 리터럴로 만들 수도 있다.
/// 이 경우에는 스위프트의 타입추론으로 인해 [String] 타입이 된다.
var shoppingList = ["Milk", "Soup"]

/// read-only 인 count 프로퍼티를 통해 아이템의 개수를 알 수 있다.
var names = ["Lee", "Shin", "Park", "Kim"]
names.count

/// isEmpty 프로퍼티를 통해 count가 0인지 알 수 있다.
names.isEmpty

/// append() 메소드를 통해 맨 뒤에 원소를 한 개추가할 수 있다.
names.append("Jo") // ["Lee", "Shin", "Park", "Kim", "Jo"]

/// += 연산자를 통해 맨 뒤에 여러 개의 원소를 추가할 수 있다.
names += ["Lim", "Choi"] // ["Lee", "Shin", "Park", "Kim", "Jo", "Lim", "Choi"]

/// 또한 서브스크립트를 이용해 원소에 접근할 수 있다.
let myName = names[0]

/// 서브스크립트로 배열내의 원소를 변경할 수 있다.
names[0] = "Kwak" // ["Kwak", "Shin", "Park", "Kim", "Jo", "Lim", "Choi"]

/// 서브스크립트내의 범위를 통해 여러 개의 원소를 얻을 수 있다.
names[4..6]

/// 서브스크립트내의 범위를 통해 얻은 여러 개의 원소를 또 다른 여러 개의 원소로 변경할 수 있으며,
/// 원소의 개수가 달라도 상관 없다.
names[0...1] = ["Oh", "Yoon", "Jeong"] // ["Oh", "Yoon", "Jeong", "Park", "Kim", "Jo", "Lim", "Choi"]

/// 특정 위치에 원소를 추가하거나, 원소를 삭제하려면
/// insert(at:) 과 remove(at:) 메소드를 이용할 수 있다.
names.insert("Kwon", at: 4) // ["Oh", "Yoon", "Jeong", "Park", "Kwon", "Kim", "Jo", "Lim", "Choi"]

/// remove 메소드의 경우, 삭제된 원소를 반환한다.
names.remove(at: 3) // ["Oh", "Yoon", "Jeong", "Kwon", "Kim", "Jo", "Lim", "Choi"]

/// 만약 범위를 벗어나는 인덱스에 접근한다면, 런타임 에러가 발생한다.
/// for - loop 를 통해 Array의 원소 전체를 iterate 할 수 있다.
for name in names{
    print(name)
}

/// 만약 인덱스와 값을 같이 원한다면 (인덱스, 값)을 리턴하는 enumerated() 메소드를 이용하면 된다.
for (index, name) in names.enumerated(){
    print("\(index+1)th name is \(name)")
}

/*------------------------------------------*/

/// - Sets
/// 컬렉션 타입 Set은 Array와 다르게 순서가 필요없이, 유일한 값을 가지는 컬렉션 타입이다.
/// 스위프트의 Set은 Foundation의 NSSet 클래스의 관련이 있다.
/// Set타입을 선언하기 위해서는 원소의 타입이 반드시 Hashable 프로토콜을 따라야한다.
/// HashValue 비교를 통해 데이터가 동일한지 하지 않은지 판단하기 때문이다.
/// Dictionary의 Key또한 마찬가지이다.
/// 또한, 연관된 값이 없는 열거형의 케이스도 Hashable 프로토콜을 따른다.
/// 만약, 사용자 정의 타입으로 Set 컬렉션을 만들고 싶다면, Hashable 프로토콜을 따르기 위해 hash(into:) 메서드를 구현해야 한다.

/// Set은 Set<Element> 로 생성할 수 있으며, Array와 다르게 Shorthand Form을 제공하지 않는다.
var letters = Set<Character>()

/// 만약 빈 Set으로 만들고 싶다면, 빈 배열 리터럴인 []를 할당한다.
letters.insert("a")
letters = []

/// Array리터럴로 Set을 생성할 수 있다.
var favoriteGenres: Set<String> = ["Rock", "Classcal","Hip Hop"]

/// 스위프트의 타입추론으로 인해 다음과 같은 Shorthand Form도 존재한다.
var favoriteGenres: Set = ["Rock", "Classical", "Hip Hop"]

/// Set의 원소의 개수는 읽기 전용 프로퍼티인 count 프로퍼티를 통해 알 수 있다.
favoriteGenres.count

/// isEmpty 프로퍼티를 이용해 빈 Set인지 알 수 있다.
favoriteGenres.isEmpty

/// insert(_:) 메소드를 통해 집합에 새로운 원소를 추가할 수 있다.
favoriteGenres.insert("Jazz")

/// remove(_:)  메소드를 통해 집합에 해당 원소가 존재한다면 삭제하고, 삭제한 원소를 반환한다.
/// 만약, 존재하지 않는다면 nil을 반환한다.
if let removedItem = favoriteGenres.remove("Rock"){
    print("\(removedItem) is removed")
}else{
    print("not removed")
} // Rock is removed

/// removeAll() 메소드를 통해 모든 원소를 삭제할 수 있다.
favoriteGenres.removeAll()

/// contains() 메소드로 해당 원소가 존재하는지 조회할 수 있다.
favoriteGenres.contains("Dance")

/// for-loop 문으로 집합의 원소를 모두 조회할 수 있다.
for genre in favoriteGenres{
    print(genre)
}

/// 정렬된 Array를 리턴하는 sorted()메소드를 통해 순회할 수 있다.
/// 이떄 sorted()는  오름차순으로 정렬된 Array를 return 한다.
for genre in favoriteGenres.sorted(){
    print(genre)
}

/*------------------------------------------*/

/// - Performing Set Operations
/// 스위프트 Set은 다양한 집합 연산 메소드를 제공한다
/// 이 메소드들은 동일한 타입의 Set을 새로 생성하여 리턴한다.
/// - Note:
/// union, symmetricDifference, subtracting, intersection

let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]

/// 또한, 스위프트는 위의 집합 연산뿐만 아니라,
/// 두 집합 간의 관계를 알 수 있는 메소드도 제공한다.
/// - Note:
/// isSubset(), isSuperSet, isStrictSubset, isStrcitSuperset, isDisjoint
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true

/*------------------------------------------*/

/// - Dictionaries
/// 컬렉션 타입인 Dictionary는 Set과 마찬가지로 순서가 상관없는 [키: 값] 쌍의 자료구조다.
/// 스위프트의 딕셔너리는 Foundatiom의 NSDictionary 클래스의 관련이 있다.
/// Dictionary의 Key는 유일하며, Set의 원소와 마찬가지로 Hashable 프로토콜을 따라야한다.

/// Dictionary 생성하는 방법
/// Dictionary<Key, Value> 혹은 Shorthand Form인 [Key: Value]로도 가능하다.
/// 빈 Dictionary는 이 방법으로 생성할 수 있다.
var nameOfIntegers: [Int, String] = [:]

/// 딕셔너리를 리터럴을 할당해 빈 딕셔너리로 만들 수 있다.
nameOfIntegers[16] = "sixteen"
nameOfIntegers = [:]

/// Dictionary 리터럴을 이용해 Dictionary를 생성할 수 있다.
var airports: [String: String] = ["YYZ": "Toronto Airports", "DUB": "Dublin Airports"]

/// 스위프트의 타입추론을 이용해 타입 명시를 생략할 수 있다.
var airports = ["YYZ" : "Toronto Airports", "DUB": "Dublin Airports"]

/// Dictionary또한 마찬가지로 읽기 전용 프로퍼티인 count 프로퍼티를 통해 원소의 개수를 알 수 있다.
airports.count // 2

/// isEmpty 프로퍼티를 통해 count가 0인지 알 수 있다.
airports.isEmpty

/// Dictionary에서도 마찬가지로 원소의 수정 및 추가가 가능하다
/// 기본 제공되는 메소드나 서브스크립트를 이용할 수 있다.
airports["LHR"] = "London" // LHP 키를 가지는 원소가 없으므로 새로 생성한 후, London을 할당한다.
airports["LHR"] = "London Airports" // LHR 키를 가지는 원소가 있으므로, 해당 키에 해당하는 값을 수정한다.

/// uodateValue(_: forKey:) 메소드를 통해 값의 변경이 가능하다.
/// 서브스크립트와 마찬가지로, 키가 존재한다면 해당 키의 값을 변경하고, 만약 존재하지 않는다면 새로 값을 할당한다.
/// 서브스크립트와 차이점은 원소의 수정이 발생하면 Optional<oldValue>를 return 한다.
/// 만약 새로 할당한 원소라면 nil을 반환한다.
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// Prints "The old value for DUB was Dublin.

/// 만약 서브스크립트로 값을 조회하면 옵셔널을 반환한다.
/// 서브스크립트에 전달한 키가 존재한다면, 옵셔널 타입의 값을 반환하고, 존재하지 않는다면 nil을 반환한다.
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport isn't in the airports dictionary.")
}
// Prints "The name of the airport is Dublin Airport."

/// 만약 Dictionary에서 원소를 제거하고자 한다면
/// 서브스크립트와 nil을 이용하거나, 메소드를 이용할 수 있다.
airports["LHR"] = nil // Dictionary에서 key값이 LHR인 원소가 제거된다.
airports.removeValue(forKey: "DUB")
/// 만약 removeVlaue로 원소를 지웠다면, 지운 값을 return하고
/// 존재하지 않아 지우지 못했다면 nil을 return 한다.

/// for-loop를 이용해 Dictionary를 순회할 수 있다.
/// 튜플이 return 된다.
for (airportCode, airportName) in airports{
    print("\(airportCode) is code of \(airportName)")
}

/// 혹은 Dictionary의 key나 value만 순회할 수 있다.
/// keys 프로퍼티나, values 프로퍼티를 이용하면 된다.
/// Collection이 return 된다.
for airportCode in airports.keys{
    print(airportCode)
}
for airportName in airports.values{
    print(airportName)
}

/// 또한 key, value의 collection들을 Array로 캐스팅 할 수 있다.
let airportCode = [String](airports.keys) // airports.keys는 Key 타입의 콜렉션
let airportName = [String](airports.values) // airports.values는 Values 타입의 콜렉션

