import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import org.kde.kirigami 2.7 as Kirigami
import org.mauikit.controls 1.2 as Maui

import org.maui.sol 1.0 as Sol

import "views/browser"
import "views/widgets"
import "views/history"
import "views/home"

Maui.ApplicationWindow
{
    id: root
    title: _browserView.currentTab.title
    autoHideHeader: false

    readonly property var views : ({browser: 0, tabs: 1, history: 2})

    readonly property alias currentBrowser : _browserView.currentBrowser
    property bool editMode: false

    Settings
    {
        id: appSettings
        category: "Browser"

        property url homePage: "https://duckduckgo.com"
        property url searchEnginePage: "https://duckduckgo.com/?q="
        property color backgroundColor : root.Kirigami.Theme.backgroundColor

        property bool accelerated2dCanvasEnabled : true
        property bool allowGeolocationOnInsecureOrigins : false
        property bool allowRunningInsecureContent : false
        property bool allowWindowActivationFromJavaScript : false
        property bool autoLoadIconsForPage : true
        property bool autoLoadImages : true
        //        property bool defaultTextEncoding : string
        property bool dnsPrefetchEnabled : false
        property bool errorPageEnabled : true
        property bool focusOnNavigationEnabled : false
        property bool fullscreenSupportEnabled : false
        property bool hyperlinkAuditingEnabled : false
        property bool javascriptCanAccessClipboard : true
        property bool javascriptCanOpenWindows : true
        property bool javascriptCanPaste : true
        property bool javascriptEnabled : true
        property bool linksIncludedInFocusChain : true
        property bool localContentCanAccessFileUrls : true
        property bool localContentCanAccessRemoteUrls : false
        property bool localStorageEnabled : true
        property bool pdfViewerEnabled : true
        property bool playbackRequiresUserGesture : true
        property bool pluginsEnabled : false
        property bool printElementBackgrounds : true
        property bool screenCaptureEnabled : true
        property bool showScrollBars : true
        property bool spatialNavigationEnabled : false
        property bool touchIconsEnabled : false
        //        property bool unknownUrlSchemePolicy : WebEngineSettings::UnknownUrlSchemePolicy
        property bool webGLEnabled : true
        property bool  webRTCPublicInterfacesOnly : false

    }

    SettingsDialog
    {
        id: _settingsDialog
    }

    headBar.visible: _swipeView.currentIndex === views.browser

    footBar.visible: _swipeView.currentIndex !== views.browser


    altHeader: !root.isWide
    headBar.forceCenterMiddleContent: false
    headBar.middleContent: NavigationBar
    {
        Layout.fillWidth: true
        Layout.maximumWidth: 500
        position: root.altHeader ? ToolBar.Footer : ToolBar.Header
    }


    headBar.rightContent: ToolButton
    {
        icon.name: "list-add"
        onClicked: _browserView.openTab("")
    }

    Maui.AppViews
    {
        id: _swipeView
        anchors.fill: parent
        currentIndex: views.browser
        toolbar: root.footBar

        BrowserView
        {
            id: _browserView
            Maui.AppView.title: i18n("Browser")
            Maui.AppView.iconName: "internet-web-browser"
        }

        HistoryView
        {
            id : _historyView //recent and history && bookmarks
            Maui.AppView.title: i18n("Recent")
            Maui.AppView.iconName: "shallow-history"
        }

        HomeView
        {
            id : _homeView // downloads
            Maui.AppView.title: i18n("Home")
            Maui.AppView.iconName: "go-home"
        }
    }

}
