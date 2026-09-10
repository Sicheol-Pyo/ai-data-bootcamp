# portfolio / profile / transcript 탐색적 데이터 분석 보고서

> 3개 파일(portfolio.json, profile.json, transcript.json)을 각각 `eda_diagnostics.py`로 개별 진단한 뒤 하나의 리포트로 결합함. 각 섹션은 파일 단위로 나누어 기재.

## 1. 데이터 개요

### 1-1. portfolio
- 행/열: 10 × 6
- 주요 컬럼: reward, channels, difficulty, duration, offer_type, id

- column 별 data type

| 순번 | 컬럼명(원본) | Datatype(의미 간단히 괄호 표기) |
|---|---|---|
| 1 | reward | int64 (오퍼 완료 시 지급되는 보상 포인트) |
| 2 | channels | object(list) (오퍼 발송 채널 목록: email/mobile/social/web) |
| 3 | difficulty | int64 (오퍼 달성에 필요한 최소 지출 금액) |
| 4 | duration | int64 (오퍼 유효 기간, 일 단위) |
| 5 | offer_type | object(str) (오퍼 유형: bogo/discount/informational) |
| 6 | id | object(str) (오퍼 고유 식별자) |

### 1-2. profile
- 행/열: 17000 × 5
- 주요 컬럼: gender, age, id, became_member_on, income

- column 별 data type

| 순번 | 컬럼명(원본) | Datatype(의미 간단히 괄호 표기) |
|---|---|---|
| 1 | gender | object(str) (성별 코드: M/F/O) |
| 2 | age | int64 (나이) |
| 3 | id | object(str) (고객 고유 식별자) |
| 4 | became_member_on | int64 (가입일, YYYYMMDD 정수 인코딩) |
| 5 | income | float64 (연소득, 달러 단위) |

### 1-3. transcript
- 행/열: 306534 × 4
- 주요 컬럼: person, event, value, time

- column 별 data type

| 순번 | 컬럼명(원본) | Datatype(의미 간단히 괄호 표기) |
|---|---|---|
| 1 | person | object(str) (고객 id, profile.id를 참조하는 외래키) |
| 2 | event | object(str) (이벤트 유형: offer received/offer viewed/offer completed/transaction) |
| 3 | value | object(dict) (이벤트 부가정보, 이벤트 유형별로 포함 키가 다름) |
| 4 | time | int64 (실험 시작 후 경과 시간, 시간 단위) |

## 2. 진단 결과

### 2-1. portfolio

**결측**

결측 컬럼 없음 (0건)

**이상치**

| 컬럼명 | 유효건수 | 왜도 | IQR 건수(%) | Z-score 건수(%) | MAD 건수(%) |
|---|---|---|---|---|---|
| reward | 10 | 0.6655 | 20.00 | 0.00 | 0.00 |
| difficulty | 10 | 0.6699 | 10.00 | 0.00 | 0.00 |
| duration | 10 | 0.2332 | 0.00 | 0.00 | 0.00 |

- 방법별 상위 이상치 (식별 컬럼: id)

| 컬럼 / 방법 | id | 값 |
|---|---|---|
| reward / IQR | ae264e3637204a6fb9bb56bc8210ddfd | 10 |
| reward / IQR | 4d5c57ea9a6940dd891ad53e9dbe8da0 | 10 |
| difficulty / IQR | 0b1e1539f2cc45b7b9fa7c272da2e1d7 | 20 |

**중복**

| 기준 | 중복 행 수 |
|---|---|
| 전체 행 기준 | 0건 |
| 자연키(id) 기준 | 0건 |

### 2-2. profile

**결측**

| 컬럼명 | 결측 개수 | 결측률(%) |
|---|---|---|
| gender | 2175 | 12.79 |
| income | 2175 | 12.79 |

- 그룹/시간 변수 후보 없음 → 그룹별 결측률 표 생략 (스크립트가 자동 탐색한 그룹 후보 컬럼 중 gender·income 자신을 제외하면 저카디널리티 후보가 없음)

**이상치**

| 컬럼명 | 유효건수 | 왜도 | IQR 건수(%) | Z-score 건수(%) | MAD 건수(%) |
|---|---|---|---|---|---|
| age | 17000 | 0.7619 | 12.79 | 0.00 | 0.00 |
| income | 14825 | 0.4020 | 0.00 | 0.00 | 0.00 |

- 방법별 상위 이상치 5건 (식별 컬럼: id)

| 컬럼 / 방법 | id | 값 |
|---|---|---|
| age / IQR | 68be06ca386d4c31939f3a4f0e3dd783 | 118 |
| age / IQR | 38fe809add3b4fcf9315a9694bb96ff5 | 118 |
| age / IQR | a03223e636434f42ac4c3df47e8bac43 | 118 |
| age / IQR | 8ec6ce2a7e7949b1bf142def7d0e0586 | 118 |
| age / IQR | 68617ca6246f4fbc85e91a2a49552598 | 118 |

**중복**

| 기준 | 중복 행 수 |
|---|---|
| 전체 행 기준 | 0건 |
| 자연키(id) 기준 | 0건 |

### 2-3. transcript

**결측**

결측 컬럼 없음 (0건)

**이상치**

| 컬럼명 | 유효건수 | 왜도 | IQR 건수(%) | Z-score 건수(%) | MAD 건수(%) |
|---|---|---|---|---|---|
| time | 306534 | -0.3189 | 0.00 | 0.00 | 0.00 |

- 방법별 상위 이상치: 해당 없음 (세 방법 모두 0.00%)

**중복**

| 기준 | 중복 행 수 |
|---|---|
| 전체 행 기준 | 397건 |
| 자연키(person, event, time, value) 기준 | 397건 |

- 자연키(person, event, time, value) 중복 행 전체 (396개 그룹, 393개 그룹은 중복 2회·1개 그룹은 중복 3회)

| person | event | time | value | 중복 횟수 |
|---|---|---|---|---|
| 00d7c95f793a4212af44e632fdc1e431 | offer completed | 504 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 01925607d99c460996c281f17cdbb9e2 | offer completed | 510 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 01956670cf414b309675aa73368b94a9 | offer completed | 420 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 01ff6c5d8d014dbd8c120e2b43a065ea | offer completed | 444 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 0200f61c69da4c2ea078842cdaf234e6 | offer completed | 450 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 0246f8fdf0b64014a98822b70231c58d | offer completed | 450 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 034b962ed61d4da1bb0baaec84cc2e85 | offer completed | 642 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 03b326a99f5345df8b4d21ed26bdb0da | offer completed | 618 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 041967ceb80841ddbd306958d4f744ac | offer completed | 576 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 04362cece3104f4ebcb3d49ef0bc7e9c | offer completed | 486 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 04cb9d0033f142efa2a367f4ef273460 | offer completed | 582 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 04f1f44632cd409cace939fa62b5fc7a | offer completed | 582 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 06f4bfb1cb4c4c968add3d9980a279fa | offer completed | 414 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 0785f1fce0b04ba08e01c7d2ebab4917 | offer completed | 708 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 08d03b9d8e3c4e33b87df24433217301 | offer completed | 414 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 08df8f2800684b3ba9e1e18d76ef51dd | offer completed | 516 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 0976fd3ecfb84e1ca92d90b6adc2001c | offer completed | 660 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 09ac1d69e9f74deb835ecdfac30ae8f1 | offer completed | 540 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 0c7ba4aca9f3477ba0d105f3763f5871 | offer completed | 354 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 0d090272e52845acab67d8eaf8960366 | offer completed | 468 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 0d0c8b66f0954686ad82e5eb8a61baf6 | offer completed | 660 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 0ec92c145b6e46e4b453b0a12099b404 | offer completed | 516 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 0f0c770d5eaa4ebe9ca67f8c5c240f76 | offer completed | 654 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 0f2c815583284499a7045ebb875a4237 | offer completed | 594 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 0f6cf9619c4341e89a099e951300a2ea | offer completed | 552 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 0f792a0ea8cb4a6c86cf52c055f1510f | offer completed | 546 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 0fc637442b954432b13c360af61d4256 | offer completed | 444 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 10a22481775043e1ba9776077e46c483 | offer completed | 606 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 122c0c2a3c2540848f8c3fdc37e97639 | offer completed | 648 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 1261cf51692541a5bdf39f0aa36b65f7 | offer completed | 414 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 1278a41a8ae24324a17ca2c69b3023ab | offer completed | 666 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 12e0c95d8db54ee48800073d5b0a1269 | offer completed | 426 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 141e082d59ef48759823ab1ddcfe1f7a | offer completed | 558 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 14f12efd9aa04c009e9bde68d66509e5 | offer completed | 510 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 157034648e3b422f8f7af11778bacb69 | offer completed | 660 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 15d02d3266d14a3ea21b016fc045726d | offer completed | 588 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 181a9ffd330e4f89a93a812ae2653880 | offer completed | 504 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 184c1819ba144e4784667f14f7e7ba08 | offer completed | 498 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 1853362ad12c41bc8d7fefc8bafbe90a | offer completed | 576 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 1a6441a8ccd74a81a388841d357b8c0d | offer completed | 594 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 1abeb816d9fa49b4b5b5ae51bc3d24c3 | offer completed | 198 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 1acb3e87e3304271a3c917cc80a53780 | offer completed | 600 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 1bd39a23d8434c07b9da5664191d017d | offer completed | 612 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 1bd41beee6624c11a3c8948ab7df415e | offer completed | 576 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 1bdb72b74a1c45dfaa55fde628c23580 | offer completed | 408 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 1bde4b674a1a442cbe6af847c9d6f2cc | offer completed | 576 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 1bfcd756898445fbb1cf02cbe082b89e | offer completed | 420 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 1c4760d0d9ed47898c460370387c8918 | offer completed | 414 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 1c48906ea3674e5ea5d4392e556c250c | offer completed | 516 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 1c915596914b4931b6dd2386601ae325 | offer completed | 420 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 1cb38fd0d87f416ebb598072f22a7c66 | offer completed | 570 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 1cb3a1e696f3495795deb0a17c07d869 | offer completed | 462 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 1d2018a7775c4c73b084e9c701560092 | offer completed | 654 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 1d4accd4959644ffbf54d95ce72ce03b | offer completed | 630 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 1dc461d98e5c4a5a9b320b78e0ca1efd | offer completed | 642 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 1e1c90f7f2a547f58221627486d01c78 | offer completed | 540 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 1e5d6388b5214fefb090a9a2a4d21983 | offer completed | 456 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 1f03595b20254b86b7d11344ad8493c9 | offer completed | 486 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 1f1c409789c247cba9b50d63aa078fcc | offer completed | 414 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 1f6ad0a8def240b3ad633f83032dedd8 | offer completed | 504 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 1fa82206929541b6bc0f19f01cd04aa6 | offer completed | 546 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 206ce5f33eb14623888263d2b945d089 | offer completed | 570 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 20ba03a88c4e4ee6aef6201a94b8e67d | offer completed | 648 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 2100a915e90a4078b87eefe030c6aba3 | offer completed | 546 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 227f7c7fcd3f445691431763078d39b1 | offer completed | 414 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 22fb7286392241b5a8c92be7a23a04a9 | offer completed | 450 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 254e6c47c1a84907a3d21fb3593d569d | offer completed | 444 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 2584539e0cdc4fb2b3e5f96a4926be39 | offer completed | 552 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 26c210f0e0c249f597a2a5663d4fead2 | offer completed | 456 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 27846a455b1b43a9a4f01b70b37dd781 | offer completed | 612 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 27aa749a6f5f448e91327028a2ac7fb5 | offer completed | 426 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 28254160875943e883e1ed9460f8d65f | offer completed | 570 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 28b3a891cbfa45b1b4f242a8ae561cca | offer completed | 606 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 2a18130a7d8e4824a57f2a9ef8c9920b | offer completed | 618 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 2ae0eb4401a244b7b81a88f47539e82e | offer completed | 450 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 2c4cee9819af47e78a2a9fc5030921a8 | offer completed | 588 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 2d0074b84a99445dab755f246f533f59 | offer completed | 636 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 2d422052c9634638b4ef7505801a0168 | offer completed | 504 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 2de68905470540e6a991f0763654d3c4 | offer completed | 624 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 2ea50de315514ccaa5079db4c1ecbc0b | offer completed | 528 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 301fd1800ffd4897aed469da5705e223 | offer completed | 432 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 30478a4c1e884a63a822aa87b833ed7a | offer completed | 168 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 3069fa61e49643aa8554d080dcdddf41 | offer completed | 468 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 30f3d9f353184acb99e8ab35f1db3745 | offer completed | 504 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 310481d911904e7893fac7229a608be8 | offer completed | 600 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 33be916683434fa3b66027d490a33e2c | offer completed | 408 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 34064317a1c84e2f8872964d1d5a2a59 | offer completed | 516 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 34302ff0fcf8450eb335db6e878080db | offer completed | 438 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 3526938fb466470190a504a751ec07b0 | offer completed | 510 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 3 |
| 3579056d94644a9481e05012b48fe252 | offer completed | 504 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 35b3206b05304a518114bee3e113af09 | offer completed | 576 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 35dd7d2deb184c159756d2132964448b | offer completed | 456 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 36db5f33ad944cb095d20ecbdede53f9 | offer completed | 366 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 372f2fcc8db44c739284e6546905961a | offer completed | 468 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 37aa48f7035f4b808d8292f5c95fd55f | offer completed | 534 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 39437fa966ad4de0bc8afe8906778822 | offer completed | 426 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 3a97fdd1f1aa42ca989e9fcec3f6e043 | offer completed | 546 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 3b3f94dcf71d4d87884b335b9301b1c6 | offer completed | 612 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 3b55c82b756646458d17dcdae6d66847 | offer completed | 594 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 3c76c38021e6465382c960230b141b88 | offer completed | 516 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 3c92e46731364dd1b4d07ed2f9393364 | offer completed | 474 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 3d073e2d43f04815a4c84e53b36e3a5c | offer completed | 432 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 3d6ea609611147dd8a7a75dc5a154f11 | offer completed | 360 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 3d9a80a23be6486687c5c4433834b030 | offer completed | 576 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 3dde94fa581145cb9f206624f1a94d5a | offer completed | 168 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 3e73ba9f97144addb9cb17ac324b77ff | offer completed | 654 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 3ead7d94371041fcab4db5fb57ced95c | offer completed | 606 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 3f08e8eeb88e43079a103ed1af07e220 | offer completed | 504 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 3fa1eb81473c41459439cd5749c49cb4 | offer completed | 630 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 3fd0feaf8a5344d1a17be1707205814b | offer completed | 462 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 400b0b26df05490381f988a896541cf6 | offer completed | 570 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 41354aa288d14c75b25b41f5781a0a90 | offer completed | 510 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 41a140a85d05424489c6d0c264ba68d8 | offer completed | 444 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 41aee69895c341108f1e4d65a711f8b9 | offer completed | 510 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 425baccbe9154f13844934c24b68b38e | offer completed | 480 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 425baccbe9154f13844934c24b68b38e | offer completed | 606 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 4357cb4e15f04f988045c5a7e37c5775 | offer completed | 600 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 436552d254074769ad35ed793c30953e | offer completed | 558 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 455d955f7c364290bd59e0c67f422324 | offer completed | 426 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 45e5d63c00cc41bd8d8d6f11e43b4d67 | offer completed | 576 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 464d2302b99b46ad8eb3e42e1b849c24 | offer completed | 336 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 46aeb00f90d24417bf50714359cd0ea5 | offer completed | 582 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 46e3831f06254440a99bf4c371e378ff | offer completed | 444 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 471938c318674a30afea015be6396cbd | offer completed | 414 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 47e9f9fcd7a248aca993ab995f072552 | offer completed | 630 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 4a3579f62ba94e8eb1cc6657d51a5deb | offer completed | 600 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 4b9a3bf77bb64f4ca41e314aa24fc36a | offer completed | 588 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 4bdd34a262b24807a6f327967aa42ea6 | offer completed | 444 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 4d17f173ee4d460f9e51ecfe83a45f8e | offer completed | 606 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 4d87aabb26bd45a9acdaec688cac7e20 | offer completed | 426 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 4e44a658d07f417dbba5ce73b6496194 | offer completed | 426 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 4f3a81d69e5a4c6eb15f4a2fe2e628b1 | offer completed | 438 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 502fe9a3e84b43c5a1d2109012dc2eed | offer completed | 426 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 533a4239021f415b8870ca91f0fadc5c | offer completed | 408 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 535966e0a95d45389d4b8e935723b046 | offer completed | 546 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 535b7a61cbaf44b18057a564ea3fa32b | offer completed | 534 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 53e8bb88915e405db140e25ae136bf1d | offer completed | 426 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 546267273d6041f48946369c65c11531 | offer completed | 420 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 55103915b4bf48d1b8b51117f426dcb5 | offer completed | 594 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 5542548657844f19994f31c720c418e9 | offer completed | 618 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 562b9efc809b4bd897ce0381347aaea2 | offer completed | 528 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 5638a1d0d55a4556a64a87118fdfe695 | offer completed | 642 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 57accabdb8df429d983a7ac0ddd50892 | offer completed | 618 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 58685d6f468c4410bda5757c71039d60 | offer completed | 636 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 59c695f79cbd4d56b8011c7ce13c5c39 | offer completed | 510 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 5a7136999fa240838c28e52359f6533d | offer completed | 618 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 5ae36f912be1492199ec2da838cc6dda | offer completed | 558 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 5b36a2e916bd41ed8e708384df094e77 | offer completed | 534 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 5b6af3aac7b046fface51ffb1eeefe70 | offer completed | 456 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 5bbadf84eabe4fa3a7da35e3f44f8a2c | offer completed | 408 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 5bd4ef761f804ba4be5f96bb0c59e7b3 | offer completed | 534 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 5bde1a82680d41aba0eb33627e188eaf | offer completed | 576 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 5c0d7f5f799c4f808819e01db246e0a0 | offer completed | 438 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 5cccab62e4f3456f9824f1930e1da5dc | offer completed | 522 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 5cef0c15057e493d8e90eaa4fb85b4c3 | offer completed | 414 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 5cfc907778a9457382cf0731819cebe2 | offer completed | 480 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 61e3b59b13ad4cce9c3e92bc612de8b8 | offer completed | 600 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 6368c154e8014fa49bc178a60f453b04 | offer completed | 612 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 64819ea1d8b64913a80d8ea0b9f071c5 | offer completed | 210 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 65662d07621d408eab4f81f7ac19d1f2 | offer completed | 444 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 6597e5ab63754726b83ba2032f008d26 | offer completed | 510 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 65df8f20c8d94f7284c6e94556320a11 | offer completed | 618 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 65e8796e81f2400ea600a24519054a5e | offer completed | 414 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 67262718a9d84484abd5e59073bfc05b | offer completed | 588 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 67270b961f1c422e991373e75a4f2f40 | offer completed | 606 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 672f9ec4a89b42f08bfc06905d316e0a | offer completed | 576 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 6765989bf3aa45b388e1ebf578fccdc8 | offer completed | 588 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 677b68c6df3449c2a2853d551c8b2ac3 | offer completed | 522 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 67f1a9d497ee467ca2a679c84bb387a0 | offer completed | 564 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 684db2c7aa474355ab2cc55a7b5af3ce | offer completed | 576 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 69743d51492d4173b0e054fd5d8f943c | offer completed | 576 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 6ad061a0de7049a194735a19eff2279d | offer completed | 624 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 6ba2450a438540999e633a5d99c7c7a0 | offer completed | 672 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 6c5e611cd1284709b634ff1740d13265 | offer completed | 576 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 6c9b18ecc7054a3fa2e56d793a09f46b | offer completed | 576 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 6cb5028f502a40f2b444e2000b085723 | offer completed | 438 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 6cde0dadd1154cf89694618ce6f249da | offer completed | 666 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 6d5da41e6c85436782eafe2fedd00dad | offer completed | 504 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 6d6c0aa032064438b97ab5dc28fd1b61 | offer completed | 432 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 6d6c0aa032064438b97ab5dc28fd1b61 | offer completed | 594 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 6fa9ef8890bc467699ce92f2679a4178 | offer completed | 624 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 70dd84bdef064ba6905b85f4ff132afb | offer completed | 600 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 711ddbe357b447c0ae2aa054a6166213 | offer completed | 576 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 714fc5d966a249ae92794992198dae5c | offer completed | 516 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 7286558fde4642518fcd9a35e377cb56 | offer completed | 408 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 73e1f6bb3fe04429bf3ffc04c89ff7f9 | offer completed | 654 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 7584bd98a6a5473496c723a31e5898b0 | offer completed | 420 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 76358128b4bb47fcb712c0198f5121d1 | offer completed | 408 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 76bd8ff0850b46c3bb5b309fb44c4b81 | offer completed | 654 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 77285ad5e23b4777929521ff377719d0 | offer completed | 480 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 77fa13a472824e33aaeb9aaeb2c23408 | offer completed | 504 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 788db6a5814247e38bac0a3c0c56ec96 | offer completed | 528 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 78c2d93381464a3f9032eb9a643e25fe | offer completed | 546 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 78d968c803724eb5812a988d5156f943 | offer completed | 216 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 7924f921b7f04e34aafd37c1b58a4ca9 | offer completed | 564 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 793a91c8f72d450294f732f60cc2071b | offer completed | 612 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 79e3b16de4964b6c82e45e0014a42502 | offer completed | 456 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 7a05e9c1b0e64acdb40b0ecba4b0ba9d | offer completed | 432 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 7b249c93b5194a65911b9851729caa4b | offer completed | 372 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 7c28c02a5067425dbaf0533a7bb4b053 | offer completed | 630 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 7cd890d4d691465aa25b683943a1c056 | offer completed | 186 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 7d42182778104595bb6d5e920a767eca | offer completed | 432 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 7dacdd20bc9143ccb6c1a08391970d44 | offer completed | 570 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 7dd5e5a95fea44f98af8c2c8d4c85e17 | offer completed | 498 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 7e000dcb51f84ee2809f728294e5b92c | offer completed | 630 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 7e66f9d836bd42ad9a6a89ab2128313e | offer completed | 594 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 7f27070d07eb44cb89b9a547074ca343 | offer completed | 576 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 7f57c1760524405f8e23871c1d80694a | offer completed | 234 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 80d91a0adda54866a74399da38129f9f | offer completed | 576 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 819cb059e86f4a8a92beca0fd172d36c | offer completed | 672 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 81c0582ea9ba4d8ca9ef401031694569 | offer completed | 558 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 8214a0d3138c47ee8397379d15178fd3 | offer completed | 588 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 821da2e4b19a4807ab2e68a7c0112789 | offer completed | 504 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 82bdb81319ec44bebe29907b8d1afb69 | offer completed | 420 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 8327c7a472974fbb9569532a55c07204 | offer completed | 198 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 84fb57a7fe8045a8bf6236738ee73a0f | offer completed | 168 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 856f018e2ae94741a673c3acbd9e1b88 | offer completed | 414 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 862ea30ca6cf4050b66349d7551bce9c | offer completed | 618 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 87ab31c624964083bb6a4e3a64fd7c55 | offer completed | 612 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 87b495683ce645ea96131505c5855947 | offer completed | 438 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 87c6f338c6eb4e37899325caa5bd5f38 | offer completed | 534 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 87cef380122f4b21bd8b60979340eb2b | offer completed | 510 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 8836295fb69f4c53aa23c7b614cff7bf | offer completed | 582 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 888df122aac141adb08b7983ce2d9405 | offer completed | 474 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 88db910b5b2f414ca7038d8df1faf251 | offer completed | 486 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 8968b3baa32549ec93539f93c817d122 | offer completed | 594 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 89e71ea899a44ec39624a4b522b4fa9b | offer completed | 468 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 8b9d3f738e7e499b9e820de07c16bc62 | offer completed | 630 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 8c80570b7dfb49629e86042c17e659dc | offer completed | 606 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 8ca32e0f16964fcbae0d3773c536d21f | offer completed | 420 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 8f5146270f5745d4862514da8a7b6620 | offer completed | 510 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 8f90fb8f93304318b7b0dc8621673c71 | offer completed | 438 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 91076437219d41eeab0035d1e1419925 | offer completed | 516 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 9167e9a964144abcb7c1b7d634f4d71d | offer completed | 534 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 91e68a13d7e5471cb53796d45b04f359 | offer completed | 594 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 93e4116ad8ea412bba3fe889300f2e00 | offer completed | 528 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 94aad22681a345be8106c8924f30173c | offer completed | 438 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 94f14dcfedba47e18b7efca13dd7574b | offer completed | 480 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 9582c1eb7ef449f4863975513eef6cea | offer completed | 672 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 970d7af2030742f2a098184bea0da030 | offer completed | 510 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 9773a632734541e28fa06a6260e218ed | offer completed | 624 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 978d48db5c714a4490d904412f85b502 | offer completed | 564 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 98c1b918a5ed47758c74bf3450b3dc2a | offer completed | 420 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 99148a450059428180ed37cb9ab01f62 | offer completed | 642 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 991d346a4fbf477492216394f803cf70 | offer completed | 648 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| 994b6ef7a8ca46e3b379518399f6ec93 | offer completed | 420 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 99512d6652584d91bbe36be81a88edd4 | offer completed | 420 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| 99589ef8a7824f78adef69de2275c8fa | offer completed | 462 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| 998ea4ad4888418ea48370ff40ac713b | offer completed | 582 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 9a5c134ced1742ec9307fc3b9e0e5325 | offer completed | 576 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 9a76495a02e9445db40943cc3f1d62d2 | offer completed | 408 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| 9b2ec72a4ee04bb1bbf360642f22e7d3 | offer completed | 630 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| 9cd56cfd1feb4dc7851e8e5132ab45c2 | offer completed | 666 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| 9cff812d0f8f426a8189648d3c476411 | offer completed | 522 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| 9f02eeb4d5d2474c96b1e3b0253a0df9 | offer completed | 408 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| 9f0578a74c7b46249401d04deee59203 | offer completed | 618 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| a006a78a45ae4bc8bd4e6ce4d60db0c1 | offer completed | 630 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| a0aa2dbb521e4389b34d0c29a2a77286 | offer completed | 390 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| a1110e0aaa5a4255bfa8253cab228446 | offer completed | 576 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| a3aab03d52bc4927a6c4eb9c1f9820d8 | offer completed | 438 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| a425b937d8f245048313d81bee4e1745 | offer completed | 612 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| a425f5b5cfc14898b65f9f2256c1be82 | offer completed | 546 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| a4c2dd694269444085976f10b9b225f6 | offer completed | 444 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| a509b9395b23477385120b259ffe9e6b | offer completed | 468 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| a50f496253874130a441e7292a63a4a5 | offer completed | 216 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| a5eb8d8f9d90410fa3971ba125926072 | offer completed | 564 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| a768ea97df544316afa7184273e13152 | offer completed | 612 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| a7dc060f6fc94ca7bf71fbb188187dca | offer completed | 168 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| a8735bc18be847ce9bdf3a1ff1f8699f | offer completed | 408 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| a96c28c4640949ddb38db4c7498f337f | offer completed | 624 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| a9bd819d62554b2896a0528040305ed3 | offer completed | 666 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| aaaf123c93804a418da5c4edceb4d40c | offer completed | 504 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| ab9b519a8d0f419fbba7915f086bc2dd | offer completed | 432 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| ad783557583642c690fe505163e1c8dd | offer completed | 516 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| adca596a441a4d68b76a57d19f4041ab | offer completed | 600 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| aeb2465e958342f39d18e44d6ba36311 | offer completed | 504 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| aeed18479ee64200b76fb40f5b8e0e14 | offer completed | 492 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| af5551545cec404bb32a91ebaa731790 | offer completed | 516 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| b02abf5ae76a468c9d0c20d3f85fc7d4 | offer completed | 594 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| b063b99c5a96415f9837a54ba030d735 | offer completed | 528 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| b1f46c32073f44fea1483fe394856408 | offer completed | 588 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| b25c8057261c43389f7ecb7df164b034 | offer completed | 456 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| b27c2e80e2324209baadb24a4b1a2238 | offer completed | 420 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| b420d078191046d889916e7688181122 | offer completed | 582 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| b4e842928968481f988f869561cc0257 | offer completed | 600 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| b62a7b6effca47d29859ba016fd4efa0 | offer completed | 480 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| b669b308d4fa4bff837d68d86a78e6b1 | offer completed | 510 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| b68bc936296144569115d7cbe8077f51 | offer completed | 630 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| b6d51d4c675149cda7524218e8e82364 | offer completed | 414 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| b6d81a7cd7154f7d8155b3351fb514cd | offer completed | 432 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| b6d94c567b25454a9262c4f5c3ac996c | offer completed | 612 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| b7509d7b888e4ab197ea253b57f7988c | offer completed | 450 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| b7d9416dbfd84e50afd2114c3bafbc00 | offer completed | 546 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| b7e216b6472b46648272c29a52a86702 | offer completed | 714 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| b8a1911efeae48e58762b98395014a8c | offer completed | 456 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| ba12d53863b3456f930ac62e2503fe48 | offer completed | 504 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| ba1d6debf43549ec85647318dda2656d | offer completed | 474 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| baa224e7738d490abb3e523842a95e14 | offer completed | 570 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| bba62984c3d347908b94f740ac02f623 | offer completed | 504 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| bbb2955fd6f14f00a5df7b5140e0c2a0 | offer completed | 612 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| bbb98c130cf441f6a1e360436565b697 | offer completed | 570 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| bd06525874e148689e502cda5623b25e | offer completed | 462 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| be15020b871e45ab8e2e1b9e6a8cec75 | offer completed | 432 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| bf9a977afac347909f6154675a0e2bc2 | offer completed | 606 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| bfb63a0b5e364734ae7dd2d8db85ca8f | offer completed | 582 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| c05efe90da0d4d2f9ea66f178e0534e9 | offer completed | 642 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| c1f75b94d45d42b189765a2533b526dd | offer completed | 522 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| c263186570294437b1b4d0f3820d03db | offer completed | 552 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| c28c139d78c94303a0a993e3731e789f | offer completed | 462 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| c629b5f79c85480bbb7623536c2fca19 | offer completed | 528 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| c74beaa959a742309ba8350b7d472676 | offer completed | 606 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| c7a18c63b4b34941a338c0c76eeb1e87 | offer completed | 456 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| c87e01779b904ec1b4b98008243e00da | offer completed | 528 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| c9eed1f79316414183383096b7a95347 | offer completed | 648 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| cb38fe23b6934f1d84b917534203064a | offer completed | 432 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| cc5eda544a34426db4b327faf64defa5 | offer completed | 438 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| cccc28cea9bf4b1f94bd032402c66438 | offer completed | 570 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| cd8a88670e404eef9d4edc3010dd84aa | offer completed | 240 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| ce260290045a4de39c6e734dbc8f0e75 | offer completed | 438 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| ce7806932b1c4d2985a485a9e4b576c0 | offer completed | 420 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| d0a80415b84c4df4908b8403b19765e3 | offer completed | 456 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| d10238bffa114193b35f0e4291aef010 | offer completed | 588 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| d167940f7af04f4681daaa6d1bfd80a1 | offer completed | 534 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| d19849e046cc441fb7cfc4c8a68dbf6d | offer completed | 600 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| d3209835a40a423fbf2c967218d00bcd | offer completed | 612 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| d3c252891c324c628ce1383487e12492 | offer completed | 576 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| d674b3444fa74d15a61baa3c882f4c20 | offer completed | 486 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| d7a4c9a5d4394065af1af3f924877d5c | offer completed | 402 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| daca8dbd28a4469d9b6969e883b308c8 | offer completed | 432 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| de2c8f8a52584691b7937ca563131255 | offer completed | 516 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| de9bf8c8b3c94a658c1b91f61b27cb5b | offer completed | 600 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| dfd0000b37b94c599d7d41c79defbec0 | offer completed | 468 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| dffb8f8da9ef4f5db279e52bb43835af | offer completed | 504 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| dffc27c50ea740c1a15d9b211c5a2bed | offer completed | 648 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| e08771acbe694bccb9482ba7d77c1fc7 | offer completed | 564 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| e1711365801040bd9300b970b19efa32 | offer completed | 426 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| e199fdec031441fb9f1295eb7952be69 | offer completed | 624 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| e22206bf65234c0e9f273bef859c02a1 | offer completed | 414 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| e23d0189d573404e864a10ecd2817520 | offer completed | 594 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| e2966f15389e4e0e9a5891bd675a5f11 | offer completed | 588 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| e2bf690856ee49bab84b794581636d0d | offer completed | 510 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| e2f8376c32084327b1991706b124c8ed | offer completed | 582 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| e39bab091d504157abe1b4a484cc5c52 | offer completed | 456 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| e3aef8dbe2ff4db5957627ddd2922d50 | offer completed | 642 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| e556caf9d9f4490893bf8b500b715275 | offer completed | 510 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| e5c59811346840e2ab81bd05303c3ebc | offer completed | 618 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| e66ffc0a34b34ffbab2f3509129ed774 | offer completed | 636 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| e789213c809347128dd9fe36a0db7f1a | offer completed | 498 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| e83b1d8a75f840f482ff0834981b99ce | offer completed | 576 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| e9844d5beac04bf8b8d3ad18f7e37fca | offer completed | 528 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| e999c4985c4347cdae42c5097959093f | offer completed | 564 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| e9fb6ed2cecb4980ba98c86abc9c91e3 | offer completed | 168 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| ea31b3310cbd45b991d473514fcb7e84 | offer completed | 546 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| ea80e80e157a410d8fdfc6221f4a785a | offer completed | 522 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| eb8c6c64e7ca49168f5ba2c13cffccd8 | offer completed | 576 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| ebb683a739d443e39f8b913b82163d02 | offer completed | 504 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| ec1761735b034ae8874bc979f0cd5862 | offer completed | 474 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| ec5220b1f125408fa76426bb33f54b7e | offer completed | 588 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| ec93fe749a8e42628138f96bb29d1ac5 | offer completed | 594 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| ed652dee45c042cc99eb591f2f210b65 | offer completed | 606 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| ede78d4917c64e09a30eec8fcf479d55 | offer completed | 504 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| ee97fbfe90d74ca4b9c94bbbb445473b | offer completed | 630 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| ef3151875cd7450c85e9effa680b70c4 | offer completed | 426 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| f030124b48cf4960b569da21d8aedb5b | offer completed | 462 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| f20859f19f1b4a3987af0b94db1c4cab | offer completed | 414 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| f24749a71a91425ba6bf41ba3f087a70 | offer completed | 438 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| f251232f004d405ca44b35515bb9c444 | offer completed | 546 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| f27e921ee8254022a84afa2c98fd0abd | offer completed | 576 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| f28b37ab06934bd28169ef920ad5190c | offer completed | 612 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| f2e49f5002c540eb92ca320fea990319 | offer completed | 612 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| f39fe7ea4e5946378e6d224504b77797 | offer completed | 684 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| f3e801caeafe4899b3b989b586e74ac7 | offer completed | 714 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| f3fc3610d0494dfabc8bf0eb9a15afe5 | offer completed | 516 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| f3fce93462d449049a4b8615af3f5355 | offer completed | 606 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| f4e0715b897c480e9cb7b72cec1a8607 | offer completed | 474 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| f4ef9a434c22420b8d7528602f777375 | offer completed | 402 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| f57fcd93d3e74e9b9bb9bc81a40a6612 | offer completed | 468 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| f5b1bf31e4484153a8d6ffbb312da4b7 | offer completed | 210 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| f5b4179544084392b364f21da3f7aa0e | offer completed | 468 | {'offer_id': '2906b810c7d4411798c6938adc9daaa5', 'reward': 2} | 2 |
| f707d8ac81e84b6a82d6ef640ca4a22c | offer completed | 636 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| f709aca8c4e54792b438caddff279fe5 | offer completed | 606 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| f92d8e8c8055406ea37c07b77ce505db | offer completed | 414 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| f92fd305868d4c06a64c0eaa38a4b498 | offer completed | 576 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| fae3fbe975cc4421b853947d7448904e | offer completed | 528 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| fb31984c46b1429aaae7c5ed877e5f98 | offer completed | 540 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| fb89e4ae9fbc4a3d8f701556290ac87c | offer completed | 558 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |
| fcaccfeda18b4ac08d5a25b64b4368f2 | offer completed | 534 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| fd3e1ba4df4b4db0af9cf727eb1651ac | offer completed | 594 | {'offer_id': '4d5c57ea9a6940dd891ad53e9dbe8da0', 'reward': 10} | 2 |
| fdaf338377c145bfb8bebf62ca2304d3 | offer completed | 648 | {'offer_id': '2298d6c36e964ae4a3e7e9706d1fb8c2', 'reward': 3} | 2 |
| fe165534ac61475f90835daf595a0899 | offer completed | 516 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| fea0d1e7c8374feca24c7672e0b60d13 | offer completed | 450 | {'offer_id': 'f19421c1d4aa40978ebb69ca19b0e20d', 'reward': 5} | 2 |
| feb31e39c1e3407b9fdc7e79db9274b7 | offer completed | 594 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| ff4bfebc3c92451aa546c7e100be0de4 | offer completed | 504 | {'offer_id': '9b98b8c7a33c4b65b9aebfe6a799e6d9', 'reward': 5} | 2 |
| ff6a080134fc44dc9c7e7b5abcfbe849 | offer completed | 600 | {'offer_id': 'ae264e3637204a6fb9bb56bc8210ddfd', 'reward': 10} | 2 |
| ff80a43ecb34439491bd9ae1cff7c5fc | offer completed | 528 | {'offer_id': 'fafdcd668e3743c1bb461111dcafc2a4', 'reward': 2} | 2 |
| ff95e0a9cdfd4030958762dadcb11e1a | offer completed | 372 | {'offer_id': '0b1e1539f2cc45b7b9fa7c272da2e1d7', 'reward': 5} | 2 |

### 2-4. 특이사항

1. profile.age=118인 레코드 2175건이 gender 결측 2175건, income 결측 2175건과 정확히 일치함 (동일 행 집합) — age=118은 실제 나이가 아니라 결측을 나타내는 센티널 값으로 추정됨.
2. transcript.value 딕셔너리의 키 표기가 이벤트 유형마다 다르며, 특히 offer 관련 키 표기가 'offer received'/'offer viewed' 이벤트에서는 공백 포함 'offer id', 'offer completed' 이벤트에서는 언더스코어 포함 'offer_id'로 서로 다르게 기록됨 — 동일 개념(오퍼 식별자)에 대한 표기 불일치.
3. transcript에서 자연키(person, event, time, value) 기준 완전 중복 397건이 확인되며, 모두 event='offer completed'에서만 발생함 — 동일 오퍼 완료 이벤트가 이중(또는 3중, 1건)으로 기록된 것으로 추정.
4. transcript.person(17000개 고유값)과 profile.id(17000개 고유값) 간 불일치 0건, transcript.value 내 offer id/offer_id 값과 portfolio.id(10개) 간 불일치 0건으로 확인됨 — 3개 파일 간 외래키 참조 무결성은 정상.
5. profile.became_member_on은 정수형(int64)이나 실제로는 YYYYMMDD 형식의 날짜 값이며, 크기 비교 기반 이상치 탐지가 무의미하여 이상치 분석에서 제외함(OUTLIER_EXCLUDE_COLUMNS 적용).

### 종료: 여기까지 작성 후 정지 → 사용자의 처리 방향 의견 대기

## 3. 처리 결정과 근거


## 4. 처리 후 검증


## 5. 기초통계


## 6. 후속 권고

