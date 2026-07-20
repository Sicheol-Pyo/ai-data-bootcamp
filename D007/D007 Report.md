# 모두마켓 월간 로그 — 도구 선택 보고서

## 1. 데이터 개요
- 파일: web_logs.csv
- 크기: 32.7 MB, 499_999 행
- 주요 컬럼: log_id / ts / user_id / session_id / page / device / status_code / response_ms / bytes_sent

## 2. 측정 결과
| 방식 | 소요 시간 | 메모리 피크 |
| pandas + dtype | 0.89초 | 14.6MB |
| pandas chunked | 1.19초 | 0.7MB |
| Polars lazy    | 0.20초 | 150.1MB |

## 3. 분석 결과 요약
- 페이지별 평균 응답 시간 최고: searh (160.42ms)
- 디바이스 점유율: mobile 69.9%, desktop 25.1%, tablet 4.9%
- 에러 1위 페이지: home (42_898건)

## 4. 도구 선택 정당화 (한 단락)
이 분석에는 pandas + dtype 을 선택했습니다. 이유는 
(1) 측정 결과 pandas + dtype의 소요 시간이 0.89로 polas lazy(0.20초) 보다는 늦고 pandas chunked(1.19초) 보다는 빠르지만
메모리 피크가 14.6MB로 polars lazy(150.1MB) 보다 더 좋은 지표가 확인되었습니다.
(2) 팀 환경상 Polars보다 pandas에 익숙한 팀원이 많아 유지보수와 협업이 용이합니다.
(3) Polars lazy는 속도(0.20초)는 가장 빠르지만 메모리 증가량(150.1MB)이 
    지나치게 커서, 현재 데이터 규모(50만 행)에는 오히려 비효율적이기 때문입니다.

## 5. 다음 단계 제안
- 데이터 크기가 1천만행이상 까지 늘어나면 polas(eager) 로 전환을 고려.
- 시각화·검증은 D+008에서 matplotlib/seaborn(또는 Polars 결과를 
  pandas로 변환 후 시각화) 을 활용해 진행.1