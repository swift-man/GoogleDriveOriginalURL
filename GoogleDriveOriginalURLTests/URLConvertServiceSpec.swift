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
      
      context("convertInputURL hasMarkdownTag: false") {
        it("https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing") {
          service.convertInputURL(hasMarkdownTag: false,
                                  input: "https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing")
          let value = service.inputSubject.value
          expect(value.state).to(equal(.normal))
          expect(value.text).to(equal("https://drive.google.com/uc?export=view&id=1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_"))
        }
      }
      
      context("convertInputURL hasMarkdownTag: true") {
        it("https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing") {
          service.convertInputURL(hasMarkdownTag: true,
                                  input: "https://drive.google.com/file/d/1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_/view?usp=sharing")
          let value = service.inputSubject.value
          expect(value.state).to(equal(.normal))
          expect(value.text).to(equal("![Image](https://drive.google.com/uc?export=view&id=1CuhXzbSrIdJjjs4DpbOl_O18oKV4FiL_)"))
        }
      }
    }
  }
}
