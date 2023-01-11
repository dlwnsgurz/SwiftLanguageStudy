//
//  Error Handlings.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/11.
//

import Foundation

// - Topic: Error Handling

/// 스위프트는 에러 처리를 위해 다양한 기능을 제공하며, 이는 NSError와 호응한다.
/// 옵서녈로 nil을 이용해 오류를 처리할 수 있지만, 에러가 발생한 이유와 그 에러에 대응하는 행동을
/// 정의하기 쉽도록 스위프트는 에러 핸들링을 제공한다.

/// - Representing and Throwing Errors
/// 스위프트에서 에러는 Error 프로토콜을 따르는 타입의 값으로 표현되며 열거형이 사용된다.
/// 에러를 발생시키기 위해 throw 구문을 사용할 수 있다.
enum VendingMachineError: Error{
    case invaildSelection
    case inSufficientFund(coinsNeeded: Int)
    case outOfStock
}

throw VendingMachineError.inSufficientFund(coinsNeeded: 5) // 코인이 5개 부족한 에러 발생.

/*------------------------------------------*/

/// - Handling Errors
/// 스위프트에서 에러 처리는 다른 언어처럼 콜 스택 되돌리기(unwinding)와 관련이 없다.
/// 따라서, 일반 함수의 return문과 비슷한 퍼포먼스를 보여준다.
/// 스위프트에서 에러 처리는 4가지 방법이 있다.
/// 1. 에러를 리턴하는 함수 정의해, 함수를 호출한 곳에서 에러 처리를 하는 법
/// 2. do - catch 구문
/// 3. 옵셔널 값을 반환
/// 4. assert()를 통해 강제 크래쉬 발생

/// 1. 에러를 리턴하는 함수를 통한 에러 핸들링
/// throws 키워드를 통해 정의하며, 이러한 함수를 throwing 함수라고 한다.
func errorThrowingFuction() throws -> String{
    
}

func nonErrorThrowingFuction() throws -> String{
    
}

/// 에러를 리턴하는 함수의 구체적인 예시.
struct Item{
    var price: Int
    var counts: Int
}

/// vend(itemName: ) 메소드는 에러를 throw 한다.
/// 따라서 이 메소드의 호출 부에서는 do-catch나, try!, try? 구문을 써야한다.
class VendingMachine{
    var inventory = [
        "Candy Bar" : Item(price: 12, counts: 7)
        "Chips" : Item(price: 10, counts: 4)
        "Pretzel" : Item(price: 7, counts: 11)]
    
    var coinsDeposited = 0
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else{
            throw VendingMachineError.invaildSelection
        }
        guard item.count > 0 else{
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else{
            throw VendingMachineError.inSufficientFund(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice" : "Chips",
    "Bob" : "Licorice",
    "Eve" : "Pretzel"
]
// 에러 함수를 호출하므로, try 키워드를 앞에 붙여야한다.
func buyFavoriteSnacks(person: String, vendingMachine: VendingMachine) throws{
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
    
}

/// throwing 이니셜라이저도 에러를 던질 수 있다.
struct PurchasedSnack{
    var name: String
    init(name: String, vendingMachine: VendingMachine){
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

/// 2. do-catch 구문으로 에러 핸들링
/// do-catch 문을 통해 catch 키워드 뒤에 어떤 에러인지 명시한다.
/// 만약, catch 키워드 뒤에 error 패턴 없이 구문을 작성한다면 , error가 지역 상수로 바인딩 된다.
/// try 문이 에러를 발생시킨다면 즉시 catch문 패턴을 검사하고, 매치된 catch 문이 실행된다.
/// 만약, 아무 패턴도 catch 문과 매치되지 않았다면, 마지막 catch 문에서 발생한 에러가 error 지역 상수로 바인딩된다.
/// 만약, try 문이 에러를 던지지 않는다면 do 절의 나머지 명령어가 실행된다.
/// 따라서, 에러가 발생한 곳에 오류는 해결해야 runtime 에러가 발생되지 않는다.
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do{
    try buyFavoriteSnacks(person: "Alice", vendingMachine: vendingMachine)
    print("Success Yum!")
}catch VendingMachineError.invaildSelection{
    print("Invalid Selection Error!")
}catch VendingMachineError.outOfStock{
    print("Out of Stock Error!")
}catch VendingMachineError.inSufficientFund(let coinsNeeded){
    print("\(coinsNeeded) coins is needed.")
}catch{
    print("\(error) error!")
}

/// nourish()가 실행되면, do 문 내에서 오류를 던진다.
/// 만약 VendingMachineError라면, print() 함수가 실행되고 nourish()를 호출한 곳에는 에러가 발생하지 않는다.
/// 만약, VendingMachineError가 아니라면, nourhish() 함수가 호출된곳으로 에러가 전파된다.
/// 따라서 호출된 곳에서는 반드시 에러를 처리해야한다.
func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}
// Prints "Couldn't buy that from the vending machine."

/// 또한 catch 패턴을 쉼표(,)로 나열해 한번에 처리할 수 있다.
func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMachineError.invaildSelection, VendingMachineError.outOfStock, VendingMachineError.inSufficientFund{
        print("Invalid selection, out of stock, or not enough money.")
    }
}

/// 3. 옵셔널을 반환
/// try?나 try! 키워드를 이용하면, 에러 발생시 nil이 반환된다.
/// 아래의 예시는 함수가 에러를 던지는 경우와 던지지 않는 경우로 나눌 수 있다.
/// 에러를 던진다면, x는 Int? 타입 nil, y도 nil
/// 에러를 던지지 않는다면, x는 int? 타입이고 함수의 리턴값을 값으로, y도 Int? 타입이고 함수의 리턴값을 값으로 가진다.
func someThrowingFunction() throws -> Int{
    // ...
}

let x = try? someThrowingFunction()
let y: Int?

do{
    y = try someThrowingFunction()
}catch{
    y = nil
}

/// try? 문은 주로 발생하는 에러를 같은 방식으로 처리하고자 할 때 유용하다.
func fetchData() -> Data?{
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

/// try! 문은 에러가 발생하지 않을 것이라고 확신할 때, 주로 사용한다.
/// 아래의 코드는 url에 있는 이미지를 불러올 수 없는 경우 에러를 발생시킨다.
/// 앱이 배포될 때 이미지가 포함되어 배포됨을 확신하기 때문에 try! 문을 사용할 수 있다.
/// 4. 에러가 발생하지 않을 것이라고 확신할 때 assertion()을 활용할 수 있다.
let image = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

/*------------------------------------------*/

/// - Specifying Cleanup Actions
/// 현재 블록에 종료되기 직전에 호출되는 명령어들을 defer 문에 넣을 수 있다.
/// defer 문은 return, break, throw 되어 실행이 종료되기 직전에 실행된다.
/// defer 문은 return ,break, throw 문을 만나기 전에 읽혀야 실행된다.
/// defer 문은 먼저 읽힌 역순으로 실행된다.
func processFile(fileName: String) -> throws{
    if exists(fileName){
        let file = open(fileName)
        defer{
            file.close()
        }
        while let line = try file.readLine(){
            //.. working with file
        }
    }
}
