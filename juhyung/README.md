# 📚 Harry Potter Book Series App

iOS UIKit 기반으로 제작된 해리포터 시리즈 정보를 보여주는 앱입니다.  
책 제목, 저자, 출간일, 페이지 수, 헌정사, 줄거리, 목차 등의 정보를 시리즈별로 볼 수 있으며, 
각 레벨마다 기능이 점진적으로 확장되거나 리팩토링 하였습니다.

## 📌 기술 스택
- UIKit
- SnapKit
- UserDefaults
- Custom Delegate Pattern
- AutoLayout (가로/세로 대응)
- JSON 기반 데이터 구조

---

## 🚀 기능별 개발 단계

### ✅ LV.1 - JSON 데이터 처리
- `data.json` 파일 내 책 정보 구조화
- `Codable` 구조체를 통해 디코딩 처리

### ✅ LV.2 - 기본 UI 구성
- `UIStackView`를 활용한 책 정보 UI 배치
- `UIImageView`로 커버 이미지 표시

### ✅ LV.3 - 줄거리 영역 구성
- 줄거리 및 헌정사 텍스트 구성
- `UILabel`로 멀티라인 처리

### ✅ LV.4 - 스크롤 처리 및 뷰 분리
- `UIScrollView`로 스크롤 가능하도록 구현
- `inventoryView` / `scrollView`로 상단 고정과 하단 스크롤 분리
- SnapKit을 활용한 명확한 레이아웃 구성

### ✅ LV.5 - 줄거리 더보기/접기 기능
- 글자 수가 430자 이상일 경우 `더보기` 버튼 노출
- `UserDefaults`를 활용해 접힘 상태 유지
- `UIButton` 인터랙션 처리

### ✅ LV.6 - 시리즈 선택 커스텀 뷰
- `SeriesButtonView` 커스텀 뷰 생성
- `Custom Delegate Pattern`으로 ViewController와 연동
- 버튼 스타일 관련 코드를 `UIButton` extension으로 분리

### ✅ LV.7 - 디바이스 회전에 따른 레이아웃 대응
- 가로/세로 모드에서도 버튼이 원형 유지되도록 대응
- `layoutSubviews`와 SnapKit을 활용한 동적 반영
- #### 고려하지 못한 사항
- `viewWillTransition(to:with:)` 을 사용한 동적 반응
- `UIDevice.orientationDidChangeNotification`을 옵저버로 등록하여 회전 이벤트 감지

---

## 👨🏻‍💻 개발자
윤주형

---
