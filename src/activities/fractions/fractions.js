/* GCompris - fractions.js
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

    // todo make separate activity
    if(currentLevel > 8) {
        items.mode = "findResult"
    }
    else {
        items.mode = "selectPie"
    }
    items.pieSeries.clear();
    items.denominatorValue = (items.mode === "findResult") ? 0 : levels[currentLevel].denominator;
    items.numeratorValue = 0;
    items.denominatorToFind = levels[currentLevel].denominator;
    items.numeratorToFind = (items.mode === "findResult") ? levels[currentLevel].numerator : 0;

    var size = 1.0 / levels[currentLevel].denominator;
    for(var i = 0 ; i < items.denominatorToFind ; ++ i) {
        items.pieSeries.append(1, size);

        // Select the good number of slices at the beginning
        items.pieSeries.setSliceStyle(items.pieSeries.count-1, (items.mode === "findResult" && i < items.numeratorToFind));
    }
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
