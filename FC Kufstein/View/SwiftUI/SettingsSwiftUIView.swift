//
//  SwiftUIView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 10.10.23.
//

import SwiftUI

struct SettingsSwiftUIView: View {
    
    // MARK: - Properties
    private let alternateAppIcons: [String] = [
        "AppIcon-MagnifyingGlass",
        "AppIcon-Map",
        "AppIcon-Camera",
        "AppIcon-Campfire",
        "AppIcon-Mushroom",
        "AppIcon-Backpack"
    ]
    
    var body: some View {
        List {
            Section {
                // MARK: - Section: Header
                HStack {
                    Spacer()
                    Image(systemName: "laurel.leading")
                        .font(.system(size: 80, weight: .black))
                    VStack(spacing: 7) {
                        Text("FC Kufstein")
                            .font(.system(size: 28, weight: .black))
                        Text("EST 1919")
                            .fontWeight(.medium)
                    }
                    Image(systemName: "laurel.trailing")
                        .font(.system(size: 80, weight: .black))
                    Spacer()
                }
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            .customBlueLight,
                            .customBlueMedium,
                            .customBlueDark
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding(.top, 8)
                
                VStack(spacing: 8) {
                    Text("Never miss a match with \nFC Kufstein's app")
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    Text("The team that ignites a fire within you, making you yearn for another matchday experience. Discover the exhilaration of FC Kufstein's matches in the \napp and relive the excitement over and over again")
                        .font(.footnote)
                        .italic()
                    
                    Text("Get ready to play, it's match day!")
                        .fontWeight(.heavy)
                        .foregroundColor(.customBlueMedium)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
            }//: Header
            .listRowSeparator(.hidden)
            
            // MARK: - Section: Icons
            Section(header: Text("Alternate Icons")) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(alternateAppIcons.indices, id: \.self) { item in
                            Button {
                                print("Icon was pressend")
                                UIApplication.shared.setAlternateIconName(alternateAppIcons[item]) { error in
                                    if error != nil {
                                        print("Failed request to update the apps's icons: \(String(describing: error?.localizedDescription))")
                                    } else {
                                        print("Success! You have changed the app's icon to \(alternateAppIcons[item])")
                                    }
                                }
                            } label: {
                                Image("\(alternateAppIcons[item])-Preview")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(16)
                            }
                        .buttonStyle(.borderless)
                        }
                    }
                } //: ScrollView
                .padding(.top, 12)
                Text("Chose your favourite app icon from the collection above.")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .padding(.bottom, 12)
            }
            .listRowSeparator(.hidden)
            // MARK: - Section: About
            Section(
                header: Text("About the app"),
                footer: HStack {
                    Spacer()
                    Text("Copyright © All right reserved.")
                    Spacer()
                }
                    .padding(.vertical, 8)
            ) {
                
                CustomListRowView(
                    rowLabel: "Application",
                    rowIcon: "apps.iphone",
                    rowContent: "FCKufstein",
                    rowTintColor: .blue
                )
                
                CustomListRowView(
                    rowLabel: "Compatibility",
                    rowIcon: "info.circle",
                    rowContent: "iOS,iPadOS",
                    rowTintColor: .red
                )
                
                CustomListRowView(
                    rowLabel: "Tehnology",
                    rowIcon: "swift",
                    rowContent: "Swift",
                    rowTintColor: .orange
                )
                
                CustomListRowView(
                    rowLabel: "Version",
                    rowIcon: "gear",
                    rowContent: "1.0",
                    rowTintColor: .purple
                )
                
                CustomListRowView(
                    rowLabel: "Develop",
                    rowIcon: "ellipsis.curlybraces",
                    rowContent: "Ricado-Networks",
                    rowTintColor: .mint
                )
                
                CustomListRowView(
                    rowLabel: "Website",
                    rowIcon: "globe",
                    rowContent: nil,
                    rowTintColor: .pink,
                    rowLinkLabel: "FC-Kufstein.at",
                    rowLinkDestination: "https://fc-kufstein.at/"
                )
            }
        } //: List
    }
}

#Preview {
    SettingsSwiftUIView()
}

