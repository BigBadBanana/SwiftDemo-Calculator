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
    
    //    类、枚举、结构体，都可以 加  : Printable  ，表示 遵守协议 protocol
    private enum OpAction : CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double,Double) -> Double)
        
        //  swift 中，枚举可以添加 属性
        var description: String {
            
            //  只有 get 方法， readonly
            get {
                switch self {
                    case .Operand(let operand):
                        return "\(operand)"
                    case .UnaryOperation(let operand, _):
                        return "\(operand)"
                    case .BinaryOperation(let operand, _):
                        return "\(operand)"
                }
            }
        }
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
    
    
    //  重载，在 下边的类似方法中 使用：  从 数组中取元素 进行 相应操作，不一定取出的是 加号 或者 数字
    //      遇到 对应的 类型，会调用 对应的方法 （方法名一致，传入参数不同的 重载）
    
    //  返回运算的结果 (加 ？ 表示返回的结果可能为空 )
    func evaluate() -> Double? {

        let (result, remainder) = evaluate(opStack)
        return result
    }
    
    //  返回值是  元组 ：计算结果 和 剩余的 栈数组元素 ,  传入 数组
    //  传入的参数 都是  值传递， 是只读的
    private func evaluate(opActions:[OpAction]) -> (result: Double?, remainingOps:[OpAction]) {
        if !opActions.isEmpty {
            //  对只读，先做一份 可变拷贝 （拷贝的是副本，不是地址）
            var remainingOps = opActions
            let op = remainingOps.removeLast()
            switch op {
                //  op.Operand  取枚举类型， 加个 . 类型推断
                case .Operand(let operand):
                    return (operand,remainingOps)
//                case .UnaryOperation(_, let operandtion)
//                    let operandEvalution = evaluate(remainingOps)
//                    let operand = operandEvalution.result
//                    return (operandtion(operand),OpAction)
                default:
                    break
            }
        }
        return (nil, opActions)
        
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