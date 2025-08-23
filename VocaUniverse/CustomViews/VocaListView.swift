import SwiftUI

// MARK: - Main View
struct VocalListView: View {
    var title: String = "Collect the stars"
    
    let mainViewBackground = "MainViewBackground"
    let starsBackground = "StarsBackground"
    let hill = "Hill"
    let wowCatLying  = "WowCatLying"
    let activeColor     = Color(red: 44/255, green: 40/255, blue: 87/255)
    let ringWidth: CGFloat = 2
    
    struct VocabularyWord: Identifiable {
        let id = UUID()
        let word: String
        let meaning: String
        let example: String
    }
    
    let vocabularyWords: [VocabularyWord] = [
        VocabularyWord(word: "zodiac", meaning: "12궁도", example: "The astrologer used a zodiac to prepare my horoscope."),
        VocabularyWord(word: "earliest", meaning: "가장 이른", example: "I’m very busy, so I won’t be with you till 4 o’ clock at the earliest."),
        VocabularyWord(word: "tact", meaning: "감촉, 재치, 요령", example: "The young nurse showed great tact in dealing with worried parents."),
        VocabularyWord(word: "habitation", meaning: "거주, 주소, 주택, 살기", example: "The report described the houses as unfit for human habitation."),
        VocabularyWord(word: "obediently", meaning: "고분고분하게", example: "I pulled on the reins and the horse obediently slowed down.")
    ]
    
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
                        // 닫기 동작 (필요 시 바인딩/환경 dismiss로 연결)
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    TitleBadge(text: title)
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
                            ForEach(0..<5) { index in
                                Circle()
                                    .fill(index == 0 ? activeColor : Color(red: 227/255, green: 224/255, blue: 244/255))
                                    .frame(width: 12, height: 12)
                                    .overlay(
                                        Circle().stroke(activeColor, lineWidth: ringWidth) // 테두리
                                    )
                                
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        
                        // Cards list
                        VStack (spacing: 16){
                            ForEach(vocabularyWords) { vocab in
                                VStack(alignment: .leading) {
                                    Text(vocab.word)
                                        .font(.system(size: 24, weight: .black))
                                        .foregroundColor(Color(red: 9/255, green: 10/255, blue: 52/255))
                                    Text(vocab.meaning)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(Color(red: 9/255, green: 10/255, blue: 52/255))
                                    Text(vocab.example)
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
                        Spacer()
                    }
                }
            }
        }
        
    }
}

// MARK: - Preview
#Preview {
    VocalListView()
}
