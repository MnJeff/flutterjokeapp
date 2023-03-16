void main() {
  List<int> arr = [1, 3, 5, 7, 9];
  int sum = 0;
  int min = arr[0];
  int max = arr[0];
  
  for (int i = 0; i < arr.length; i++) {
    sum += arr[i];
    if (arr[i] < min) {
      min = arr[i];
    }
    if (arr[i] > max) {
      max = arr[i];
    }
  }
  
  int minSum = sum - max;
  int maxSum = sum - min;
  
  print('$minSum $maxSum');
}
