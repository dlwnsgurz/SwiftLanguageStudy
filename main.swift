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

john.residence?.address = makeAddress() // makeAddress()가 실행되지 않아서 아무 문장도 출력되지 않는다.
