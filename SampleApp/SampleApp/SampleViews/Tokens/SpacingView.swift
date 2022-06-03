//
//  SpacingView.swift
//  SampleApp
//
//  Created by Pedro Contine on 12/03/22.
//

import SwiftUI
import Treco

struct SpacingView: View {
    var body: some View {
        List {
            Section(header: TrecoText("Horizontal")) {
                HorizontalSpacingTokenView(.none)
                HorizontalSpacingTokenView(.xxxs)
                HorizontalSpacingTokenView(.xxs)
                HorizontalSpacingTokenView(.xs)
                HorizontalSpacingTokenView(.sm)
                HorizontalSpacingTokenView(.md)
                HorizontalSpacingTokenView(.lg)
                HorizontalSpacingTokenView(.xl)
                HorizontalSpacingTokenView(.xxl)
            }
            Section(header: TrecoText("Vertical")) {
                VerticalSpacingTokenView(.none)
                VerticalSpacingTokenView(.xxxs)
                VerticalSpacingTokenView(.xxs)
                VerticalSpacingTokenView(.xs)
                VerticalSpacingTokenView(.sm)
                VerticalSpacingTokenView(.md)
                VerticalSpacingTokenView(.lg)
                VerticalSpacingTokenView(.xl)
                VerticalSpacingTokenView(.xxl)
            }
        }
        .navigationTitle("Spacing")
        .listStyle(.plain)
    }
}

struct HorizontalSpacingTokenView: View {
    
    private let spacing: Spacing
    
    init(_ spacing: Spacing) {
        self.spacing = spacing
    }
    
    var body: some View {
        VStack {
            HStack {
                TrecoText(spacing.rawValue + " (\(spacing.value))")
                    .textStyle(.description)
                Spacer()
            }
            HStack {
                Rectangle()
                    .fill(Color.treco(.neutralDarkPure))
                    .frame(height: Spacing.lg.value)
                TrecoSpacer(horizontal: spacing)
                Rectangle()
                    .fill(Color.treco(.neutralDark2))
                    .frame(height: Spacing.lg.value)
            }
        }
        .listSectionSeparator(.visible)
        .listRowSeparator(.hidden)
    }
}

struct VerticalSpacingTokenView: View {
    
    private let spacing: Spacing
    
    init(_ spacing: Spacing) {
        self.spacing = spacing
    }
    
    var body: some View {
        VStack {
            HStack {
                TrecoText(spacing.rawValue + " (\(spacing.value))")
                    .textStyle(.description)
                Spacer()
            }
            VStack {
                Rectangle()
                    .fill(Color.treco(.neutralDarkPure))
                    .frame(height: Spacing.lg.value)
                TrecoSpacer(vertical: spacing)
                Rectangle()
                    .fill(Color.treco(.neutralDark2))
                    .frame(height: Spacing.lg.value)
            }
        }
        .listSectionSeparator(.visible)
        .listRowSeparator(.hidden)
    }
}

struct SpacingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SpacingView()
        }
    }
}
