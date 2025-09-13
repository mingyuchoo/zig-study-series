# Zig Hello World (basic/hello-world)

간단한 Zig "Hello, World" 예제 프로젝트입니다. `build.zig` 빌드 스크립트와 `src/main.zig` 실행/테스트 코드를 포함합니다.

## 요구 사항

- Zig 컴파일러 (권장: 최신 안정 버전, 0.12+)
- Windows PowerShell, macOS Terminal, 또는 Linux Shell

Zig 설치: <https://ziglang.org/download/>

설치 확인:

```powershell
zig version
```

## 프로젝트 구조

```
basic/hello-world/
├─ build.zig            # 빌드 스크립트 (실행, 설치, 테스트 스텝 정의)
├─ src/
│  └─ main.zig          # "Hello, World" 메인 함수 및 간단한 테스트
├─ .zig-cache/          # (자동 생성) 빌드 캐시
└─ zig-out/             # (자동 생성) 빌드 산출물(설치 위치)
```

- 실행 엔트리포인트: `src/main.zig`
- 바이너리 이름: `hello-world` (build.zig의 `.name` 설정)

## 사용 방법

### 빌드

```powershell
zig build
```

### 실행

다음 중 하나를 사용하세요.

- 빌드 스텝의 run 사용:

  ```powershell
  zig build run
  ```

- 설치된 바이너리를 직접 실행 (플랫폼에 따라 경로 상이):

  ```powershell
  .\zig-out\bin\hello-world.exe
  ```

### 실행 인자 전달

`build.zig`는 인자 전달을 지원합니다.

```powershell
zig build run -- arg1 arg2
```

### 최적화 모드

다음과 같이 빌드시 최적화 레벨을 선택할 수 있습니다.

```powershell
zig build -Drelease-fast=true     # 빠른 실행 최적화
zig build -Drelease-safe=true     # 안전성 강화 최적화
zig build -Drelease-small=true    # 바이너리 크기 축소
```

(기본값은 Debug)

### 테스트

`src/main.zig`에 간단한 테스트가 포함되어 있습니다.

```powershell
zig build test
```

또는 단일 파일 테스트 실행:

```powershell
zig test src/main.zig
```

## 코드 개요

- `src/main.zig`

  ```zig
  pub fn main() !void {
      std.debug.print("Hello, {s}!\n", .{"World"});
  }

  test "always succeeds" {
      try expect(true);
  }
  ```

- `build.zig`
  - 실행 파일 추가: `b.addExecutable` (이름: `hello-world`, 진입점: `src/main.zig`)
  - `zig build run` 스텝 제공 및 인자 전달 지원 (`zig build run -- ...`)
  - `zig build test` 스텝 제공 (유닛 테스트 실행)

## 캐시/산출물 정리

빌드 캐시 및 산출물을 지우려면(선택):

```powershell
Remove-Item -Recurse -Force .zig-cache, zig-out
```

주의: 해당 폴더가 존재할 때만 실행하세요.

## 문제 해결

- "zig: command not found" 또는 "'zig'은(는) 인식되지 않습니다":
  - Zig 설치 후 PATH에 추가했는지 확인하세요.
- 권한/실행 문제:
  - PowerShell에서 스크립트 실행 정책 또는 파일 권한을 확인하세요.
- 빌드 실패 시:
  - `zig version`으로 버전을 확인하고 최신 안정 버전을 사용해 보세요.

## 라이선스

해당 리포지토리의 상위 정책을 따릅니다. 별도의 라이선스 파일이 있다면 이를 참조하세요.
