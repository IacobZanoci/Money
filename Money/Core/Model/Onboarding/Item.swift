//
//  Item.swift
//  Money
//
//  Created by Iacob Zanoci on 15/02/2025.
//

import SwiftUI

struct Item: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    
    var scale: CGFloat = 1
    var anchor: UnitPoint = .center
    var offset: CGFloat = 0
    var rotation: CGFloat = 0
    var zindex: CGFloat = 0
    var extraOffset: CGFloat = -350
}

let items: [Item] = [
    .init(image: "dollarsign.circle.fill",
          title: "Your favorite Money tracking app.",
          scale: 1
         ),
    .init(image: "list.bullet.circle.fill",
          title: "Jump easily into your transactions.",
          scale: 0.6,
          anchor: .topLeading,
          offset: -70,
          rotation: 30
         ),
    .init(image: "creditcard.circle.fill",
          title: "Keep tracking your expenses.",
          scale: 0.5,
          anchor: .bottomLeading,
          offset: -60,
          rotation: -35
         ),
    .init(image: "face.smiling.inverse",
          title: "Simple and \nintuitive.",
          scale: 0.4,
          anchor: .bottomLeading,
          offset: -50,
          rotation: 160,
          extraOffset: -120
         ),
    .init(image: "circle.bottomhalf.filled",
          title: "Gorgeous in \nBlack.",
          scale: 0.35,
          anchor: .bottomLeading,
          offset: -50,
          rotation: 250,
          extraOffset: -100
         ),
]
