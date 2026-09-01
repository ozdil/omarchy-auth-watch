import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

Panel {
  id: root
  moduleName: "ozdil.auth-watch"
  ipcTarget: "ozdil.auth-watch"

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "󰌾 Auth"
    slotSize: Style.bar.statusSlot
    tooltipText: "Auth Watch: Sudo & SSH login monitor"
    onPressed: root.toggle()
  }

  KeyboardPanel {
    id: panel
    anchorItem: button
    owner: root
    width: 420
    contentHeight: panel.fittedContentHeight(mainCol.implicitHeight)

    Column {
      id: mainCol
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.top: parent.top
      spacing: Style.space(12)

      Text {
        text: "🚨 Auth Watchdog"
        font.pixelSize: Style.font.title
        font.bold: true
        color: root.bar ? root.bar.foreground : "#ffffff"
      }

      Button {
        width: parent.width
        text: "📋 Oturum Loglarını İncele"
        onClicked: {
          root.close()
          if (root.bar) root.bar.run("omarchy-launch-floating-terminal-with-presentation $HOME/.config/omarchy/plugins/auth-watch/auth-dashboard")
        }
      }
    }
  }
}
