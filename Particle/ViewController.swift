//
//  ViewController.swift
//  Particle
//
//  Created by Hansub Yoo on 2022/07/21.
//

import UIKit

class ViewController: UIViewController {
    /**
     CAEmitterLayer
     
     particle system을 방출하고 움직이게하고 렌더링하는 레이어
     
     ## 코멘트에 대한 상세
     [naljin](https://sujinnaljin.medium.com/swift-카카오톡-송금-봉투-애니메이션-따라하기-27a86bfa59dc)
     
     */
    private let emitterLayer = CAEmitterLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpEmitterLayer()
        setUpTapGestureRecognizer()
        addSnowLayer()
        addBubble()
    }
    
    private func setUpEmitterLayer() {
        // layer에 뿌려질 셀
        emitterLayer.emitterCells = [emojiEmitterCell]
    }
    
    private func setUpTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    private var emojiEmitterCell: CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "money")?.cgImage
        
        // 유지시간
        cell.lifetime = 3
        // 유지시간 변화 범위
        cell.lifetimeRange = 1
        // 1초당 생성 갯수
        cell.birthRate = 100
        
        // 크기
        cell.scale = 0.15
        // 크기 변화 범위
        cell.scaleRange = 0.05
        
        cell.scaleSpeed = 1.0
        
        cell.contentsScale = 1.0
        
        // 회전 속도
        cell.spin = 5
        // 회전 범위
        cell.spinRange = 10
        
        // 방출되는 각도. 0이면 linear하게 방출
        // 2pi = 360도. 파티클이 모든 방향으로 방출
        cell.emissionRange = .pi * 2
        
        // 방출 속도. 높을수록 빠르고 멀리 방출
        cell.velocity = 700
        // 방출 변화 범위
        cell.velocityRange = 50
        // 중력 효과
        // 양수면 중력 적용되는 것처럼 보이고, 음수면 날아가는 것처럼 보임
        // velocity와 yAcceleration의 조합이 distance를 결정
        cell.yAcceleration = 1200
        
        return cell
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        let x = sender.location(in: view).x
        let y = sender.location(in: view).y
        
        // 방출 point
        emitterLayer.emitterPosition = CGPoint(x: x, y: y)
        
        // cell의 birth rate와 곱해져서 총 birth rate가 정해짐
        emitterLayer.birthRate = 1
        
        // birth rate를 0으로하지 않으면 시간동안 계속 cell을 방출
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            // birth rate가 0이 되면 더 이상 방출하지 않음
            self?.emitterLayer.birthRate = 0
        }
        
        // 레이어를 얹어주면 방출 시작
        // 클릭때마다 쌓일것같은데 count 찍어보면 계속 1
        view.layer.addSublayer(emitterLayer)
        print(view.layer.sublayers?.count)
    }
    
    /// 눈 내리는 효과
    func addSnowLayer() {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "money")?.cgImage
        cell.birthRate = 5
        cell.lifetime = 10
        cell.scale = 0.2
        cell.yAcceleration = 100
        cell.alphaRange = -0.2
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterSize = CGSize(width: view.frame.width, height: .zero)
        emitterLayer.emitterPosition = CGPoint(x: view.center.x, y: .zero)
        emitterLayer.emitterCells = [cell]
        // 다른 애니메이션을 추가하면 subLayer count가 올라감
        view.layer.addSublayer(emitterLayer)
    }
    
    /// 부글부글거리는 효과
    func addBubble() {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "bubble")?.cgImage
        cell.birthRate = 500
        cell.lifetime = 1
        cell.scale = 0.1
        cell.yAcceleration = -100
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .rectangle
        emitterLayer.emitterSize = CGSize(width: view.frame.width, height: 200)
        emitterLayer.emitterPosition = CGPoint(x: view.center.x, y: view.frame.height)
        emitterLayer.emitterCells = [cell]
        view.layer.addSublayer(emitterLayer)
        
    }
}

