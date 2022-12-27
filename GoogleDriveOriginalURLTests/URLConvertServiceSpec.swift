//
//  URLConvertService.swift
//  GoogleDriveOriginalURLTests
//
//  Created by 김승진 on 2021/08/26.
//

@testable import GoogleDriveOriginalURL
import Quick
import Nimble

class URLConvertServiceSpec: QuickSpec {
  
  override func spec() {
    var service: URLConvertService!
    
    beforeEach {
      service = URLConvertService()
    }
    
    describe("서비스 테스트") {
      context("초기화 테스트") {
        it("inputSubject state 는 노말, 텍스트 공백") {
          let value = service.inputSubject.value
          expect(value.state).to(equal(.normal))
          expect(value.text).to(equal(""))
        }
      }
      
      context("convertInputURL hasMarkdownTag: false hasMarkdownEnterKey: true") {
        it("https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing") {
          
          
          service.convertInputURL(hasMarkdownTag: false,
                                  hasMarkdownEnterKey: true,
                                  input: "https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing")
          let value = service.inputSubject.value
          expect(value.state).to(equal(.success))
          expect(value.text).to(equal("https://drive.google.com/uc?export=view&id=1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_  "))
        }
      }
      
      context("convertInputURL hasMarkdownTag: true hasMarkdownEnterKey: true") {
        it("https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing") {
          service.convertInputURL(hasMarkdownTag: true,
                                  hasMarkdownEnterKey: true,
                                  input: "https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing")
          let value = service.inputSubject.value
          expect(value.state).to(equal(.success))
          expect(value.text).to(equal("![Image](https://drive.google.com/uc?export=view&id=1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_)  "))
        }
      }
      
      context("convertInputURL hasMarkdownTag: true hasMarkdownEnterKey: false") {
        it("https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing") {
          service.convertInputURL(hasMarkdownTag: true,
                                  hasMarkdownEnterKey: false,
                                  input: "https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing")
          let value = service.inputSubject.value
          expect(value.state).to(equal(.success))
          expect(value.text).to(equal("![Image](https://drive.google.com/uc?export=view&id=1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_)"))
        }
      }
      
      context("convertInputURL hasMarkdownTag: true hasMarkdownEnterKey: false") {
        it("https://drive.google.com/file/d/1gYZo2WfamjWpI_bpZQ20d48X6ofh-0Zh/view?usp=share_link") {
          service.convertInputURL(hasMarkdownTag: true,
                                  hasMarkdownEnterKey: false,
                                  input: "https://drive.google.com/file/d/1gYZo2WfamjWpI_bpZQ20d48X6ofh-0Zh/view?usp=share_link")
          let value = service.inputSubject.value
          expect(value.state).to(equal(.success))
          expect(value.text).to(equal("![Image](https://drive.google.com/uc?export=view&id=1gYZo2WfamjWpI_bpZQ20d48X6ofh-0Zh)"))
        }
      }
      
      context("convertInputURL hasMarkdownTag: true hasMarkdownEnterKey: false") {
        it("https://drive.google.com/file/d/1xVo0pHtdNNFc-XZTmBBmKx-wFm53qups/view?usp=share_link") {
          service.convertInputURL(hasMarkdownTag: true,
                                  hasMarkdownEnterKey: false,
                                  input: "https://drive.google.com/file/d/1xVo0pHtdNNFc-XZTmBBmKx-wFm53qups/view?usp=share_link")
          let value = service.inputSubject.value
          expect(value.state).to(equal(.success))
          expect(value.text).to(equal("![Image](https://drive.google.com/uc?export=view&id=1xVo0pHtdNNFc-XZTmBBmKx-wFm53qups)"))
        }
      }
    }
  }
}
