//
//  Optional Chaining.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/11.
//

import Foundation

// - Topic: Optional Chaining
///
/// 옵셔널 체이닝은 nil일 수도 있는 프로퍼티, 메소드, 서브스크립트에 접근할 떄 뒤에 ?를 붙힌다.


/// - Optional Chaining as an Alternative to Forced Unwrapping
/// 강제 언래핑과의 차이점은 강제 언래핑은 nil인 경우 런타임 에러가 발생하지만, 옵셔널 체이닝은 nil을 반환한다.
/// 옵셔널 체이팅의 return 타입은 옵셔널이다.
/// 아래의 코드에서 옵셔널 체이닝과 강제 언래핑의 차이를 볼 수 있다.
class Residence{
    let numberOfRoom = 1
}

class Person{
    var residence: Residence?
}

let john = Person() // john의 Residence 프로퍼티는 nil이다.
let roomCount = john.residence!.numberOfRoom // 강제 언래핑. 런타임 에러 발생

// roomCount는 nil.
if let roomCount = john.residence?.numberOfRoom{
    print("john has \(roomCount)'s room")
}else{
    print("john has no room")
}

// roomCount는 Int? 타입의 1.
if let roomCount = john.residence?.numberOfRoom{
    print("john has \(roomCount)'s room")
}else{
    print("john has no room")
}

/*------------------------------------------*/
/// - Defining Model Classes for Optional Chaining
/// 옵셔널 체이닝은 여러 계층, 여러 관계를 갖는 프로퍼티, 메소드, 서브스크립트에 접근할 수 있다.
/// 클래스를 통해 여러 관계를 갖는 모델을 정의해보자.

class Person{
    var residence: Residence?
}

class Residence{
    var rooms: [Room] = []
    var numberOfRooms: Int{
        return rooms.count
    }
    subscript(i: Int) -> Room{
        get{ return rooms[i]}
        set{ rooms[i] = newValue }
    }
    
    func printNumberOfRooms(){
        print("this residence has \(numberOfRooms) rooms")
    }
    
    var address: Address?
}

class Room{
    let name: String
    init(name: String){
        self.name = name
    }
}

class Address{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String?{
        if let buildingNumber = buildingNumber, let street = street{
            return "\(buildingNumber) + \(street)"
        }else if let buildingName = buildingName{
            return "\(buildingName)"
        }else{
            return nil
        }
    }
    
}

/*------------------------------------------*/

/// - Accessing Properties Through Optional Chaining
/// 위의 클래스를 통해 프로퍼티에 접근해보자.
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// john의 residence가 nil이므로, nil을 반환한다.
// Prints "Unable to retrieve the number of rooms."


/// 할당문에서 왼쪽항이 nil이라면 오른쪽 항은 실행되지 않는다.
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress
// john.residence?.address 도 실패한다.
// john.residence가 nil이기때문이다.

/// 할당문에서 왼쪽이 nil일때 오른쪽 항은 실행되지 않음을 확인해보자.
func makeAddress() -> Address{
    print("makeAddress() is called")
    let address = Address()
    address.buildingName = "63 Building"
    address.buildingNumber = "27"
    address.street = "jong_ro 3 road"
    return address
}

john.residence?.address = makeAddress() // makeAddress()가 실행되지 않으므로, 아무 문장도 출력되지 않는다.

/*------------------------------------------*/

/// - Calling Methods Through Optional Chaining
/// return이 없는 함수는 자체적으로 ()나 빈 튜플, 즉 Void 타입을 반환한다.
/// 만약, 옵셔널 체이닝을 통해 잘못된 메소드를 호출한다면, Void?타입을 반환하며 nil이 된다.
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

/// 또한, 옵셔널 체이닝을 통해 잘못된 프로퍼티에 값을 할당하는 경우에도 Void?타입을 반환하며 nil이 된다.
if (john.residence?.address = someAddress) != nil{
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// Prints "It was not possible to print the number of rooms."

/*------------------------------------------*/

/// - Accessing Subscripts Through Optional Chaining
/// 서브 스크립트 문법에도 옵셔널 체이닝을 통해 접근할 수 있다.
/// 마찬가지로, 잘못된 할당문의 경우 nil이 되며, []앞에 ?를 붙여야한다.
if let firstRoomName = john.residence?[0].name { // john.residence가 nil이므로 실패한다.
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "Unable to retrieve the first room name."

/// 마찬가지로, john.residence가 nil이므로 실패한다.
john.residence?[0] = Room(name: "Bathroom")

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "The first room name is Living Room."

/// 옵셔널 타입을 return 하는 서브 스크립트에 접근할 때 헷갈리지 않도록 주의한다.
var testScores = ["Dave" : [91,89,77], "John" : [87,88,88]]
testScores["Dave"]?[0] += 2 // Dave : [93,89,77]
testScores["John"]?[2] -= 1 // John : [87,88,86]
testScores["Lee"]?[3] = 4 // nil

/*------------------------------------------*/

/// - Linking Multiple Levels of Chaining
/// 여러 계층으로 연결된 경우에도 옵셔널 체이닝을 통해 접근할 수 있다.
/// 이때 옵셔널 체이닝의 결과는 가장 하위 계층의 타입의 옵셔널이다.
/// 만약 옵셔널 체이닝 중간에 nil이 있으면 무조건 nil을 반환한다.
/// 아래의 경우에는 address가 nil이므로, 실패다.
/// street이 가장 하위 계층이므로 String? 타입이다.
/// 즉, nil을 반환하며 String? 타입이다.
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."

/// john.residence.address에 Address 인스턴스를 할당해서 해결할 수 있다.
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "John's street name is Laurel Street."

/*------------------------------------------*/

/// - Chaining on Methods with Optional Return Values
/// 위의 예시에서 옵셔널 체이닝에 사용된 메소드의 경우, nil인 인스턴스가 가지는 메소드였다.
/// 아래의 예시는 메소드의 return 타입이 옵셔널인 경우다.
// john.residence?.address? 가 nil이 아니므로 출력된다.
// String? 타입이다.
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// Prints "John's building identifier is The Larches."

/// 메소드의 return 타입을 통해 옵셔널 체이닝을 추가로 적용하고자 한다면, 아래와 같이 할 수 있다.
if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier doesn't begin with \"The\".")
    }
}
