//
//  NewsViee.swift
//  SportScore
//
//  Created by Vladyslav Mi on 24.06.2024.
//

import SwiftUI
import WebKit

struct NewsView: View {
    
    @StateObject var newsDataService = NewsDataService()
    
    var body: some View {
        NavigationView {
            VStack {
                if newsDataService.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List(newsDataService.allNews) { news in
                        HStack {
                            if let urlToImage = news.urlToImage {
                                AsyncImage(url: urlToImage) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                    } else if phase.error != nil {
                                        Color.red // Indicates an error
                                            .frame(width: 100, height: 100)
                                    } else {
                                        Color.gray // Acts as a placeholder
                                            .frame(width: 100, height: 100)
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing : 10) {
                                Text(news.title)
                                    .font(.headline)
                                    .fontWeight(.medium)
                              
                                HStack {
                                    Text(news.author ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(news.formattedPublishedAt)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                }
                            }
                            .padding(.leading, 8)
                        }
                        .padding(.vertical, 8)
                        .background(
                            NavigationLink(destination: WebView(url: news.url)) {
                                EmptyView()
                            }
                                .opacity(0)
                        )
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
            .onAppear {
                newsDataService.getNews()
        }
            .navigationTitle("Latest News")
            
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}



struct WebView: View {
    let url: URL
    
    var body: some View {
        WebViewRepresentable(url: url)
    }
}

struct WebViewRepresentable: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
