//
//  VideoSession.swift
//  MagicPaper
//
//  Created by Angelique Babin on 05/05/2021.
//

import SpriteKit

struct VideoSession {
    
    /// SpriteKit - SKVideoNode
    func addVideoScn() -> SKScene {
        let videoNode = SKVideoNode(fileNamed: Constants.harryPotter + "." + Constants.mp4)
        videoNode.play()
        let videoScene = SKScene(size: CGSize(width: 480, height: 360))
        videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
        videoNode.yScale = -1.0
        videoScene.addChild(videoNode)
        return videoScene
    }
}
