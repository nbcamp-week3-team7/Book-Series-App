# Book-Series-App Project

이 프로젝트는 **해리포터 시리즈 1~7권**의 책 정보를 볼 수 있는 iOS 애플리케이션입니다. 사용자는 책 목록을 탐색하고, 각 권의 상세 내용을 확인하며, 챕터별 정보를 살펴볼 수 있습니다. Swift와 SnapKit을 활용해 직관적인 UI를 제공하며, JSON 데이터를 기반으로 책 정보를 관리합니다.

---

## 프로젝트 폴더 및 파일 구조

**BookSeriesApp_BY/**

```
├── Application/
│   ├── AppDelegate.swift          // 앱의 진입점 및 생명주기 관리
│   └── SceneDelegate.swift        // 멀티 윈도우 생명주기 관리
├── Controllers/
│   ├── ViewController.swift       // 메인 화면 뷰 컨트롤러 (UI 설정, 데이터 로드)
│   └── BookDetailViewController.swift // 책 상세 화면 뷰 컨트롤러 (StackView 사용)
├── Models/
│   ├── BookDetail.swift           // 책 데이터 모델 정의 및 JSON 파일 디코딩
│   └── DataService.swift          // 데이터 모델 정의 및 JSON 파일 읽기
├── Resources/
│   ├── Assets.xcassets            // 이미지 및 색상 리소스 관리
│   └── Info.plist                 // 앱 설정 정보 파일 (번들 ID, 권한 등)
└── Views/
    └── LaunchScreen.storyboard    // 앱 실행 시 표시되는 스플래시 화면

```

---

## 주요 파일 설명

### **1. AppDelegate.swift 및 SceneDelegate.swift**

- 앱의 생명주기를 관리하며, 멀티 윈도우를 지원합니다.

---

### **2. ViewController.swift**

- 메인 화면의 UI를 관리하고, **해리포터 시리즈 1~7권**의 책 목록을 보여줍니다.
- 주요 기능:
    - 책 데이터를 로드하여 화면에 표시
    - 숫자 버튼을 클릭하면 해당 책의 상세 화면으로 이동
    - 초기 상태에서 첫 번째 책(1권)을 기본으로 표시

---

### **3. BookDetailViewController.swift**

- 선택된 책의 상세 정보를 보여주는 화면을 관리합니다.
- 주요 기능:
    - 책 제목, 저자, 페이지 수, 발행일 등의 정보를 표시
    - 요약(Summary) 텍스트 길이에 따라 "더보기" 버튼 제공
    - SnapKit을 사용하여 UI 구성
    - 챕터별 정보를 리스트 형태로 표시
    - 해리포터 시리즈 각 권에 맞는 커버 이미지를 동적으로 설정

---

### **4. BookDetail.swift**

- 책 데이터 모델을 정의하는 구조체 파일
- 주요 기능:
    - JSON 데이터를 디코딩하여 `Book` 객체로 변환
    - 각 책의 챕터 정보도 포함

---

### **5. DataService.swift**

- JSON 파일에서 데이터를 읽어와 앱에 전달하는 역할
- 주요 기능:
    - 비동기로 데이터를 로드하여 컨트롤러에 전달
    - 로드 실패 시 에러 메시지 표시

---

### **6. LaunchScreen.storyboard**

- 앱 실행 시 표시되는 스플래시 화면을 관리합니다.

---

## 실행 방법

1. **Xcode로 프로젝트 열기**
    
    프로젝트 폴더를 Xcode로 열어 빌드 및 실행합니다.
    
2. **시뮬레이터 또는 실제 디바이스에서 실행**
    
    `Run` 버튼을 클릭하여 앱을 실행합니다.
    

---

## 주요 기능

- **해리포터 시리즈 1~7권 탐색**
    - 각 권의 제목, 저자, 페이지 수, 발행일, 요약 등을 확인할 수 있습니다.
    - 책 커버 이미지는 각 권에 맞는 디자인으로 제공됩니다.
- **책 상세 정보 보기**
    - 선택된 책의 요약 텍스트를 "더보기"/"접기" 버튼으로 관리
    - 챕터별 제목을 리스트 형태로 제공하여 책의 구조를 쉽게 확인 가능
- **숫자 버튼을 통한 탐색**
    - 메인 화면에서 숫자 버튼을 클릭하면 해당 번호에 맞는 책의 상세 정보로 이동합니다.

---

## 해리포터 시리즈 목록

1. **Harry Potter and the Philosopher's Stone**
2. **Harry Potter and the Chamber of Secrets**
3. **Harry Potter and the Prisoner of Azkaban**
4. **Harry Potter and the Goblet of Firen**
5. **Harry Potter and the Order of the Phoenix**
6. **Harry Potter and the Half-Blood Prince**
7. **Harry Potter and the Deathly Hallows**

---

**숫자 버튼을 클릭하여 해리포터 시리즈를 탐색하고, 상세 정보를 확인하세요!**

Enjoy your magical journey with Harry Potter! 🧙‍♂️📚
