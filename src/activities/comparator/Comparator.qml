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
            property double size: 100
            property int step: 0

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
            id: charList_plainText
            height: layoutArea.height*0.5
            width: layoutArea.width
            Column {
                id: charListContent_plainText
                spacing: 5
                Repeater {
                    model: dataListModel
                    delegate:
                    Row {
                        spacing: items.spacing
                        height: items.size
                        GCText {
                            color: "#FFFFFF"
                            text: leftHandSide
                            fontSize: largeSize
                        }
                        GCText {
                            color: "#FFFFFF"
                            text: symbolPlainText
                            fontSize: largeSize
                        }
                        GCText {
                            color: "#FFFFFF"
                            text: rightHandSide
                            fontSize: largeSize
                        }
                    }
                }
            }
        }
        Item {
            id: charList
            height: layoutArea.height*0.5
            width: layoutArea.width
            anchors.right: layoutArea.right

            Flickable {
                height: parent.height
                width: parent.width
                contentHeight: charListContent.implicitHeight
                clip: true
                Column {
                    id: charListContent
                    anchors.right: parent.right
                    spacing: 5
                    Repeater {
                        model: dataListModel
                        delegate:
                        Row {
                            spacing: items.spacing
                            height: items.size
                            GCText {
                                color: currentlySelected === "1" ? "red" : "#FFFFFF"
                                text: leftHandSide
                                fontSize: currentlySelected === "1" ? largeSize : largeSize
                            }
                            Rectangle {
                                height: parent.height
                                width: parent.height
                                radius: 10
                                color: "orange"
                                border.width : 20
                                border.color: "#E8E8E8"
                                GCText {
                                    color: "#000000"
                                    text: symbol
                                    anchors.fill : parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                            GCText {
                                color: currentlySelected === "1" ? "red" : "#FFFFFF"
                                text: rightHandSide
                                fontSize: currentlySelected === "1" ? largeSize : largeSize
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: upDownButtonSet
            height: layoutArea.height*0.1
            width: layoutArea.width
            anchors.top: charList.bottom
            anchors.topMargin: 20*ApplicationInfo.ratio
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
                            dataListModel.get(items.selected).currentlySelected = "0"
                            items.selected --
                            dataListModel.get(items.selected).currentlySelected = "1"
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
                            if(items.selected > -1 ) dataListModel.get(items.selected).currentlySelected = "0"
                            items.selected ++
                            dataListModel.get(items.selected).currentlySelected = "1"
                        }
                        items.step = dataListModel.get(items.selected).symbol === "" ? 0 : 1

                    }
                }
            }
        }

       Item {
            id: selectedArea
            height: layoutArea.height*0.1
            width: layoutArea.width
            anchors.top: upDownButtonSet.bottom
            anchors.topMargin: 20*ApplicationInfo.ratio

            Row {
                spacing: items.spacing
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                GCText {
                    id:leftHandSide
                    color: "#FFFFFF"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    height: parent.height
                    text: (items.selected === -1) ? "" : dataListModel.get(items.selected).leftHandSide.toString()
                }

                Rectangle {
                        id: inputArea
                        height: parent.height
                        width: parent.height
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
                    id:rightHandSide
                    color: "#FFFFFF"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    height: parent.height
                    text: (items.selected === -1) ? "" : dataListModel.get(items.selected).rightHandSide.toString()
                }
            }
        }

        Item {
            height: layoutArea.height*0.1
            width: layoutArea.width
            anchors.bottom: bar.top
            anchors.bottomMargin: 30*ApplicationInfo.ratio
            Row {
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: items.size
                GCButton {
                    id: lessThan
                    height: parent.height
                    width: parent.height
                    onClicked: {
                        items.step = 0
                        dataListModel.get(items.selected).symbol = "<"
                        dataListModel.get(items.selected).symbolPlainText = "  <  "
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
                        text:"<"
                        fontSize: largeSize
                        color: "#FFFFFF"
                    }
                }

                GCButton {
                    id: equal
                    height: parent.height
                    width: parent.height
                    onClicked:{
                        items.step = 0
                        dataListModel.get(items.selected).symbol = "="
                        dataListModel.get(items.selected).symbolPlainText = "  =  "
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
                    id: greaterThan
                    height: parent.height
                    width: parent.height
                    onClicked: {
                        items.step = 0
                        dataListModel.get(items.selected).symbol = ">"
                        dataListModel.get(items.selected).symbolPlainText = "  >  "
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

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level }
            onHelpClicked: {
                displayDialog(dialogHelp)
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
