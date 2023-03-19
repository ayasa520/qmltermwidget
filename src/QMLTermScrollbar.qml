import QMLTermWidget 1.0
import QtQuick 2.0

Item {
    property QMLTermWidget terminal
    property int value: terminal.scrollbarCurrentValue
    property int minimum: terminal.scrollbarMinimum
    property int maximum: terminal.scrollbarMaximum
    property int lines: terminal.lines
    property int totalLines: lines + maximum

    function showScrollbar() {
        opacity = 1;
        hideTimer.restart();
    }

    anchors.right: terminal.right
    opacity: 0
    height: terminal.height * (lines / (totalLines - minimum))
    y: (terminal.height / (totalLines)) * (value - minimum)

    Connections {
        function onScrollbarValueChanged() {
            showScrollbar();
        }

        target: terminal
    }

    Timer {
        id: hideTimer

        onTriggered: parent.opacity = 0
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }

    }

}
