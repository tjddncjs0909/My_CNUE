# #소스코드 비공개#
- 2023/02/26 ~ 2023/03/01 : API Key Number, DB 규칙 관련 문제로 인해서 일시적으로 소스코드를 비공개로 바꾸어두었습니다.
- Deleting File(android/app/src/main/AndroidManifest.xml) : For Hiding API Key number;

# My CNUE(최신 버전 : ver 1.0.0 + 3)
Flutter(Dart)를 이용해 만든 앱입니다.
학우분들의 학교생활에 도움이 될만한 기능들을 넣어 보았습니다.

On Google Play Store : https://play.google.com/store/apps/details?id=com.cnue_food_app

- 학식 메뉴는 메뉴표가 생활관 홈페이지에 업로드 될 경우, 일요일 석식 운영 종료 이후 최대한 빠른 시간 내에 업로드 하도록 하겠습니다.
- 앱 내부의 오탈자나 오류는 하단 연락처로 문의 주시면 최대한 빠른 시간 내에 피드백을 드리도록 하겠습니다.
- - E-mail : tjddncjs0909@naver.com
- - 오픈 채팅방 : https://open.kakao.com/o/sI8WKr7e
- 해당 앱은 춘천교대 재학생이 만든 앱으로, 학교 측 및 관련 기관과 무관하게 비영리(상업적 x)목적으로 개발이 이루어졌음을 사전에 알려 드립니다.
- 현재 개발자의 IOS 버전(IPhone) 개발 환경 부재로 Android 버전(Galaxy)만 출시할 예정입니다.

# 업데이트 사항
구글 플레이스토어의 앱 심사기간 지연에 의해 업데이트가 늦어질 수 있습니다. 업데이트 사항이 있을 경우, 이 곳을 통해 공지하도록 하겠습니다.

# ver 1.0.0 + 3
- 플레이스토어 정책에 맞게 변경 : AndroidManifest.xml에서 Background Location Permission 비활성
- 일부 휴대폰 모델에서 글자가 짤리는 현상(오버플로우) 해결
- Firebase DB 연동 : 제휴식당 => 이제 학식과 마찬가지로 제휴식당 현황을 실시간으로 받아보실 수 있습니다.

# 개발 예정 기능(ver 1.0.1 예정)
- 로그인 기능(카카오 계정 로그인 API 활용)
- 학식 및 제휴식당 평가(후기) 기능 : 채팅 및 좋아요
- 학식 메뉴 업데이트 및 제휴식당 추가 현황 알림(PUSH 알림)
- 학교 공지사항을 링크 접속이 아닌 앱 내부에서 리스트로 빠르게 확인 가능하도록 구현 예정
- UI 개선
- Firebase DB 연결 방식 변경(앱 최적화 작업) : One-Time Read(현재) => Stream(예정)

## Getting Started

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
