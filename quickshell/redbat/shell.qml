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
        color: "#ed8796"
      }
      color: "#24273A" 

      Text {
      anchors {
          centerIn: parent
        }
      text: "Battery is less than 15%, please charge"

      color: "#ed8796"
    }

    }
}
