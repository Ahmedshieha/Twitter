import XCTest
@testable import TwitterCounterPackage

final class TwitterCounterPackageTests: XCTestCase {
    
    private var sut: TwitterCounterViewModel!
    
    override func setUpWithError() throws {
        sut = TwitterCounterViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGivenHugeTweetWhenCheckTweetCountThenFailValidate() {
        // Given
        let tweet = "djasldjlsajdkladksnsndknaskdnkjsandkbaeifh;ihegfnha;kjnfkgbfkabgkbdkgjasng;lkadjg ;oihjr gh cileuwhgiuhetiuoeitoeiutcoihjjjgjhgewjhrgjhwegjrhgejwhgrjwgrjhwgjrgrehjwgrjhgwerewreweuotieorituoiecwo;tijc;oiejt;idijashdasfualwiuhgcilu4htiuh4ithi5uhtchliuw4ithiwuhtrgtjheghjrtgrejtgerghithehtehtkhekrhttrhrkejtkertthhrf https://badrbujbara.medium.com/createreusableswift-packagemoduleswithstoryboardsbe396e01793d"
        
        // When
        let tweetValidation = sut.validateTweetCount(tweet)
        
        // Then
        XCTAssertFalse(tweetValidation)
    }
    
    func testGivenShortTweetWhenCheckTweetCountThenSuccessValidate() {
        // Given
        let tweet = "djasldjlsajdkladksnsndknaskdnkjsandkbaeifh;ihegfnha;kjnfkgbfkabgkbdkgjasng;lkadjg ;oihjr gh https://badrbujbara.medium.com/createreusableswift-packagemoduleswithstoryboardsbe396e01793d"
        
        // When
        let tweetValidation = sut.validateTweetCount(tweet)
        
        // Then
        XCTAssertTrue(tweetValidation)
    }
    
    func testGivenEmojiWhenCheckTweetCountThenSuccessTweetCount() {
        // Given
        let tweet = "💙💙"
        
        // When
        let tweetCount = sut.tweetCount(with: tweet)
        
        // Then
        XCTAssertEqual(tweetCount, 4)
    }
    
    func testGivenEmojiWhenCheckTweetCountThenFailTweetCount() {
        // Given
        let tweet = "💙💙"
        
        // When
        let tweetCount = sut.tweetCount(with: tweet)
        
        // Then
        XCTAssertNotEqual(tweetCount, 2)
    }
    
    
    func testGivenHugeUrlWhenCheckTweetCountThenSuccessTweetCount() {
        // Given
        let tweet = "https://badrbujbara.medium.com/createreusableswift-packagemoduleswithstoryboardsbe396e01793d"
        
        // When
        let tweetCount = sut.tweetCount(with: tweet)
        
        // Then
        XCTAssertEqual(tweetCount, 23)
    }
}
