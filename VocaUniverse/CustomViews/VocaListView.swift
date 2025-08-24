import SwiftUI

// MARK: - Main View
struct VocaListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var goToVocaList: Bool
    @Binding var goToStar: Bool
    
    @State private var page: Int = 0
    
    let stars: [StarModel]
    let starName: Int
    
    var title: String = "Collect the stars"
    
    let mainViewBackground = "MainViewBackground"
    let starsBackground = "StarsBackground"
    let hill = "Hill"
    let wowCatLying  = "WowCatLying"
    
    let activeColor     = Color(red: 44/255, green: 40/255, blue: 87/255)
    let ringWidth: CGFloat = 2
    
    private var words: [WordModel] { stars[starName].words }
    private var pages: [[WordModel]] { words.chunked(into: 5) }
    private var pageCount: Int { max(pages.count, 1) }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background
            Image(mainViewBackground)
                .resizable()
                .ignoresSafeArea()
            Image(starsBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image(hill)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 379)
            }
            
            VStack {
                Spacer()
                Image(wowCatLying)
                    .resizable()
                    .frame(width: 212, height: 212)
                    .padding(.bottom, 145)
                
                
            }
            
            VStack {
                HStack {
                    Button {
                        goToStar = true
                        goToVocaList = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    TitleBadge(text: stars[starName].title)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                .padding(.bottom, 26)
                
                ZStack { // MARK: 단어장 큰 네모
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(.white.opacity(0.9))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    
                    VStack {
                        // Custom dots row
                        HStack(spacing: 14) {
                            ForEach(0..<pageCount, id: \.self) { index in
                                Circle()
                                    .fill(index == page ? activeColor : Color(red: 227/255, green: 224/255, blue: 244/255))
                                    .frame(width: 12, height: 12)
                                    .overlay(
                                        Circle().stroke(activeColor, lineWidth: ringWidth) // 테두리
                                    )
                                
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        
                        if pages.isEmpty {
                            VStack(spacing: 8) {
                                Text("No words")
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                                Text("단어가 비어있어요")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.bottom, 24)
                        } else {
                            TabView(selection: $page) {
                                ForEach(Array(pages.enumerated()), id: \.offset) { index, wordPage in
                                    VStack(spacing: 16) {
                                        ForEach(wordPage) { m in
                                            wordCard(m)
                                        }
                                        Spacer(minLength: 0)
                                    }
                                    .padding(.horizontal, 20)
                                    .tag(index)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never)) // 기본 점 숨김(커스텀 도트 사용)
                            //                            .frame(height: 360) // 필요 시 조절
                            .animation(.easeInOut, value: page)
                        }
                    }
                }
            }
        }
        .onChange(of: words.count) { _, _ in
            page = min(page, max(pages.count - 1, 0))
        }
    }
    
    @ViewBuilder
    func wordCard(_ vocab: WordModel) -> some View {
        VStack(alignment: .leading) {
            Text(vocab.wordEng)
                .font(.system(size: 24, weight: .black))
                .foregroundColor(Color(red: 9/255, green: 10/255, blue: 52/255))
            Text(vocab.meanKor)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(red: 9/255, green: 10/255, blue: 52/255))
            Text(vocab.exampleEng)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Color(red: 88/255, green: 88/255, blue: 88/255))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(width: 329, alignment: .leading)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 187/255, green: 176/255, blue: 206/255), lineWidth: 2)
        )
        
    }
}
