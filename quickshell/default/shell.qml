import Quickshell
import QtQuick
import Quickshell.Services.UPower
import Quickshell.Io

PanelWindow {

  property var visibility: true

  visible: visibility

    SystemClock {
      id: clock
      precision: SystemClock.Minutes
    }

    property var poppupwidth: 300
    property var poppupheight: 100
    property var margin: 10 //screen ke kone se doori
    property var borderwidth: 3

  anchors {
    top: true
    right: true
  }
  margins {
    top: margin
    right: margin
  }
  color: "transparent"
  implicitWidth: poppupwidth
  implicitHeight: poppupheight
  Rectangle { 
      anchors.fill: parent
      radius: 8
      opacity: 0.9
      border {
        width: 3
        color: "#c6a0f6"
      }
      color: "#24273A" 

      Text {
      anchors {
          centerIn: parent
        }
      text: Qt.formatDateTime(clock.date, "ddd dd MMMM yyyy, hh:mm AP") + "\n \n" + UPower.displayDevice.changeRate.toFixed(2) + " Watts, Battery is at " + Math.round(UPower.displayDevice.percentage * 100) + "%"

      color: "#cdd6f4"
    }

    }
}
