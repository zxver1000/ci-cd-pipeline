# ci-cd-pipeline

Study CI/CD Pipeline

- 이 Repository를 이용하여 CI/CD를 수행하는 Pipeline을 작성해 주세요.
- 필요한 AWS 인프라는 terraform을 이용해 구성합니다.
- monorepo 전략을 이용합니다.
- 아래의 내용은 모두 본 Repository를 Fork한 후 수행합니다.
- 작업을 모두 완료했다면, 본 Repository에 `닉네임/ci-cd-pipeline` repo로 Pull Request를 날립니다.

## CI/CD Pipeline

- Git Actions를 이용해 Continuous Integration을 수행하고 AWS ECR에 Continuous Delivery를 수행합니다.
  - 이 때, Go source는 binary로 빌드하여 Container Image를 만듭니다.
- AWS ECR에 이미지가 갱신되면 AWS Lambda로 Deploy를 수행합니다.

## AWS Infrastructure

- 사용하는 서비스는 모두 terraform을 이용해 구축합니다.
  - 필수
    - AWS ECR
    - AWS Lambda
