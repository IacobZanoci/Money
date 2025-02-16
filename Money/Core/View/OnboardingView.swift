//
//  OnboardingView.swift
//  Money
//
//  Created by Iacob Zanoci on 15/02/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selectedItem: Item = items.first!
    @State private var introItems: [Item] = items
    @State private var activeIndex: Int = 0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                HapticManager.instance.impact(style: .soft)
                updateItem(isForward: false)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3.bold())
                    .foregroundStyle(.green.gradient)
                    .contentShape(.rect)
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(selectedItem.id != introItems.first?.id ? 1 : 0)
            
            
            ZStack {
                ForEach(introItems) { item in
                    AnimatedIconView(item)
                }
            }
            .frame(height: 250)
            .frame(maxHeight: .infinity)
            
            VStack(spacing: 6) {
                HStack(spacing: 4) {
                    ForEach(introItems) { item in
                        Capsule()
                            .fill(selectedItem.id == item.id ? Color.primary : .gray)
                            .frame(width: selectedItem.id == item.id ? 25 : 4, height: 4)
                    }
                }
                .padding(.bottom, 15)
                
                Text(selectedItem.title)
                    .font(.title.bold())
                    .contentTransition(.numericText())
                
                Button {
                    if selectedItem.id == introItems.last?.id {
                        HapticManager.instance.impact(style: .medium)
                        hasSeenOnboarding = true
                    } else {
                        HapticManager.instance.impact(style: .medium)
                        updateItem(isForward: true)
                    }
                } label: {
                    Text(selectedItem.id == introItems.last?.id ? "Continue" : "Next")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .contentTransition(.numericText())
                        .frame(width: 250)
                        .padding(.vertical, 12)
                        .background(.green.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                }
                .padding(.top, 25)
                
            }
            .multilineTextAlignment(.center)
            .frame(width: 300)
            .frame(maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func AnimatedIconView(_ item: Item) -> some View {
        let isSelected = selectedItem.id == item.id
        
        Image(systemName: item.image)
            .font(.system(size: 80))
            .foregroundStyle(.white.shadow(.drop(radius: 10)))
            .blendMode(.overlay)
            .frame(width: 120, height: 120)
            .background(.green.gradient, in: .rect(cornerRadius: 32))
            .background {
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color.theme.whiteComponent.opacity(0.7))
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: 1, y: 1)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: -1, y: -1)
                    .padding(-2)
                    .opacity(selectedItem.id == item.id ? 1 : 0)
            }
            .rotationEffect(.init(degrees: -item.rotation))
            .scaleEffect(isSelected ? 1.1 : item.scale, anchor: item.anchor)
            .offset(x: item.offset)
            .rotationEffect(.init(degrees: item.rotation))
            .zIndex(isSelected ? 2 : item.zindex)
    }
    
    func updateItem(isForward: Bool) {
        guard isForward ? activeIndex != introItems.count - 1 : activeIndex != 0  else { return }
        var fromIndex: Int
        var extraOffset: CGFloat
        
        if isForward {
            activeIndex += 1
        } else {
            activeIndex -= 1
        }
        
        if isForward {
            fromIndex = activeIndex - 1
            extraOffset = introItems[activeIndex].extraOffset
        } else {
            extraOffset = introItems[activeIndex].extraOffset
            fromIndex = activeIndex + 1
        }
        
        for index in introItems.indices {
            introItems[index].zindex = 0
        }
        
        Task { [fromIndex, extraOffset] in
            withAnimation(.bouncy(duration: 1)) {
                introItems[fromIndex].scale = introItems[activeIndex].scale
                introItems[fromIndex].rotation = introItems[activeIndex].rotation
                introItems[fromIndex].anchor = introItems[activeIndex].anchor
                introItems[fromIndex].offset = introItems[activeIndex].offset
                
                introItems[activeIndex].offset = extraOffset
                
                introItems[fromIndex].zindex = 1
            }
            
            try? await Task.sleep(for: .seconds(0.1))
            
            withAnimation(.bouncy(duration: 0.9)) {
                introItems[activeIndex].scale = 1
                introItems[activeIndex].rotation = .zero
                introItems[activeIndex].anchor = .center
                introItems[activeIndex].offset = .zero
                
                selectedItem = introItems[activeIndex]
            }
        }
    }
    
}

#Preview {
    OnboardingView()
}
