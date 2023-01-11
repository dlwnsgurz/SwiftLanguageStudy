//
//  Deinitialization.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/11.
//

import Foundation

// - Toplc: Deinitialization
/// 초기화 해지는 deinit이다.
/// 클래스 타입에서만 사용할 수 있으며,  인스턴스가 할당 해제되기 직전에 호출된다.

/*------------------------------------------*/

/// - How Deinitialization Works
/// 파괴자는 인스턴스가 할당 해제되기 직전에 자동으로 호출된다.
/// 스위프트는 Auto Reference Counting (ARC)에 의해 자동으로 메모리를 관리해준다.
/// 하지만, 파일 입출력과 같이 프로그래머가 직접 관리 해야 되는 경우 파괴자는 유용하게 사용될 수 있다.
/// 하위 클래스의 파괴자는 구현하지 않아도 되며, 구현된경우에는 파괴자 실행시 자동으로 상위 클래스의 파괴자를 실행한다.
/// 또한, 상위 클래스에 파괴자는 하위 클래스로 자동 상속된다.
/// 파괴자에는 인자를 전달할 수 없다.
/// 파괴자는 인스턴스가 할당 해제 되기 직전에 호출되기때문에 모든 프로퍼티와 메소드에 접근이 가능하다.
deinit {
    // perform the deinitialization
}

/*------------------------------------------*/

/// - Deinitializers in Action
/// 다음 예를 통해서 파괴자가 어떻게 동작하는 지 알 수 있다.
class Bank{
    static var coinInBank = 10_000
    
    static func distribute(coins numberOfCoinsRequired: Int) -> Int{
        let numberOfCoinsToVend = min(coinInBank, numberOfCoinsRequired)
        coinInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int){
        coinInBank += coins
    }
}

class Player{
    var coinsInPurse: Int
    init(coins: Int){
        coinsInPurse = coins
    }
    
    func win(coins: Int){
        coinsInPurse += Bank.distribute(coins: coins)
    }
    
    deinit?{
        Bank.receive(coins: coinsInPurse)
    }
}

// 후에 할당 해지시에 playerOne = nil을 하기 위해..
let playerOne: Player? = Player(coins: 1_000)

