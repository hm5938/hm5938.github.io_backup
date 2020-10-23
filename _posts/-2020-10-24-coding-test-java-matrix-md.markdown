---
layout: post
title:  "[CodingTest] 행렬의 영역"
subtitle: "java"
categories: test
tags: coding-test java matrix  
comments: false
---

## 개요
> `행렬`의 영역  
  
- 목차
	- [문제](#문제) 
	- [예시](#test-case)
	- [답안](#답안)
	
 
## 문제
---
모든 원소가 0 또는 1 인 행렬이 있습니다. 1 로 표시된 원소는 영역을 나타냅니다. 여기에서 상하좌우에 인접한 1
은 같은 영역이라고 가정합니다. 각 영역의 크기는 1 의 개수로 정의합니다. 주어진 N x N 크기의 행렬에서 영역의
개수와 각 영역의 크기를 오름차순으로 출력하세요.

[입력]
    • 첫 번째 행은 행렬의 크기인 N입니다. N 은 1 이상 10 이하의 자연수입니다.
    • 입력 두 번째 행부터는 공백으로 구분된 0 과 1 로 행렬이 주어집니다. 각 행은 개행 문자(newline, \n)로
    구분됩니다.
[출력]
    • 첫 번째 행은 영역의 개수를 출력합니다.
    • 두 번째 행은 각 영역의 크기를 공백으로 구분하여 오름차순으로 출력합니다.
    • 한 행의 끝은 불필요한 공백 없이 개행 문자(newline, \n)로 끝나야 합니다.
    • 영역이 존재하지 않을 경우 영역 수 0으로 1 행으로만 출력합니다.

[행렬 및 영역 예시]
> 영역은 3개이며, 각 영역의 크기는 4, 5, 7입니다.
> 아래 테스트 케이스에서 예제로 2 개를 오픈하므로 별도로 예를 들 필요가 없습니다.

## Test Case

__입력 1__
```
6
0 1 1 0 0 0
0 1 1 0 1 1
0 0 0 0 1 1
0 0 0 0 1 1
1 1 0 0 1 0
1 1 1 0 0 0
```
__출력 1__
```
3
4 5 7
```

__입력 2__
```4
0 0 0 0
0 0 0 0
0 0 0 0
0 0 0 0
```
__출력 2__
```
0
```

__입력 3__
```
4
1 0 0 0
1 0 0 0
0 0 0 0
0 0 1 1
```
__출력 3__
```
2
2 2
```

## 답안
---
```java
{% raw %}
import java.util.Arrays;
import java.util.Scanner;

class Main {
	
  private static void solution(int sizeOfMatrix, int[][] matrix) {
    // TODO: 이곳에 코드를 작성하세요.
		
	  int list[]= new int[50];
	  int max=(int)Math.ceil(sizeOfMatrix/2);
	  int num=-1;
	  int result=0;


	  for(int y=0;y<sizeOfMatrix; y++) {
			for(int x=0;x<sizeOfMatrix; x++) {
				if(matrix[y][x]==1) {
					//행렬의 오른쪽과 위에있는 숫자가 이미 그 넓이를 저장한 문자라면, 그 넓이에 추가시킴
					if(y!=0&&matrix[y-1][x]!=0&&matrix[y-1][x]!=1) {
						
						//하지만 만약 오른쪽과 위의 숫자가 서로 다른 넓이로 측정되어있다면 
						//두개의 영역을 하나로 합친후 넓이 추가
						if(x!=0&&matrix[y][x-1]!=0&matrix[y][x-1]!=1) {
						
							if(matrix[y-1][x]==matrix[y][x-1]){
							}
							else{
								list[Math.abs(matrix[y-1][x])]+=list[Math.abs(matrix[y][x-1])];
								list[Math.abs(matrix[y][x-1])]=0;
								for(int a=0;a<sizeOfMatrix; a++) {
									for(int b=0;b<sizeOfMatrix; b++) {
										if(matrix[a][b]==matrix[y][x-1]) {
											matrix[a][b]=matrix[y-1][x];
										}
									}}
							}
					}
						
						matrix[y][x]=matrix[y-1][x];
						list[Math.abs(matrix[y-1][x])]+=1;
					}
					else if(x!=0&&matrix[y][x-1]!=0&matrix[y][x-1]!=1) {
						matrix[y][x]=matrix[y][x-1];
						list[Math.abs(matrix[y][x-1])]+=1;
					}
					else
					{
						//오른쪽과 위의 숫자가 넓이로 측정되지않았다면,
						//새로운 영역을 만들어 넓이를 추가시킴
						num--;
						matrix[y][x]=num;
						list[Math.abs(num)]+=1;
					}
					
					
				}
				
			}
			}
			//배영을 오름차순으로 정렬
		Arrays.sort(list);
		
		//배열에 넓이를 계산한 영역이 몇개인지 센 후, 
		//그 개수만큼 영역의 넓이를 출력
		for(int a:list){
			if(a!=0){
				result++;
			}
		}
		System.out.println(result);
		for(int a=list.length-result;a<list.length;a++){
			System.out.print(list[a]+" ");
		}
		
  }
  
  private static class InputData {
    int sizeOfMatrix;
    int[][] matrix;
  }

  private static InputData processStdin() {
    InputData inputData = new InputData();

    try (Scanner scanner = new Scanner(System.in)) {
      inputData.sizeOfMatrix = Integer.parseInt(scanner.nextLine().replaceAll("\\s+", ""));      
      
      inputData.matrix = new int[inputData.sizeOfMatrix][inputData.sizeOfMatrix];
      for (int i = 0; i < inputData.sizeOfMatrix; i++) {
        String[] buf = scanner.nextLine().trim().replaceAll("\\s+", " ").split(" ");
        for (int j = 0; j < inputData.sizeOfMatrix; j++) {
          inputData.matrix[i][j] = Integer.parseInt(buf[j]);
        }
      }
    } catch (Exception e) {
      throw e;
    }

    return inputData;
  }

  public static void main(String[] args) throws Exception {
    InputData inputData = processStdin();

    solution(inputData.sizeOfMatrix, inputData.matrix);
  }
}
{% endraw %}
```
 