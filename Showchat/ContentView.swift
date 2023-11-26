//
//  ContentView.swift
//  Showchat
//
//  Created by Bin Yang on 11/23/23.
//

import SwiftUI

// Main content view for the app
struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    // Array of image names to display in the horizontal scroll view
    let imageNames = ["beef", "indian_matchmaking", "the-great-british-bake-off", "love-island-2019", "all-the-light-we-cannot-see", "selling-sunset", "love-is-blind", "the-circle", "queer-eye", "suits"]
    
    // The body of ContentView, which contains all the subviews
    var body: some View {
        // Tab view for bottom navigation
        TabView(selection: $selectedTab) {
            mainContentView
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            // Placeholder for another tab
            Text("Other Tab")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(1)
            }
        }
    
    // The main content view, which is one of the tabs
    var mainContentView: some View {
            ZStack {
                    VStack {
                        // Search bar at the top
                        SearchBar(text: $searchText).padding(.top, -89)

                        // Welcome message with a callout triangle pointing to the search bar
                        WelcomeBanner().padding(.top, -50)
                        
                        // Scrollable horizontal list of shows
                        Text("POPULAR SHOWCHATS")
                            .font(Font.custom("Montserrat-Bold", size: 19))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.top, 20)
                        
                        // Scroll view for horizontally scrolling show images
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                // Scroll view for horizontally scrolling show images
                                ForEach(imageNames, id: \.self) { imageName in
                                    VStack {
                                        // Scroll view for horizontally scrolling show images
                                        Image(imageName)
                                            .resizable()
                                            .frame(width: 213, height: 347)
                                            .cornerRadius(20)
                                            .shadow(radius: 5)
                                        // A custom view showing user reactions
                                        UserReactionsView()
                                            .padding(.top, -20)
                                            .offset(x: 45, y: 0)//
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .padding(.top, 20)
                    }
                }
                // Using dark color scheme for the content view
                .preferredColorScheme(.dark)
            }
    }

// The welcome banner view with a custom linear gradient background
struct WelcomeBanner: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                // Welcome text
                Text("Welcome!")
                    .font(Font.custom("Montserrat-Regular", size: 16))
                    .foregroundColor(.black)
                // Additional welcome message
                Text("Start watching any show (turn up the volume please), search for what you're watching here, and have fun!")
                    .font(Font.custom("Montserrat-Regular", size: 16))
                    .foregroundColor(.black)
                }
                .padding()
                .background(
                    // Linear gradient background for the welcome banner
                    LinearGradient(
                        stops: [
                                Gradient.Stop(color: Color(red: 1, green: 0.5, blue: 0.03), location: 0.00),
                                Gradient.Stop(color: Color(red: 1, green: 0.68, blue: 0.15), location: 0.63),
                                Gradient.Stop(color: Color(red: 1, green: 0.78, blue: 0.22), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 2.06, y: 1.59),
                            endPoint: UnitPoint(x: -1.23, y: -0.78)
                    )
                )
                .cornerRadius(9.05806)
                .overlay(
                    // A small triangle pointing upwards from the banner
                    Triangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                             startPoint: .topLeading,
                                             endPoint: .bottomTrailing))
                        .frame(width: 25, height: 12)
                        .offset(y: -12),
                    alignment: .top
                )
            }
            .padding(.horizontal)
            .padding(.top, 12)
        }
}

// Custom shape for the triangle used in the welcome banner
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// The search bar view with a text field and clear button
struct SearchBar: View {
    @Binding var text: String

        var body: some View {
            ZStack {
                // Dark background rectangle for the search bar
                Rectangle()
                    .foregroundColor(Color(red: 0.15, green: 0.16, blue: 0.16)) // Adjust the color to match your design
                    .frame(height: 48)
                HStack {
                    // Magnifying glass icon
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(red: 0.77, green: 0.77, blue: 0.77))
                        .padding(.leading, 10)
                    // ZStack for the text field and placeholder
                    ZStack(alignment: .leading) {
                        if text.isEmpty {
                            // Placeholder text
                            Text("Show & season you're watching")
                                .foregroundColor(.gray) // Custom placeholder color
                                .font(Font.custom("Montserrat-Regular", size: 16))
                                .padding(7)
                                .padding(.leading, 0)
                            }
                        // Text field for user input
                        TextField("", text: $text)
                            .font(Font.custom("Montserrat-Regular", size: 16))
                            .foregroundColor(.white) // Color for the entered text
                            .padding(7)
                            .padding(.leading, 0)
                        }
                    Image(systemName: "xmark")
                        .padding(.trailing, 10)
                    }
                }
        }
        }

// A view that shows user reactions with overlapping circular images and a text
struct UserReactionsView: View {
    var body: some View {
        HStack(spacing: -10) { // Negative spacing for overlapping circles
            ForEach(0..<3, id: \.self) { index in
                // Using system symbol 'person.fill' for user avatars, these should be replaced with actual user image in actual work
                Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .background(Color.gray)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 0.5) 
                    )
            }
            // Text displaying the additional number of reactions
            Text("+12")
                .font(Font.custom("Montserrat-Regular", size: 16))
                .foregroundColor(.white)
                .frame(width: 40.09, height: 40.02)
                .background(Color.gray.opacity(0.5))
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 0.5)
                )
        }
    }
}



