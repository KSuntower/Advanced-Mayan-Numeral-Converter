import 'constants.dart';

Function generatorFunction = generateNumberWordMZ;

String _vowelCompare(String chr) {
  String vowels = "uó";
  if (chr.isEmpty){
    return "";
  }
  for (var i = 0; i < vowels.length; i++) {
    if (vowels[i] == chr[0]) return "y";
  }
  return "";
}

// generate the word for the number in Yucatec Maya as written by P. Romero.
String generateNumberWordPR(List<int> parsedList) {
  if (parsedList.isEmpty) {
    return "";
  }
  int maxIndex = parsedList.length -1;
  int cutoffIndex = wordNumbers.length;
  int numberModifier = 10;
  int activeNumber = 0;

  String generatedWord = "";
  String activeWord = "";

  int index = 0;

  List<String> prefixList = List.generate(parsedList.length, (_) => "");
  List<int> preparedList = List.from(parsedList);

  int prefixIndex = 0;

  // prepared the list
  for (var i = maxIndex; i >= 0; i--) {
    if (parsedList[i] > 0) {
      prefixList[i] = prefixWords[prefixIndex];
    }
    prefixIndex++;
  }

  activeNumber = preparedList[maxIndex];

  if (activeNumber < cutoffIndex){
    activeWord = wordNumbers[activeNumber];
  }
  else {
    activeWord = wordNumbers[activeNumber - numberModifier] + wordNumbers[10];
  }
  generatedWord = activeWord;

  //generatedWord += prefixWords[index++];
  if (activeNumber > 0) {
    generatedWord += prefixWords[index];
  }
  index++;
  generatedWord += parsedList.length > 1 && activeNumber > 0 ? " $couplerWord " : "";

  for (var i = 1; i < parsedList.length; i++) {
    activeNumber = preparedList[maxIndex -i];
    if (activeNumber < cutoffIndex){
      activeWord = wordNumbers[activeNumber];
    }
    else {
      activeWord = wordNumbers[activeNumber - numberModifier] + wordNumbers[10];
    }
    generatedWord += _vowelCompare(activeWord) + activeWord;
    generatedWord += prefixList[maxIndex -i];

    if (i + 1 < parsedList.length && preparedList[i] > 0) {
      generatedWord += " $couplerWord ";
    }
    index++;
  }
  return generatedWord;
}

// generate the word for the number in Yucatec Maya as written by M. Zavala.
String generateNumberWordMZ(List<int> parsedList) {
  if (parsedList.isEmpty) {
    return "";
  }
  int maxIndex = parsedList.length -1;
  int cutoffIndex = wordNumbers.length;
  int numberModifier = 10;
  int activeNumber = 0;

  String generatedWord = "";
  String activeWord = "";

  int index = 0;

  List<String> prefixList = List.generate(parsedList.length, (_) => "");
  List<int> preparedList = List.from(parsedList);

  int prefixIndex = 0;

  // prepared the list
  for (var i = maxIndex; i >= 0; i--) {
    if (parsedList[i] + 1 > 19 && i != maxIndex) {
      prefixList[i] = prefixWords[prefixIndex + 1];
      preparedList[i] = 1;
    }
    else if (i < maxIndex && parsedList[i + 1] == 0) {
      if (parsedList[i] > 0){
        prefixList[i] = prefixWords[prefixIndex];
      }
    }
    else if (i < maxIndex) {
      preparedList[i] += 1;
      prefixList[i] = prefixWords[prefixIndex];
    }
    prefixIndex++;
  }

  activeNumber = preparedList[maxIndex];

  if (activeNumber < cutoffIndex){
    activeWord = wordNumbers[activeNumber];
  }
  else {
    activeWord = wordNumbers[activeNumber - numberModifier] + wordNumbers[10];
  }
  generatedWord = activeWord;

  //generatedWord += prefixWords[index++];
  if (activeNumber > 0) {
    generatedWord += prefixWords[index];
  }
  index++;
  generatedWord += parsedList.length > 1 && activeNumber > 0 ? " $couplerWord " : "";

  for (var i = 1; i < parsedList.length; i++) {
    activeNumber = preparedList[maxIndex -i];
    if (activeNumber < cutoffIndex){
      activeWord = wordNumbers[activeNumber];
    }
    else {
      activeWord = wordNumbers[activeNumber - numberModifier] + wordNumbers[10];
    }
    generatedWord += _vowelCompare(activeWord) + activeWord;
    generatedWord += prefixList[maxIndex -i];

    if (i + 1 < parsedList.length && preparedList[i] > 0) {
      generatedWord += " $couplerWord ";
    }
    index++;
  }
  return generatedWord;
}

List<int> calculateNumberList(int number){
  int workingNumber = number;
  List<int> parsedNumbers = List.generate(4, (i) => 0);
  int maxIndex = divisionNumbers.length -1;

  parsedNumbers[0] = ((number/divisionNumbers[maxIndex]).floor());
  workingNumber -= (divisionNumbers[maxIndex] * parsedNumbers[0]);

  for(var i = 1; i < divisionNumbers.length; i++) {
    var newValue = (workingNumber/divisionNumbers[maxIndex -i]).floor();
    parsedNumbers[i] = (newValue);
    workingNumber -= (divisionNumbers[maxIndex -i] * parsedNumbers[i]);
  }
  for (var i = 0; i < parsedNumbers.length;){
    if (parsedNumbers[i] != 0){
      break;
    }
    parsedNumbers.removeAt(i);
  }
  return parsedNumbers;
}

int fromGlyphToNumber(List<int> list) {
  int num = 0;
  if (list.isEmpty) {
    return 0;
  }
  for (var i = 0; i < list.length; i++) {
    num += list[i] * divisionNumbers[i];
  }
  return num;
}
