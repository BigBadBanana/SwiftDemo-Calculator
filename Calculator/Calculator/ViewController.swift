//
//  ViewController.swift
//  Calculator
//
//  Created by yehot on 15/5/21.
//  Copyright (c) 2015年 Yehao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //  swift 中，一个对象（类） 的 任何属性，在声明时，都必须 同时初始化
    //   : Bool   这里，类型 可以不赋 （会自动推断）
    var userIsInputing : Bool = false
    
    //  UILabel!  这里用 ！ 的原因是 连线过来的，已经初始化了，可以直接解包
    //  如果这里  用  UILabel？  下边 每次用到 变量 displayLable 时 都要 解包一次 displayLable!.text 才能正常使用
    @IBOutlet weak var displayLable: UILabel!

    //  数组中，存放 double 类型，  初始化 时 为空 (两种写法 等效)
    var operandStack = Array<Double>()
    //    var operandStack : Array<Double> = Array<Double>()

    @IBAction func appendDigit(sender: UIButton) {
        
        //  ?  可选类型 optional  （只有两种情况 ： nil  或者  “正确的类型”）
        //  !  解包 （从 optional 类型中 解包出正确的类型、或者赋值为 nil ，比如上方 UILabel!   UILabel 初始化为 nil ）
        let digit : String = sender.currentTitle!
        print("digit = \(digit)")
        
        if userIsInputing {
            //  拼接字符串
            //  这里 displayLable!.text   隐式 转换
            displayLable.text = displayLable.text! + digit
        }else {
            displayLable.text = digit
            userIsInputing = true
        }
        
    }

    @IBAction func enterButtonClick() {
        userIsInputing = false
        
        //  点击 enter 将 lable 上的数，放入数组，
        operandStack.append(displayValue)
    }
    
    @IBAction func calculatorOperation(sender: UIButton) {
        
        let operation = sender.currentTitle!
        if userIsInputing{
            // 存入数组
            enterButtonClick()
        }
        switch operation {
            
            case "+":
                //  此处 将 一个 函数 当做参数 传递
                performOperation(multiply)
                   break
            
            case "−":
                //  或者，直接 将  multiply  函数，替换 到 括号中 的 multiply
//                performOperation(multiply)
                
                //  但 需要做修改
//                performOperation(
//                    (op1:Double, op2: Double) -> Double {
//                    return op1 + op2
//                    }
//                )
                
                //  将 返回值 后的 {  提到 最前边， 改为 in 
                //      闭包 语法  closure
                performOperation(
                    {
                        (op1:Double, op2: Double) -> Double  in
                        return op1 - op2
                    }
                )


                break
            
            case "×":
                
                //  去掉 换行的写法
                performOperation({(op1:Double, op2: Double) -> Double  in
                        return op1 * op2
                    })
                break
            
            case "÷":
                
                //  由于 swift 是 类型推断语言，闭包内可以省略 类型
                performOperation({(op1, op2) in
                        return op1 / op2
                    })
                //  直接写就可以
//                performOperation({ (Double, Double) -> Double in
//                    code
//                })
                
                break
            
            default :
                break
            
        }
    }
    
    
    
    
    
    //  performOperation 函数，无返回值， 传入的参数 是个 （自定义的 operation 类型） 接收两个 double 返回一个 double
    //      将函数 作为 参数

    func performOperation(operation:(Double, Double) -> Double){
        
        //      函数作为参数的 用法
//        let num1 = operation(2,3)
        
        if operandStack.count >= 2 {
            displayValue = operandStack.removeLast() + operandStack.removeLast()
            enterButtonClick()
        }
    }
    
    func multiply(op1:Double, op2: Double) -> Double {
        return op1 + op2
    }
    
    
    //  在这个 displayValue 属性的 set 、get 方法中，将label 的字符串，转为 double 类型
    //  而不是重新写个  转换的方法 （这样做，更省事 ）
    var displayValue : Double {
        get {
            
            //  格式转换 numberFromString
            return NSNumberFormatter().numberFromString(displayLable.text!)!.doubleValue
        }
        set {
            displayLable.text = "\(newValue)"
            userIsInputing = false
        }
    }
    
    
}

