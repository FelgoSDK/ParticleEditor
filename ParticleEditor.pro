# V-Play project
CONFIG += v-play

# V-Play Demo Game
customFolder.source = qml
DEPLOYMENTFOLDERS += customFolder

# Add Icon
win32 {
    # Icon Resource for exe file
    RC_FILE += win/app_icon.rc
    # Icon Resource for dynamic icon of title bar and task bar
    # If using MSVC the code may end up in "release" or "debug" sub dir
    CONFIG(debug, debug|release): OUTDIR = debug
    else: OUTDIR = release
    # copy the icon file to the exe folder
    QMAKE_POST_LINK += copy /y \"$$PWD\"\\win\\app_icon.ico \"$$OUT_PWD\"\\\"$$OUTDIRs\"
}

# Add sources
SOURCES += main.cpp


# App-specific plaform settings
symbian {    
    # this must be unique for every app on the device - UIDs starting with 0xE are only for local testing
    TARGET.UID3 = 0xE26818A3
    # Smart Installer package's UID
    # This UID is from the protected range and therefore the package will
    # fail to install if self-signed. By default qmake uses the unprotected
    # range value if unprotected UID is defined for the application and
    # 0x2002CCCF value if protected UID is given to the application
    #DEPLOYMENT.installer_header = 0x2002CCCF

    TARGET.EPOCSTACKSIZE = 0x14000
    TARGET.EPOCHEAPSIZE = 0x020000 0x8000000

} else: contains(MEEGO_EDITION,harmattan) {

    # due to bug in QtQcreator 2.4, on meego it is not possible to upload bigger files than 4MB!
    # this bug is fixed with QtCreator 2.5, so use 2.5 for deploying to meego!

    # for further information look at qmlapplicationviewer.pri
    DATADIR = /usr/share
    DEFINES += \
        DATADIR=\\\"$$DATADIR\\\"

    desktop.files = meego/$${TARGET}.desktop
    desktop.path = /usr/share/applications

    # this is the icon that will be displayed in the package manager
    icon64.files = meego/$${TARGET}64.png
    icon64.path = $$DATADIR/icons/hicolor/64x64/apps

    # this gets referenced in the .desktop file and is the image that gets displayed on the meego app desktop!
    icon80.files = meego/$${TARGET}80.png
    icon80.path = $$DATADIR/icons/hicolor/80x80/apps

    INSTALLS += icon64 \
                icon80 \
                desktop

}

# Following configs are needed for Mac App Store publishing
macx {
    COMPANY = "V-Play GmbH"
    BUNDLEID = net.vplay.demos.mac.ParticleEditor
    ICON = macx/app_icon.icns
    QMAKE_INFO_PLIST = macx/ParticleEditor-Info.plist
    ENTITLEMENTS = macx/ParticleEditor.entitlements
}

#RESOURCES += \
#    resources_particleEditor.qrc
