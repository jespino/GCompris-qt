/* GCompris - ChartDisplay.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtCharts 2.0

ChartView {
    id: chart
    anchors.fill: parent
    backgroundColor: "#80FFFFFF"
    legend.visible: false
    antialiasing: true
    readonly property string selectedColor: "#ff0000"
    readonly property string unselectedColor: "#00ffff"
    PieSeries {
        id: pieSeries
        size: 0.9

        PieSlice {
            value: 1;
            color: chart.unselectedColor
            borderColor: "#373737"
            borderWidth: 5
        }

        onClicked: {
            if(bonus.isPlaying || items.mode === "findResult") {
                return;
            }
            if(slice.color == chart.selectedColor) {
                numeratorText.value --;
                slice.color = chart.unselectedColor;
            }
            else {
                numeratorText.value ++;
                slice.color = chart.selectedColor;
            }
        }

        function setSliceStyle(sliceNumber, selected) {
            var slice = pieSeries.at(sliceNumber);
            slice.borderColor = "#373737";
            slice.borderWidth = 5;
            slice.color = selected ? chart.selectedColor : chart.unselectedColor;
        }
    }

    function initLevel() {
        pieSeries.clear();
        var size = 1.0 / items.denominatorToFind;
        for(var i = 0 ; i < items.denominatorToFind ; ++ i) {
            pieSeries.append(1, size);

            // Select the good number of slices at the beginning
            pieSeries.setSliceStyle(pieSeries.count-1, (items.mode === "findResult" && i < items.numeratorToFind));
        }

    }
    function checkAnswer() {
        var goodAnswer = false;
        if(items.mode === "selectPie") {
            // count how many selected
            var selected = 0;
            for(var i = 0 ; i < pieSeries.count ; ++ i) {
                if(pieSeries.at(i).color == chart.selectedColor) {
                    selected ++;
                }
            }
            goodAnswer = (selected == items.levels[bar.level-1].numerator);
        }
        else {
            goodAnswer = (items.numeratorValue == items.numeratorToFind) && (items.denominatorValue == items.denominatorToFind);
        }
        if(goodAnswer) {
            bonus.good("lion");
        }
        else {
            bonus.bad("lion");
        }
    }   
}
