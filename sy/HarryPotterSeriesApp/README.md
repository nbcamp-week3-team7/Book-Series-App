# 📚 Harry Potter Series App

해리포터 시리즈 책 정보를 탐색할 수 있는 iOS 앱입니다.  
각 시리즈별로 책의 표지, 저자, 출간일, 페이지 수, 헌사, 요약, 챕터 목록 등을 볼 수 있으며, 요약은 "더 보기/접기" 기능을 지원합니다.  
사용자는 시리즈 버튼을 통해 각 시리즈의 책 정보를 탐색할 수 있습니다.

<h3>📱 메인 화면</h3>
<img src="screenshots/Simulator Screenshot - iPhone 16 Pro Max - 2025-04-04 at 10.52.25.png" width="200"/>

<h3>📚 가로모드 화면</h3>
<img src="screenshots/Simulator Screenshot - iPhone 16 Pro Max - 2025-04-04 at 10.52.45.png" width="400"/>

<h3>📝 요약 더 보기 화면</h3>
<img src="screenshots/Simulator Screenshot - iPhone 16 Pro Max - 2025-04-04 at 10.53.02.png" width="200"/>


<br>

## 🚀 주요 기능

### 1. 시리즈 선택 기능
- **설명**: 화면 상단의 번호 버튼을 통해 각 해리포터 시리즈를 선택할 수 있습니다.
- **구현**
  - `addSeriesButtons()` : 버튼 생성 및 액션 연결
  - `seriesButtonTapped(_:)` : 선택된 시리즈에 맞춰 UI 업데이트

### 2. 책 상세 정보 표시
- **설명**: 선택한 책의 표지 이미지, 제목, 저자, 출간일, 페이지 수 등 상세 정보를 보여줍니다.
- **구현**
  - `updateBookDetailView(_:)` : 책 정보 업데이트
  - `formatDate(_:)` : 날짜 포맷 변환

### 3. 요약 "더 보기 / 접기" 기능
- **설명**: 요약 글이 길 경우, 처음에는 7줄까지만 표시되고 "더 보기" 버튼을 통해 전체 내용을 펼칠 수 있습니다.
- **구현**
  - `updateLabelWithReadMore(_:)` : 텍스트 길이에 따라 버튼 활성화
  - `toggleSummaryText()` : 버튼 클릭 시 토글 동작
  - **데이터 유지**: `UserDefaults`를 사용하여 확장 상태 유지

### 4. 챕터 리스트 표시
- **설명**: 선택한 책의 챕터 목록을 나열합니다.
- **구현**
  - `addChapters(_:)` : 선택된 책의 챕터를 스택 뷰에 추가

### 5. 데이터 로딩 및 오류 처리
- **설명**: `DataService`를 통해 책 데이터를 로드하며, 실패 시 alert 표시
- **구현**
  - `loadBooks()` : 비동기 데이터 로딩
  - 실패 시 `UIAlertController`로 사용자에게 알림

<br>

## 🛠️ 사용된 기술 스택

| 기술 | 설명 |
|------|------|
| **Swift** | 앱 전체 로직 구현 |
| **UIKit** | 화면 UI 구성 |
| **SnapKit** | 코드 기반 오토레이아웃 |
| **UserDefaults** | 요약 펼침 상태 저장 |
| **클로저 기반 데이터 로딩** | 비동기 데이터 로딩 패턴 적용 |

<br>

## 🖥️ 주요 UI 구성

| 컴포넌트 | 설명 |
|---------|------|
| `UILabel` | 책 제목, 저자, 출간일, 페이지 수, 요약 등 텍스트 표시 |
| `UIButton` | 시리즈 선택 버튼, 요약 더 보기/접기 버튼 |
| `UIImageView` | 책 표지 이미지 |
| `UIStackView` | 뷰 정렬 및 레이아웃 |
| `UIScrollView` | 콘텐츠 스크롤 지원 |
