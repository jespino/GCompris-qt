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
import QtQml.Models 2.12
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

        QtObject {
            id: items
            property Item main: activity.main
            property alias background: background
            property alias bar: bar
            property alias bonus: bonus
            readonly property var levels: activity.datasetLoader.data
            property alias dataListModel: dataListModel
            property int selected: -1
            property double spacingOfElement: 50
            property double sizeOfElement: 90
            property int step: 0
            property int numOfRowsSelected: 0
            property int index: 0//charList.charListContent.charListContentRepeater.index2

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
            anchors.leftMargin: items.sizeOfElement
            anchors.bottomMargin: items.sizeOfElement
            anchors.right: charList.left
            Rectangle {
                width: parent.width
                height: parent.height
                color: "#FFFFFF"
                Column {
                    id: wholeExerciceDisplayContent
                    spacing: 5
                    anchors.right: parent
                    width: parent.width
                    Repeater {
                            model: dataListModel
                            delegate:
                            Item {
                                height: items.sizeOfElement
                                width: parent.width
                                property int modelIndex: DelegateModel.itemsIndex
                                Rectangle {
                                    id: mathSymbolDisplay
                                    height: items.sizeOfElement
                                    width: items.sizeOfElement
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "transparent"
                                    GCText {
                                        color: "#000000"
                                        text:symbolPlainText
                                        fontSize: smallSize
                                        anchors.fill : parent
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                items.index = modelIndex
                                                Activity.mouseAreaAction()
                                            }
                                        }
                                    }
                                }

                                GCText {
                                    id: rightHandSideCharDisplay
                                    anchors.left: mathSymbolDisplay.right
                                    anchors.leftMargin: items.sizeOfElement
                                    color: currentlySelected === true ? "orange" : "#000000"
                                    font.bold : currentlySelected === true ? true : false
                                    text: rightHandSide
                                    fontSize: smallSize
                                        MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            items.index = modelIndex
                                            Activity.mouseAreaAction()
                                        }
                                    }
                                }
                                GCText {
                                    id: leftHandSideCharDisplay
                                    anchors.right: mathSymbolDisplay.left
                                    anchors.rightMargin: items.sizeOfElement
                                    color: currentlySelected === true ? "orange" : "#000000"
                                    font.bold : currentlySelected === true ? true : false
                                    text: leftHandSide
                                    fontSize: smallSize
                                        MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                                items.index = modelIndex
                                                Activity.mouseAreaAction()
                                        }
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
                            id: charListContentRepeater
                            model: dataListModel
                            delegate:
                            Item {
                                height: items.sizeOfElement
                                width: parent.width
                                property int modelIndex: DelegateModel.itemsIndex
                                Rectangle {
                                    id: mathSymbolDisplay
                                    height: items.sizeOfElement
                                    width: items.sizeOfElement
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
                                                items.index = modelIndex
                                                Activity.mouseAreaAction()
                                            }
                                        }
                                    }
                                }

                                GCText {
                                    id: rightHandSideCharDisplay
                                    anchors.left: mathSymbolDisplay.right
                                    anchors.leftMargin: items.sizeOfElement
                                    color: currentlySelected === true ? "orange" : "white"
                                    font.bold : currentlySelected === true ? true : false
                                    text: rightHandSide
                                    fontSize: mediumSize
                                        MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            items.index = modelIndex
                                            Activity.mouseAreaAction()
                                        }
                                    }
                                }
                                GCText {
                                    id: leftHandSideCharDisplay
                                    color: currentlySelected === true ? "orange" : "#FFFFFF"
                                    font.bold : currentlySelected === true ? true : false
                                    anchors.right: mathSymbolDisplay.left
                                    anchors.rightMargin: items.sizeOfElement
                                    text: leftHandSide
                                    fontSize: mediumSize
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            items.index = modelIndex
                                            Activity.mouseAreaAction()
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
            //visible: items.selected === -1 ? false : true
            Row {
                spacing: items.spacingOfElement
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
                        Activity.upAction()
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
                       Activity.downAction()
                    }
                }
            }
        }

       Item {
            id: selectedAnswerArea
            height: layoutArea.height * 0.1
            width: layoutArea.width
            anchors.bottom: symbolSelectionRow.top
            anchors.bottomMargin: items.sizeOfElement
            anchors.top: wholeExerciceDisplay.bottom
            anchors.topMargin: items.size
                GCText {
                    id:leftHandSideHighlightDisplay
                    color: "#FFFFFF"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.right: inputAreaHighlightDisplay.left
                    anchors.rightMargin: items.sizeOfElement
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
                    anchors.leftMargin: items.sizeOfElement
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
                spacing: items.sizeOfElement
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
            height: items.sizeOfElement
            width: items.sizeOfElement
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
        Keys.onUpPressed: Activity.upAction()
        Keys.onDownPressed:Activity.downAction()
    }

}