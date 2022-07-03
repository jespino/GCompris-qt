/* GCompris - Comparator.qml
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 *
 * Authors:
 *   Aastha Chauhan <aastha.chauhan01@gmail.com>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import GCompris 1.0
import QtQml.Models 2.1
import QtQuick.Controls 2.12

import "../../core"
import "comparator.js" as Activity

ActivityBase {
    id: activity

    onStart: focus = true
    onStop: {}

    pageComponent: Image{
        id: background
        source: "qrc:/gcompris/src/activities/checkers/resource/background-wood.svg"
        anchors.centerIn: parent
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        sourceSize.height: height
        signal start
        signal stop

        Component.onCompleted: {
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
            readonly property var levels: activity.datasetLoader.data
            property alias dataListModel: dataListModel
            property int selected: -1
            property double spacing: 50
            property double size: 90
            property int step: 0
            property int numOfRowsSelected: 0

        }

        onStart: { Activity.start(items) }
        onStop: { Activity.stop() }

        Item {
            id: layoutArea
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: bar.top
                bottomMargin: bar.height * 0.2
            }
        }

        ListModel {
            id: dataListModel
        }
       Item {
            id: wholeExerciceDisplay
            width: layoutArea.width * 0.5
            height: parent.height * 0.5
            anchors.left: layoutArea.left
                Column {
                    id: wholeExerciceDisplayContent
                    spacing: 5
                    anchors.right: parent
                    width: parent.width
                    Repeater {
                            model: dataListModel
                            delegate:
                            Item {
                                height: items.size
                                width: parent.width
                                property int index: DelegateModel.itemsIndex
                                Rectangle {
                                    id: mathSymbolDisplay
                                    height: items.size
                                    width: items.size
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "transparent"
                                    GCText {
                                        color: "white"
                                        text:symbolPlainText
                                        fontSize: LargeSize
                                        anchors.fill : parent
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                if (items.selected > -1 ) {
                                                dataListModel.get(items.selected).currentlySelected = false
                                                items.selected = index
                                                dataListModel.get(items.selected).currentlySelected = true
                                                }
                                            items.step = dataListModel.get(items.selected).symbol === "" && items.selected !== -1 ? 0 : 1
                                            }
                                        }
                                    }
                                }

                                GCText {
                                    id: rightHandSideCharDisplay
                                    anchors.left: mathSymbolDisplay.right
                                    anchors.leftMargin: items.size
                                    color: "white"
                                    text: rightHandSide
                                    fontSize: mediumSize
                                        MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            if (items.selected > -1 ) {
                                            dataListModel.get(items.selected).currentlySelected = false
                                            items.selected = index
                                            dataListModel.get(items.selected).currentlySelected = true
                                            }
                                        items.step = dataListModel.get(items.selected).symbol === "" && items.selected !== -1 ? 0 : 1
                                        }
                                    }
                                }
                                GCText {
                                    id: leftHandSideCharDisplay
                                    color: "#FFFFFF"
                                    anchors.right: mathSymbolDisplay.left
                                    anchors.rightMargin: items.size
                                    text: leftHandSide
                                    fontSize: mediumSize
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            if (items.selected > -1 ) {
                                            dataListModel.get(items.selected).currentlySelected = false
                                            items.selected = index
                                            dataListModel.get(items.selected).currentlySelected = true
                                            }
                                            items.step = dataListModel.get(items.selected).symbol === "" && items.selected !== -1 ? 0 : 1
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

       Item {
            id: charList
            width: layoutArea.width * 0.5
            height: parent.height * 0.5
            anchors.right: layoutArea.right
                Column {
                    id: charListContent
                    spacing: 5
                    anchors.right: parent
                    width: parent.width
                    Repeater {
                            model: dataListModel
                            delegate:
                            Item {
                                height: items.size
                                width: parent.width
                                property int index: DelegateModel.itemsIndex
                                Rectangle {
                                    id: mathSymbolDisplay
                                    height: items.size
                                    width: items.size
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    radius: 10
                                    color: "orange"
                                    border.width : 20
                                    border.color: "#E8E8E8"
                                    GCText {
                                        color: "#FFFFFF"
                                        text: symbol
                                        font.bold: true
                                        anchors.fill : parent
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                if (items.selected > -1 ) {
                                                dataListModel.get(items.selected).currentlySelected = false
                                                items.selected = index
                                                dataListModel.get(items.selected).currentlySelected = true
                                                }
                                            items.step = dataListModel.get(items.selected).symbol === "" && items.selected !== -1 ? 0 : 1
                                            }
                                        }
                                    }
                                }

                                GCText {
                                    id: rightHandSideCharDisplay
                                    anchors.left: mathSymbolDisplay.right
                                    anchors.leftMargin: items.size
                                    color: currentlySelected === true ? "orange" : "white"
                                    font.bold : currentlySelected === true ? true : false
                                    text: rightHandSide
                                    fontSize: mediumSize
                                        MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            if (items.selected > -1 ) {
                                            dataListModel.get(items.selected).currentlySelected = false
                                            items.selected = index
                                            dataListModel.get(items.selected).currentlySelected = true
                                            }
                                        items.step = dataListModel.get(items.selected).symbol === "" && items.selected !== -1 ? 0 : 1
                                        }
                                    }
                                }
                                GCText {
                                    id: leftHandSideCharDisplay
                                    color: currentlySelected === true ? "orange" : "#FFFFFF"
                                    font.bold : currentlySelected === true ? true : false
                                    anchors.right: mathSymbolDisplay.left
                                    anchors.rightMargin: items.size
                                    text: leftHandSide
                                    fontSize: mediumSize
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            if (items.selected > -1 ) {
                                            dataListModel.get(items.selected).currentlySelected = false
                                            items.selected = index
                                            dataListModel.get(items.selected).currentlySelected = true
                                            }
                                            items.step = dataListModel.get(items.selected).symbol === "" && items.selected !== -1 ? 0 : 1
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

        Item {
            id: upDownButtonSet
            height: layoutArea.height * 0.1
            width: layoutArea.width
            anchors.top: charList.bottom
            anchors.topMargin: 20 * ApplicationInfo.ratio
            anchors.right: layoutArea.right
            Row {
                spacing: items.spacing
                anchors.right: parent.right
                BarButton {
                    id: upButton
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    sourceSize.height: parent.height
                    rotation: -90
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#FFFFFF"
                        border.color: "#000000"
                        border.width: 4
                        opacity: 0.2
                    }
                    onClicked: {
                        if (items.selected > -1 ){
                            dataListModel.get(items.selected).currentlySelected = false
                            items.selected --
                            dataListModel.get(items.selected).currentlySelected = true
                        }
                        items.step = dataListModel.get(items.selected).symbol === "" && items.selected !== -1 ? 0 : 1
                    }
                }

                BarButton {
                    id: downButton
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    sourceSize.height: parent.height
                    rotation: +90
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#FFFFFF"
                        border.color: "#000000"
                        border.width: 4
                        opacity: 0.2
                    }
                    onClicked: {
                        if (items.selected < (dataListModel.count - 1)){
                            if(items.selected > -1 ) dataListModel.get(items.selected).currentlySelected = false
                            items.selected ++
                            dataListModel.get(items.selected).currentlySelected = true
                        }
                        items.step = dataListModel.get(items.selected).symbol === "" ? 0 : 1

                    }
                }
            }
        }

       Item {
            id: selectedAnswerArea
            height: layoutArea.height * 0.1
            width: layoutArea.width
            anchors.bottom: symbolSelectionRow.top
            anchors.bottomMargin: items.size
            anchors.topMargin: 20 * ApplicationInfo.ratio
                GCText {
                    id:leftHandSideHighlightDisplay
                    color: "#FFFFFF"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.right: inputAreaHighlightDisplay.left
                    anchors.rightMargin: items.size
                    height: parent.height
                    text: (items.selected === -1) ? "" : dataListModel.get(items.selected).leftHandSide.toString()
                }

                Rectangle {
                        id: inputAreaHighlightDisplay
                        height: parent.height
                        width: parent.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        radius: 10
                        color: "#E8E8E8"
                        visible: items.selected !== -1
                        GCText {
                            anchors.centerIn: parent
                            color: "#000000"
                            text: (items.step === 1 && items.selected !== -1) ? dataListModel.get(items.selected).symbol : ""
                            anchors.fill : parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                }

                GCText {
                    id:rightHandSideHighlightDisplay
                    color: "#FFFFFF"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.left: inputAreaHighlightDisplay.right
                    anchors.leftMargin: items.size
                    height: parent.height
                    text: (items.selected === -1) ? "" : dataListModel.get(items.selected).rightHandSide.toString()
                }
        }

        Item {
            id: symbolSelectionRow
            height: layoutArea.height * 0.1
            width: layoutArea.width
            anchors.bottom: bar.top
            anchors.bottomMargin: 30 * ApplicationInfo.ratio
            Row {
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: items.size
                GCButton {
                    id: lessThanSign
                    height: parent.height
                    width: parent.height
                    onClicked: {
                        items.step = 0
                        dataListModel.get(items.selected).symbol = "<"
                        dataListModel.get(items.selected).symbolPlainText = "  <  "
                        dataListModel.get(items.selected).visited ++
                        //increment the numOfRowsSelected by 1 if symbol has been selected for the row
                        items.numOfRowsSelected = dataListModel.get(items.selected).visited == 1 ? items.numOfRowsSelected + 1 : items.numOfRowsSelected
                        items.step = 1
                    }
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#6495ED"
                        border.color: "#FFFFFF"
                        border.width: 4

                    }
                    GCText {
                        anchors.centerIn: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: "<"
                        fontSize: largeSize
                        color: "#FFFFFF"
                    }
                }

                GCButton {
                    id: equalSign
                    height: parent.height
                    width: parent.height
                    onClicked:{
                        items.step = 0
                        dataListModel.get(items.selected).symbol = "="
                        dataListModel.get(items.selected).symbolPlainText = "  =  "
                        dataListModel.get(items.selected).visited ++
                        //increment the numOfRowsSelected by 1 if symbol has been selected for the row
                        items.numOfRowsSelected = dataListModel.get(items.selected).visited == 1 ? items.numOfRowsSelected + 1 : items.numOfRowsSelected
                        items.step = 1
                    }
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#6495ED"
                        border.color: "#FFFFFF"
                        border.width: 4
                    }
                    GCText {
                        anchors.centerIn: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: "="
                        fontSize: largeSize
                        color: "#FFFFFF"
                    }
                }

                GCButton {
                    id: greaterThanSign
                    height: parent.height
                    width: parent.height
                    onClicked: {
                        items.step = 0
                        dataListModel.get(items.selected).symbol = ">"
                        dataListModel.get(items.selected).symbolPlainText = "  >  "
                        dataListModel.get(items.selected).visited ++
                        //increment the numOfRowsSelected by 1 if symbol has been selected for the row
                        items.numOfRowsSelected = dataListModel.get(items.selected).visited == 1 ? items.numOfRowsSelected + 1 : items.numOfRowsSelected
                        items.step = 1
                    }
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#6495ED"
                        border.color: "#FFFFFF"
                        border.width: 4
                    }
                    GCText {
                        anchors.centerIn: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: ">"
                        fontSize: largeSize
                        color: "#FFFFFF"
                    }
                }
            }
        }

        BarButton {
            id: okButton
            source: "qrc:/gcompris/src/core/resource/bar_ok.svg"
            height: items.size
            width: items.size
            visible: items.numOfRowsSelected == dataListModel.count
            anchors {
                right: parent.right
                rightMargin: 20
                bottom: bar.top
            }
            onClicked: {
                Activity.checkAnswer();
            }
        }

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        DialogChooseLevel {
            id: dialogActivityConfig
            currentActivity: activity.activityInfo

            onSaveData: {
                levelFolder = dialogActivityConfig.chosenLevels
                currentActivity.currentLevels = dialogActivityConfig.chosenLevels
                ApplicationSettings.setCurrentLevels(currentActivity.name, dialogActivityConfig.chosenLevels)
                // restart activity on saving
                background.start()
            }
            onClose: {
                home()
            }
            onStartActivity: {
                background.start()
            }
        }

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level | activityConfig }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
            onActivityConfigClicked: {
                displayDialog(dialogActivityConfig)
            }
        }

        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextLevel)
        }
    }

}
