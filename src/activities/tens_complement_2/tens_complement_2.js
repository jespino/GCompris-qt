/* GCompris - tens_complement_2.js
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0;
var numberOfLevel;
var items;
var displayArray = [
    ["(",null, "+", null, ")", "+","(", null, "+", null, ")", "=", null],
    ["(",null, "+", null, ")", "+","(", null, "+", null, ")", "+", null, "=", null],
    ["(",null, "+", null, ")", "+","(", null, "+", null, ")", "+", "(", null, "+", null, ")", "=", null]
];
var numberArray;
var valueArray;
var answerArray = [];
var datasets;
var correctAnswerImage = "qrc:/gcompris/src/core/resource/apply.svg"
var wrongAnswerImage = "qrc:/gcompris/src/core/resource/cancel.svg"
var currentDatasetLevel = 0;
var numberOfDatasetLevel;

function start(items_) {
    items = items_
    currentLevel = 0
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1;
    var numberCardCounter = 1;
    numberOfDatasetLevel = items.levels.length;
    numberOfLevel = items.levels[currentDatasetLevel].value.length * numberOfDatasetLevel;
    datasets = items.levels[currentDatasetLevel].value[currentLevel];
    items.validationImage1 = null;
    items.validationImage2 = null;
    items.validationImage3 = null;
    items.firstCardListModel.clear();
    items.secondCardListModel.clear();
    items.thirdCardListModel.clear();
    numberArray = [];
    answerArray.length = 0;
    valueArray = displayArray[currentLevel];
    items.numberOfCards = valueArray.length;
    var countForNumbersInDataset = 0;
    for(var i = 0; i < valueArray.length - 1; i++) {
        if(valueArray[i] == null) {
            valueArray[i] = datasets[0].numberValue[countForNumbersInDataset];
            countForNumbersInDataset++;
        }
    }
    valueArray[valueArray.length - 1] = datasets[0].totalSum;
    for(var i = 0;i < valueArray.length; i++) {
        var isNumber = true;
        if(valueArray[i] == "+" || valueArray[i] == "(" || valueArray[i] == ")" || valueArray[i] == "=") {
            isNumber = false;
        }
        var numberCard = {
            "type": "numberCard", // if the card is numberCard the value is 1 else 0.
            "bgColor": "#FFFB9A",
            "borderColor": "black",
            "value": valueArray[i].toString(),
            "rowNumber": 1,
            "columnNumber": i + 1,
            "selected": false,
            "numberCardPosition": numberCardCounter,
            "totalNumberCards": datasets[0].numberValue.length + 1
        }
        var symbolCard= {
            "type": "symbolCard",
            "bgColor": "#95F2F8",
            "borderColor": "#95F2F8",
            "value": valueArray[i].toString()
        }
        if(isNumber) {
            items.firstCardListModel.append(numberCard);
            items.secondCardListModel.append(numberCard);
            items.thirdCardListModel.append(numberCard);
            numberCardCounter++;
        }
        else {
            items.firstCardListModel.append(symbolCard);
            items.secondCardListModel.append(symbolCard);
            items.thirdCardListModel.append(symbolCard);
        }
    }

    modifyNumberValue(items.secondCardListModel);
    modifyNumberValue(items.thirdCardListModel);

    for(var i = 0; i < datasets.length; i++) { // storing all the values in an array of array (like a matrix) to check answers when okButton is pressed.
        var tempArray = [];
        for(var j = 0; j < datasets[i].numberValue.length; j++) {
            tempArray.push(datasets[i].numberValue[j]);
        }
        answerArray.push(tempArray);
    }
}

function modifyNumberValue(list) { // this function changes the numbers values in the listModel as per the dataset for second and third listModel.
    var datasetNumber;
    if(list == items.secondCardListModel) {
        datasetNumber = 1;
    }
    else {
        datasetNumber = 2;
    }
    var countOfNumbers = 0;
    for(var i = 0; i < valueArray.length; i++) {
        list.setProperty(i, "rowNumber", datasetNumber + 1);
        if(valueArray[i] >= '1' && valueArray[i] <= '9') {
            list.setProperty(i, "value", datasets[datasetNumber].numberValue[countOfNumbers].toString());
            countOfNumbers++;
        }
    }
    list.setProperty(valueArray.length-1, "value", datasets[datasetNumber].totalSum.toString());
}

function displayAnswerArray() {
    for(var i = 0; i < answerArray.length; i++) {
        for(var j = 0; j < answerArray[i].length; j++) {
            console.log(answerArray[i][j]);
        }
        console.log()
    }
}

function resize(row, col) {
    if(row - 1 == 0) {
        items.firstCardListModel.setProperty(col - 1, "selected", true);
    }
    else if(row - 1 == 1) {
        items.secondCardListModel.setProperty(col - 1, "selected", true);
    }
    else {
        items.thirdCardListModel.setProperty(col - 1, "selected", true);
    }
}

function resetSize() {
    for(var i = 0; i < valueArray.length; i++) {
        items.firstCardListModel.setProperty(i, "selected", false);
        items.secondCardListModel.setProperty(i, "selected", false);
        items.thirdCardListModel.setProperty(i, "selected", false);
    }
}

function updateAnswerArray(list, row, position1, position2, numberCardPosition1, numberCardPosition2) {
    answerArray[row-1][numberCardPosition1-1] = list.get(position1).value.toString();
    answerArray[row-1][numberCardPosition2-1] = list.get(position2).value.toString();
}

function swapNumberInsideList(list, position1, position2) {
    var firstClickedValue = list.get(position1).value.toString();
    var secondClickedValue = list.get(position2).value.toString();
    list.setProperty(position1, "value", secondClickedValue);
    list.setProperty(position2, "value", firstClickedValue);
}

function swapCardsAndUpdateAnswerArray(list) {
    swapNumberInsideList(list, numberArray[0][0] - 1, numberArray[1][0] - 1);
    updateAnswerArray(list, numberArray[0][1], numberArray[0][0] - 1, numberArray[1][0] - 1, numberArray[0][2], numberArray[1][2]);
}

function swapNumberCards() {
    if(numberArray.length == 2 && numberArray[0][1] == numberArray[1][1]) { // if both the numbers are from same rows then we proceed.
        switch(numberArray[0][1]) {
            case 1:
                swapCardsAndUpdateAnswerArray(items.firstCardListModel);
                break;
            case 2:
                swapCardsAndUpdateAnswerArray(items.secondCardListModel);
                break;
            case 3:
                swapCardsAndUpdateAnswerArray(items.thirdCardListModel);
                break;
        }
        numberArray.length = 0;
        resetSize();
    }
    else if(numberArray.length == 2 && numberArray[0][1] != numberArray[1][1]) { // if selected numbers are from different rows.
        numberArray.length = 0;
        resetSize();
    }
}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel) {
        currentLevel = 0;
    }
    initLevel();
}

function nextDatasetLevel() {
    if(numberOfDatasetLevel <= ++currentDatasetLevel) {
        currentDatasetLevel = 0;
    }
    currentLevel = 0;
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1;
    }
    initLevel();
}

function checkAnswer() {
    var check = [true, true, true];
    for(var row = 0; row < answerArray.length; row++) {
        var isGood = true;
        for(var col = 1; col < answerArray[row].length; col+=2) {
            if(parseInt(answerArray[row][col-1]) + parseInt(answerArray[row][col]) != 10) {
                isGood = false;
            }
        }
        if(!isGood) {
            check[row] = false;
        }
    }
    check[0] ? items.validationImage1 = correctAnswerImage : items.validationImage1 = wrongAnswerImage;
    check[1] ? items.validationImage2 = correctAnswerImage : items.validationImage2 = wrongAnswerImage;
    check[2] ? items.validationImage3 = correctAnswerImage : items.validationImage3 = wrongAnswerImage;
    check[0] && check[1] && check[2] ? items.bonus.good("flower") : items.bonus.bad("flower");
}
