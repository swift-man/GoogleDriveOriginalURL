//
//  URLInputViewModelSpec.swift
//  GoogleDriveOriginalURLTests
//
//  Created by 김승진 on 2021/08/26.
//

@testable import GoogleDriveOriginalURL
import Quick
import Nimble

class URLInputViewModelSpec: QuickSpec {
  override func spec() {
    var viewModel: URLInputViewModel!
    var index: Int!
    beforeEach {
      index = 0
      viewModel = URLInputViewModel(index: index)
    }
    
    // 어떤 component를 test 하는지 설명 (명사)
    describe("뷰 모델 테스트") {
      // test의 목적이나, object의 현재 state (when 으로 시작)
      context("초기화 테스트") {
        // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
        it("input 은 공백") {
          expect(viewModel.input).to(equal(""))
        }
        it("placeholder 는 샘플 + index") {
          expect(viewModel.placeholder).to(equal("https://drive.google.com/file/d/xxxx\(index!)/view?usp=sharing"))
        }
        it("leftImageName 는 checkmark.square.fill") {
          expect(viewModel.leftImageName).to(equal("checkmark.square.fill"))
        }
        it("leftImageColor 는 clear") {
          expect(viewModel.leftImageColor).to(equal(.clear))
        }
      }
      
      context("성공 테스트") {
        // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
        beforeEach {
          viewModel.input = "https://drive.google.com/file/d/19RK0KgRBnPW8hDSGbVfOhUlrmrBusR8t/view?usp=sharing"
          viewModel.convertAll()
        }
        
        it("leftImageName 는 checkmark.square.fill") {
          expect(viewModel.leftImageName).to(equal("checkmark.square.fill"))
        }
        it("leftImageColor 는 green") {
          expect(viewModel.leftImageColor).to(equal(.green))
        }
      }
      
      context("실패 테스트") {
        // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
        beforeEach {
          viewModel.input = "fdasfsfds"
          viewModel.convertAll()
        }
        
        it("leftImageName 는 exclamationmark.octagon.fill") {
          expect(viewModel.leftImageName).to(equal("exclamationmark.octagon.fill"))
        }
        it("leftImageColor 는 red") {
          expect(viewModel.leftImageColor).to(equal(.red))
        }
      }
    }
  }
}
