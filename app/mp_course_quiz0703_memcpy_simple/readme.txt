* 문제: 메모리 복사하는 함수를 구현하십시오.

* 참고 사항
    + 자세한 함수 정의는 파일, memcpy_simple.h에 있습니다.
    + 함수 구현은 파일, memcpy_simple.S에 하면 됩니다.
    + Conditional branch, load, store instruction을 사용해서 구현하면 됩니다.
      (이 문제에서는 수행 속도를 고려하지 않아도 됩니다. 따라서 ldrb, strb 를 사용해 구현하면 됩니다.)
    + 인수, destination, source, size는 각각 r0, r1, r2에 저장되어 전달됩니다.
      (이 작업은 함수 호출자(caller)가 수행합니다. 함수 내부에서는 저장된 값을 그냥 쓰면 됩니다.)
    + Return value는 r0에 저장해 전달합니다.
      (이 작업은 함수(callee)가 수행합니다. 따라서 함수 내부에서 구현해 주어야 합니다.)
