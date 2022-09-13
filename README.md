- 👋 Hi, I’m @tjddncjs0909
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...

<!---
tjddncjs0909/tjddncjs0909 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->

#include<stdio.h>
#include<string.h>
#include<stdlib.h>


// qsort 정렬함수
int compare(const void *a, const void *b){
  int n1 = *(int*)a;
  int n2 = *(int*)b;
  if(n1>n2){
    return 1;
  }
  else if(n1<n2){
    return -1;
  }
  else{
    return 0;
  }
}

//최대공약수 반환 함수
int gcd(int a, int b){
  if(a % b == 0){
    return b;
  }
  else{
    return gcd(b, a % b);
  }
}
int main(void){
  int n;
  return 0;
}
