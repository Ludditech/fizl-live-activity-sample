//
//  Fizl_ActivityLiveActivity.swift
//  Fizl Activity
//
//  Created by Dominic on 2023-12-27.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct FizlActivityView: View {
    let context: ActivityViewContext<FizlAttributes>
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            VStack(spacing: 10) {
                HStack {
                    Image(colorScheme == .dark ? "FizlIconWhite" : "FizlIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                    Text(context.state.headline)
                        .font(.headline)
                    Spacer()
                }
                .padding(.top)

                HStack {
                    Text(context.state.title)
                        .font(.title2)
                        .padding(.top, 5)
                    Spacer()
                }

                Spacer()

                ProgressView(timerInterval: context.state.startTime...context.state.endTime, countsDown: false)
                    .progressViewStyle(LinearProgressViewStyle())

                Spacer()
            }
            .padding(.horizontal)

            Image("SmallListing")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(width: 100)
                .padding()
        }
    }
}

struct FizlIslandBottom: View {
    let context: ActivityViewContext<FizlAttributes>

    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 10) {
                    Spacer()

                    Text(context.state.title)
                        .font(.title3)

                    ProgressView(timerInterval: context.state.startTime...context.state.endTime, countsDown: false)
                        .progressViewStyle(LinearProgressViewStyle())

                    Spacer()
                }
                .padding(.horizontal)

                Image("SmallListing")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(width: 100)
            }
        }
    }
}

struct FizlWidget: Widget {
    let kind: String = "Fizl_Widget"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FizlAttributes.self) { context in
            FizlActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image("FizlIconWhite")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36)
                        .padding(.leading)
                }
                DynamicIslandExpandedRegion(.trailing) {}
                DynamicIslandExpandedRegion(.bottom) {
                    FizlIslandBottom(context: context)
                }
            } compactLeading: {
                Image("FizlIconWhite")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
            } compactTrailing: {} minimal: {
                Image("FizlIconWhite")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
            }
            .widgetURL(URL(string: context.state.widgetUrl))
        }
    }
}

private extension FizlAttributes {
    static var preview: FizlAttributes {
        FizlAttributes()
    }
}

private extension FizlAttributes.ContentState {
    static var state: FizlAttributes.ContentState {
        FizlAttributes.ContentState(startTime: Date(timeIntervalSince1970: TimeInterval(1704300710)), endTime: Date(timeIntervalSince1970: TimeInterval(1704304310)), title: "Started at 11:54AM", headline: "Fizl in Progress", widgetUrl: "https://www.apple.com")
    }
}

struct FizlActivityView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FizlAttributes.preview
                .previewContext(FizlAttributes.ContentState.state, viewKind: .content)
                .previewDisplayName("Content View")

            FizlAttributes.preview
                .previewContext(FizlAttributes.ContentState.state, viewKind: .dynamicIsland(.compact))
                .previewDisplayName("Dynamic Island Compact")

            FizlAttributes.preview
                .previewContext(FizlAttributes.ContentState.state, viewKind: .dynamicIsland(.expanded))
                .previewDisplayName("Dynamic Island Expanded")

            FizlAttributes.preview
                .previewContext(FizlAttributes.ContentState.state, viewKind: .dynamicIsland(.minimal))
                .previewDisplayName("Dynamic Island Minimal")
        }
    }
}
