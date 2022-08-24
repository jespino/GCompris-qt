/* GCompris - fractions_create.js
 *
 * Copyright (C) 2022 Johnny Jazeix <jazeix@gmail.com>
 *
 * SPDX-FileCopyrightText: Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0
var numberOfLevel
var levels
var items

function start(items_) {
    items = items_
    currentLevel = 0
    levels = items.levels
    numberOfLevel = levels.length
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1
    items.chartType = levels[currentLevel].chartType;

    items.fixedNumerator = levels[currentLevel].fixedNumerator ? levels[currentLevel].fixedNumerator : false;
    items.fixedDenominator = levels[currentLevel].fixedDenominator ? levels[currentLevel].fixedDenominator : false;

    items.denominatorValue = (items.mode === "findFraction" && !items.fixedDenominator) ? 0 : levels[currentLevel].denominator;
    items.denominatorToFind = levels[currentLevel].denominator;
    items.numeratorValue = (items.mode === "findFraction" && items.fixedNumerator) ? levels[currentLevel].numerator : 0;
    items.numeratorToFind = (items.mode === "findFraction") ? levels[currentLevel].numerator : 0;

    items.chartItem.initLevel();
}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel) {
        currentLevel = 0
    }
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1
    }
    initLevel();
}
