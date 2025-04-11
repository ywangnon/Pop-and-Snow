//
//  ViewController.swift
//  Particle
//
//  Created by Hansub Yoo on 2022/07/21.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties
    
    private let emojiEmitterLayer = CAEmitterLayer()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureEmojiEmitterLayer()
        configureTapGesture()
        addSnowEffect()
        addBubbleEffect()
    }

    // MARK: - Setup Methods
    
    private func configureEmojiEmitterLayer() {
        emojiEmitterLayer.emitterCells = [createEmojiEmitterCell()]
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    // MARK: - Emitter Cell Factory
    
    private func createEmojiEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "money")?.cgImage
        cell.lifetime = 3
        cell.lifetimeRange = 1
        cell.birthRate = 100
        cell.scale = 0.15
        cell.scaleRange = 0.05
        cell.scaleSpeed = 1
        cell.spin = 5
        cell.spinRange = 10
        cell.emissionRange = .pi * 2
        cell.velocity = 700
        cell.velocityRange = 50
        cell.yAcceleration = 1200
        return cell
    }

    private func createSnowEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "money")?.cgImage
        cell.birthRate = 5
        cell.lifetime = 10
        cell.scale = 0.2
        cell.yAcceleration = 100
        cell.alphaRange = -0.2
        return cell
    }
    
    private func createBubbleEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "bubble")?.cgImage
        cell.birthRate = 500
        cell.lifetime = 1
        cell.scale = 0.1
        cell.yAcceleration = -100
        return cell
    }

    // MARK: - Actions
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        
        emojiEmitterLayer.emitterPosition = location
        emojiEmitterLayer.birthRate = 1
        
        view.layer.addSublayer(emojiEmitterLayer)
        print("SubLayer Count: \(view.layer.sublayers?.count ?? 0)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            self?.emojiEmitterLayer.birthRate = 0
        }
    }

    // MARK: - Effect Layers
    
    private func addSnowEffect() {
        let snowLayer = CAEmitterLayer()
        snowLayer.emitterShape = .line
        snowLayer.emitterSize = CGSize(width: view.frame.width, height: 0)
        snowLayer.emitterPosition = CGPoint(x: view.center.x, y: 0)
        snowLayer.emitterCells = [createSnowEmitterCell()]
        
        view.layer.addSublayer(snowLayer)
    }
    
    private func addBubbleEffect() {
        let bubbleLayer = CAEmitterLayer()
        bubbleLayer.emitterShape = .rectangle
        bubbleLayer.emitterSize = CGSize(width: view.frame.width, height: 200)
        bubbleLayer.emitterPosition = CGPoint(x: view.center.x, y: view.frame.height)
        bubbleLayer.emitterCells = [createBubbleEmitterCell()]
        
        view.layer.addSublayer(bubbleLayer)
    }
}
