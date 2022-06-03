//
//  BorderView.swift
//  SampleApp
//
//  Created by Pedro Contine on 06/03/22.
//

import SwiftUI
import Treco

struct BorderView: View {
    var body: some View {
        List {
            Section(header: TrecoText("Width")) {
                BorderWidthTokenView(.none)
                BorderWidthTokenView(.thin)
                BorderWidthTokenView(.thick)
                BorderWidthTokenView(.thicker)
            }
            Section(header: TrecoText("Radius")) {
                BorderRadiusTokenView(.none)
                BorderRadiusTokenView(.small)
                BorderRadiusTokenView(.medium)
                BorderRadiusTokenView(.large)
            }
        }
        .navigationTitle("Borders")
        .listStyle(.plain)
    }
}

struct BorderWidthTokenView: View {
    
    private let width: BorderWidth
    
    init(_ width: BorderWidth) {
        self.width = width
    }
    
    var body: some View {
        VStack {
            HStack {
                TrecoText(width.rawValue + " (\(Int(width.value))px)")
                    .textStyle(.description)
                Spacer()
            }
            Rectangle()
                .fill(Color.treco(.neutralDark3))
                .frame(height: Spacing.lg.value)
                .addBorder(radius: .none, width: width)
        }
        .listSectionSeparator(.visible)
        .listRowSeparator(.hidden)
    }
}

struct BorderRadiusTokenView: View {
    
    private let radius: BorderRadius
    
    init(_ radius: BorderRadius) {
        self.radius = radius
    }
    
    var body: some View {
        VStack {
            HStack {
                TrecoText(radius.rawValue + " (\(Int(radius.value))px)")
                    .textStyle(.description)
                Spacer()
            }
            Rectangle()
                .fill(Color.treco(.neutralDark3))
                .frame(height: Spacing.lg.value)
                .addBorder(radius: radius, width: .thin)
        }
        .listSectionSeparator(.visible)
        .listRowSeparator(.hidden)
    }
}

struct BorderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BorderView()
        }
    }
}
