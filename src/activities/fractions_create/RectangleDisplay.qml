/* GCompris - RectangleDisplay.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import QtQml.Models 2.12

GridView {
    id: chart
    anchors.fill: parent
    model: ListModel {
        id: listModel
    }
    cellWidth: parent.width / model.count
    cellHeight: parent.height
    delegate: Rectangle {
        border.width: 1
        border.color: "black"
        color: selected ? selectedColor : unselectedColor
        width: chart.cellWidth;
        height: chart.cellHeight;

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(bonus.isPlaying || activity.mode === "findFraction") {
                    return;
                }
                if(selected) {
                    numeratorText.value --;
                }
                else {
                    numeratorText.value ++;
                }
                selected = !selected;
            }
        }
    }

    readonly property string selectedColor: "#ff0000"
    readonly property string unselectedColor: "#00ffff"

    function initLevel() {
        chart.model.clear();
        for(var i = 0 ; i < items.denominatorToFind ; ++ i) {
            // Select the good number of slices at the beginning
            chart.model.append({
                "selected": activity.mode === "findFraction" && i < items.numeratorToFind
            });
        }
    }

    function checkAnswer() {
        var goodAnswer = false;
        if(activity.mode === "selectPie") {
            // count how many selected
            var selected = 0;
            for(var i = 0 ; i < listModel.count ; ++ i) {
                if(listModel.get(i).selected) {
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
