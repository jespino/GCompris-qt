/* GCompris - Fractions.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import QtCharts 2.12
import GCompris 1.0

import "../../core"
import "fractions.js" as Activity

ActivityBase {
    id: activity

    onStart: focus = true
    onStop: {}

    readonly property string mode: "selectPie"
    pageComponent: Rectangle {
        id: background
        color: "#373737"
        anchors.fill: parent
        signal start
        signal stop

        Component.onCompleted: {
            dialogActivityConfig.initialize()
            activity.start.connect(start)
            activity.stop.connect(stop)
        }

        // Add here the QML items you need to access in javascript
        QtObject {
            id: items
            property Item main: activity.main
            property alias background: background
            property alias bar: bar
            property alias bonus: bonus
            property alias pieSeries: pieSeries
            property alias numeratorValue: numeratorText.value
            property alias denominatorValue: denominatorText.value
            property int numeratorToFind: 0
            property int denominatorToFind: 0
            property var levels: activity.datasetLoader.data
            property string mode
            property bool fixedNumerator: true
            property bool fixedDenominator: true
        }

        onStart: {
            items.mode = activity.mode;
            Activity.start(items, activity.mode);
        }
        onStop: { Activity.stop() }

        //instruction rectangle
        Rectangle {
            id: instruction
            anchors.fill: instructionTxt
            opacity: 0.8
            radius: 10
            border.width: 2
            z: 10
            border.color: "#DDD"
            color: "#373737"
        }
        //instruction for playing the game
        GCText {
            id: instructionTxt
            anchors {
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            text: items.levels[bar.level-1].instruction
            opacity: instruction.opacity
            z: instruction.z
            fontSize: background.vert ? regularSize : smallSize
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            width: Math.max(Math.min(parent.width * 0.8, text.length * 8), parent.width * 0.3)
            wrapMode: TextEdit.WordWrap
        }

        ChartView {
            id: chart
            width: Math.min(parent.width - 2 * (okButton.width + okButton.anchors.rightMargin), parent.height-bar.height * 1.5 - instruction.height)
            height: width
            backgroundColor: "#80FFFFFF"
            legend.visible: false
            antialiasing: true
            anchors {
                top: instruction.bottom
                horizontalCenter: parent.horizontalCenter
            }
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
        }

        Item {
            id: fractionDisplay
            anchors.verticalCenter: chart.verticalCenter
            anchors.left: chart.right
            width: 140
            FractionNumber {
                id: numeratorText
                value: 0
                width: fractionDisplay.width
                height: 50
                interactive: items.mode === "findResult"
                onLeftClicked: {
                    if(items.numeratorValue > 0) {
                        items.numeratorValue --;
                    }
                }
                onRightClicked: {
                    items.numeratorValue ++;
                }
            }
            Rectangle {
                id: fractionBar
                width: numeratorText.childrenRect.width
                height: 5
                border.width: 5
                anchors.horizontalCenter: denominatorText.horizontalCenter
                anchors.top: numeratorText.bottom
                anchors.topMargin: 10
                color: "black"
            }
            FractionNumber {
                id: denominatorText
                value: 0
                width: fractionDisplay.width
                height: 50
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: fractionBar.bottom
                interactive: items.mode === "findResult"
                onLeftClicked: {
                    if(items.denominatorValue > 0) {
                        items.denominatorValue --;
                    }
                }
                onRightClicked: {
                    items.denominatorValue ++;
                }
            }
        }

        BarButton {
            id: okButton
            enabled: !bonus.isPlaying
            anchors {
                bottom: bar.top
                right: parent.right
                rightMargin: 10 * ApplicationInfo.ratio
                bottomMargin: height * 0.5
            }
            source: "qrc:/gcompris/src/core/resource/bar_ok.svg"
            sourceSize.width: 60 * ApplicationInfo.ratio

            onClicked: {
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
        DialogChooseLevel {
            id: dialogActivityConfig
            currentActivity: activity.activityInfo

            onSaveData: {
                levelFolder = dialogActivityConfig.chosenLevels
                currentActivity.currentLevels = dialogActivityConfig.chosenLevels
                ApplicationSettings.setCurrentLevels(currentActivity.name, dialogActivityConfig.chosenLevels)
            }
            onClose: {
                home()
            }
            onStartActivity: {
                background.stop()
                background.start()
            }
        }

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level | activityConfig }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onActivityConfigClicked: {
                displayDialog(dialogActivityConfig)
            }
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
        }

        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextLevel)
        }
    }

}
