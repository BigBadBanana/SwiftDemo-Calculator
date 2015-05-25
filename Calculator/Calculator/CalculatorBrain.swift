//
//  CalculatorBrain.swift
//  SwiftTest
//
//  Created by yehao on 2015-5-22.
//  Copyright (c) 2015 Tencent. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    //  枚举类型 中，可以 放 函数
    //  函数 在 swift 中，也只是 一种类型
    private enum OpAction {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double,Double) -> Double)
    }
    
    //  存放 OpAction 类型的数组 （简略写法）
    private var opStack = [OpAction]()
    //  （常规写法）
//    var opStack = Array<OpAction>()
 
    
    //  字典， key 是 String ， value 是 OpAction 类型
    //      注意 区别 （这里 是用 : ）
    private var knowOps = [String : OpAction]()
    //  （常规写法）
//    var knowOps = Dictionary<String, OpAction>()

    
    init() {
        
        //  常规写法
//        knowOps["+"] = OpAction.BinaryOperation("+", { (num1, num2) -> Double in
//            return num1 + num2
//        })

        //  闭包  （省略写法）
        knowOps["+"] = OpAction.BinaryOperation("+") {$0 + $1}
        
        //  （更省略的写法） ： {$0 + $1}  闭包中，已经知道是要 传入 两个参数，返回一个参数，
        //      这里 ，只写 一个 + 号，就会自动将函数 的参数 计算，并返回结果
        knowOps["+"] = OpAction.BinaryOperation("+", +)

        //  func +(lhs: Double, rhs: Double) -> Double    comond 跟进 + ，也是个方法
        
    }
    
    
    //   将 一条数据 存入 数组
    func pushOperand(operand: Double) {
        
        //  数组中，加入 一条 OpAction 枚举 中， Operand 枚举类型的 值
        opStack.append(OpAction.Operand(operand))
    }
    
    //  从字典取出 value，放入数组
    func perforeOpration(symbol: String) {
        
        if let operation = knowOps[symbol] {
            opStack.append(operation)
        }
    }
    
    
}


/*
    access control   访问控制

    共有、私有   public  private

*/