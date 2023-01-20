//
//  Subscripts.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/09.
//

import Foundation

// - Topic: Subscripts
///
/// 클래스, 구조체, 열거형에서는 서브스크립트를 정의해 인덱스뿐만 아니라 다양한 타입으로도 접근하도록 구현할 수 있다.
/// 또한, 여러 개의 인자를 전달하도록 구현할 수 있다.

/// - Subscript Syntax
/// 서브스크립트를 정의하는 방법은 저장 프로퍼티와 연산 프로퍼티와 매우 유사하다.
/// subscript 키워드를 통해 구현할 수 있다.
/// 연산 프로퍼티처럼 읽기 전용, 읽기 - 쓰기 전용으로 만들 수 있다.
/// get,set와 {}를 이용해 구현하며, 연산 프로퍼티와 마찬가지로 set에 인자를 전달할 수 있으며 return 타입과 같아야 한다.
/// set에 인자를 생략하면 newValue의 이름으로 바인딩된다.
struct TimeTable{
    let multiplier: Int
    
    subscript(index: Int) -> Int{
        multiplier * index // return 생략, 읽기 전용 subscript
    }
}

// 읽기 전용 프로퍼티로 구현한 이유는 배수를 뽑아 내는 기능을 하는게 목적이므로, 값의 변경이 불가능해야한다.
let multiPlier = TimeTable(multiplier: 3)
print(multiPlier[8]) // 24

/*------------------------------------------*/
 
/// - Subscript Usage
/// 스위프트의 딕셔너리 또한 서브스크립트로 정의되어 있다.
/// return 타입은 옵셔널로 두어 존재하지 않는 키를 []에 전달한 경우 nil을 반환하도록 하였으며,
/// nil을 할당한 경우 키의 제거를 위함.
var numberOfLegs = ["tiger" : 4, "human" : 2, "crab" : 8]
numberOfLegs["cat"] = 4
numberOfLegs["bird"] // nil

/*------------------------------------------*/

/// - Subscript Options
/// 서브스크립트를 정의할 때 인자로 in-out 매개변수를 전달할 수 없지만, 가변 파라미터와 매개변수에 기본 값은 지정할 수 있다.
/// 또한, 함수와 마찬가지로 클래스와 구조체에서 서브스크립트의 오버로딩이 가능하다.
/// 즉 인자의 타입, 인자의 개수, 리턴 타입에 따른 중복정의가 가능하다.
struct Matrix{
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(row: Int, column: Int){
        rows = row
        columns = column
        grid = [Double](repeating: 0.0, count: rows * columns)
    }
    func isValidIndex(row: Int, column: Int) -> Bool{
        return row >= 0 && row < rows && column >= 0 && column < column
    }
    
    subscript(_ row: Int, _ column: Int) -> Double{
        get{
            assert(isValidIndex(row: row, column: column), "index out of range")
            return grid[(row * columns) + column]
        }
        set{
            assert(isValidIndex(row: row, column: column), "index out of range")
            grid[(row * column) + column] = newValue
        }
    }
}

/*------------------------------------------*/

/// - Type Subscripts
/// 메소드, 프로퍼티와 마찬가지로 타입 서브스크립트도 정의 가능하다.
/// static 키워드를 통해 정의 가능하다
/// 클래스에서 타입 서브스크립트를 오버라이딩이 가능하도록 하려면 class 키워드를 이용하면된다.
enum Planet: Int{
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet{
        return Planet(rawValue: n)!
    }
}

let mars = Planet[4]
print(mars) // mars
