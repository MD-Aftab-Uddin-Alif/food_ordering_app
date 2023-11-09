dynamic translateToBanglaDigit(dynamic number) {
  String result = '';
  String num = number.toString();
  for (int i = 0; i < num.length; i++) {
    if (num[i] == '0') {
      result += '০';
    } else if (num[i] == '1') {
      result += '১';
    } else if (num[i] == '2') {
      result += '২';
    } else if (num[i] == '3') {
      result += '৩';
    } else if (num[i] == '4') {
      result += '৪';
    } else if (num[i] == '5') {
      result += '৫';
    } else if (num[i] == '6') {
      result += '৬';
    } else if (num[i] == '7') {
      result += '৭';
    } else if (num[i] == '8') {
      result += '৮';
    } else if (num[i] == '9') {
      result += '৯';
    } else if (num[i] == '.') {
      result += '.';
    } else {
      result += num[i];
    }
  }
  return result;
}
