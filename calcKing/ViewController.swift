//
//  ViewController.swift
//  calcKing
//
//  Created by 真一郎中村 on 2017/09/27.
//  Copyright © 2017年 真一郎中村. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ビューがロードされた時点で式と答えのラベルは空
        formulaLabel.text = ""
        answerLabel.text  = ""
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
        answerLabel.text = formulaText
    }
}

