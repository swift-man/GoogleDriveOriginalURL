//
//  TopViewModelSpec.swift
//  GoogleDriveOriginalURLTests
//
//  Created by SwiftMan on 2022/09/06.
//

@testable import GoogleDriveOriginalURL
import Quick
import Nimble

class TopViewModelSpec: QuickSpec {
  override func spec() {
    var viewModel: TopViewModel!
    var subViewModels: [URLInputViewModel]!
    beforeEach {
      let viewModel0 = URLInputViewModel(index: 0)
      viewModel0.input = "https://drive.google.com/file/d/19RK0KgRBnPW8hDSGbVfOhUlrmrBusR8t/view?usp=sharing"
      
      let viewModel1 = URLInputViewModel(index: 1)
      viewModel1.input = "https://drive.google.com/file/d/1nMwa4UyKpUBMAjoeECjKkhEH0aEuVuFI/view?usp=sharing"
      
      let viewModel2 = URLInputViewModel(index: 2)
      viewModel2.input = "https://drive.google.com/file/d/1Ui3kIOWPyRIkJJMNZlluwcEhNkfkmiW8/view?usp=sharing"
      subViewModels = [viewModel0,
                       viewModel1,
                       viewModel2]
      viewModel = TopViewModel(viewModels: subViewModels)
    }
    
    // 어떤 component를 test 하는지 설명 (명사)
    describe("TopViewModel") {
      // test의 목적이나, object의 현재 state (when 으로 시작)
      context("subViewModels") {
        // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
        it("subviewModel count 는 3") {
          expect(viewModel.viewModels.count).to(equal(3))
        }
        it("convertAll") {
          viewModel.convertAll()
          
          expect(viewModel.viewModels[0].input).to(equal("![Image](https://drive.google.com/uc?export=view&id=19RK0KgRBnPW8hDSGbVfOhUlrmrBusR8t)  "))
          expect(viewModel.viewModels[1].input).to(equal("![Image](https://drive.google.com/uc?export=view&id=1nMwa4UyKpUBMAjoeECjKkhEH0aEuVuFI)  "))
          expect(viewModel.viewModels[2].input).to(equal("![Image](https://drive.google.com/uc?export=view&id=1Ui3kIOWPyRIkJJMNZlluwcEhNkfkmiW8)  "))
        }
        it("hasSuccess") {
          viewModel.convertAll()
          expect(viewModel.hasSuccess()).to(equal(true))
        }
        it("copyAll") {
          viewModel.convertAll()
          expect(viewModel.copyAll()).to(equal(
  "![Image](https://drive.google.com/uc?export=view&id=19RK0KgRBnPW8hDSGbVfOhUlrmrBusR8t)  \n![Image](https://drive.google.com/uc?export=view&id=1nMwa4UyKpUBMAjoeECjKkhEH0aEuVuFI)  \n![Image](https://drive.google.com/uc?export=view&id=1Ui3kIOWPyRIkJJMNZlluwcEhNkfkmiW8)  "))
        }
        
        it("undoAll") {
          viewModel.convertAll()
          viewModel.undoAll()
          expect(viewModel.viewModels[0].input).to(equal(""))
          expect(viewModel.viewModels[1].input).to(equal(""))
          expect(viewModel.viewModels[2].input).to(equal(""))
        }
        
        it("clearAll") {
          viewModel.convertAll()
          viewModel.clearAll()
          expect(viewModel.viewModels[0].input).to(equal(""))
          expect(viewModel.viewModels[1].input).to(equal(""))
          expect(viewModel.viewModels[2].input).to(equal(""))
        }
      }
    }
  }
}
