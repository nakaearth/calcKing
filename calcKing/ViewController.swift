//
//  ViewController.swift
//  calcKing
//
//  Created by 真一郎中村 on 2017/09/27.
//  Copyright © 2017年 真一郎中村. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ビューがロードされた時点で式と答えのラベルは空
        formulaLabel.text = ""
        answerLabel.text  = ""
        
        // TODO: サーバにrequest投げてjsonでテストデータを受け取る
        let url:NSURL = NSURL(string:"http://localhost:5000/shared_albums/Mw==")!
        //リクエストを生成
        let request:NSURLRequest = NSURLRequest(url: url as URL)
        
        // 送信処理を始める.
        var data: NSData?
        do {
            let res: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
            data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: res) as NSData
            
        } catch {
            print(error)
        }
        
        if let _data = data {
            // 帰ってきたデータを文字列に変換.
            let getData: NSString = NSString(data:_data as Data, encoding: String.Encoding.utf8.rawValue)!
            
            //デバッグ文に表示
            print(getData as String)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func inputFormula(_ sender: UIButton) {
        // ボタン（Cと=以外）が押されたら式を表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        formulaLabel.text = formulaText + senderedText
    }
    
    @IBAction func clearCalculation(_ sender: UIButton) {
        // Cボタンが押されたら式と答えをクリアする
        formulaLabel.text = ""
        answerLabel.text = ""
    }
    
    @IBAction func calculateAnswer(_ sender: UIButton) {
        // =ボタンが押されたら答えを計算して表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        answerLabel.text = evalInput(formulaText)
    }
    
    private func evalInput(_ formula: String) -> String {
        do {
            // Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            print(String(answer))
            return String(answer)
        } catch {
            // 計算式が不当だった場合
            return "式を正しく入力してください"
        }
    }
}

