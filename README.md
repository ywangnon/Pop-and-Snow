# Pop and Snow Animation with CAEmitterLayer

> Swift에서 `CAEmitterLayer`를 이용한 파티클 애니메이션 예제

![Pop and Snow Animation](https://user-images.githubusercontent.com/35207196/180250922-71470baf-4f69-4dd8-8cff-7d72858c52ea.gif)

---

## 설명

### CAEmitterLayer란?
`CAEmitterLayer`는 파티클(입자) 효과를 만들어내고 애니메이션화 시켜주는 레이어입니다.

- 파티클 방출
- 움직임 설정
- 렌더링 처리

> 주로 이런 이펙트에 사용됩니다:
- 눈/비 내리기
- 폭죽
- 거품
- 불꽃
- 돈 떨어뜨리기 등

---

## 주요 구현 효과

|효과|설명|
|----|----|
|Pop (터짐)|터치한 위치에서 이모지가 퍼짐|
|Snow (눈)|상단에서 돈 이모지가 천천히 떨어짐|
|Bubble (거품)|아래서 위로 거품 올라감|

---

## 개인 회고 🤔

거품 효과를 조금 더 자연스럽게 표현하고 싶었지만, CAEmitterLayer만으로는 한계가 있었습니다.

특히 좌우로 흔들리거나 점점 흐려지는 애니메이션은 CAEmitterLayer가 기본적으로 지원하지 않는 것 같습니다.
CAEmitterCell은 위치(position), 속도(velocity), 크기(scale), 회전(spin) 등의 속성은 제어할 수 있지만, 복잡한 커스텀 애니메이션은 별도의 처리나 다른 방식의 애니메이션 적용이 필요할 것으로 보입니다.

---

## 참고 자료 📚

[카카오톡 송금 봉투 애니메이션 따라하기 - naljin 블로그](https://sujinnaljin.medium.com/swift-카카오톡-송금-봉투-애니메이션-따라하기-27a86bfa59dc)
