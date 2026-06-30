IF(UNIX OR NOT WIN32)
    RETURN()
ENDIF()

qt_generate_deploy_app_script(
    TARGET bibletime
    OUTPUT_SCRIPT bibletime_deploy_script
    INCLUDE_PLUGIN_TYPES
        texttospeech
    INCLUDE_PLUGINS
        qgif
        qjpeg
        qsvg
        qsvgicon
    PRE_EXCLUDE_REGEXES
        [[^(.*[/\])?api-ms-[^/\]*$]]
        [[^(.*[/\])?ext-ms-[^/\]*$]]
        [[^(.*[/\])?HvsiFileTrust\.dll$]]
        [[^(.*[/\])?wpaxholder\.dll$]]
)
INSTALL(SCRIPT "${bibletime_deploy_script}")

INSTALL(RUNTIME_DEPENDENCY_SET bibletime_runtime_deps
    DESTINATION "${BT_BINDIR}"
    DIRECTORIES ${RUNTIME_DEPENDENCY_SET_DIRECTORIES}
    PRE_EXCLUDE_REGEXES
        [[^(.*[/\])?Qt6[^/\]*\.dll$]]
        [[^(.*[/\])?api-ms-[^/\]*$]]
        [[^(.*[/\])?ext-ms-[^/\]*$]]
        [[^(.*[/\])?HvsiFileTrust\.dll$]]
        [[^(.*[/\])?wpaxholder\.dll$]]
    POST_EXCLUDE_REGEXES
        [[/build\.bibletime/]]
)

SET(CPACK_PACKAGE_NAME "BibleTime")
SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "BibleTime for Windows")
SET(CPACK_PACKAGE_VENDOR "https://bibletime.info")
SET(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
SET(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
SET(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
SET(CPACK_PACKAGE_INSTALL_DIRECTORY "BibleTime")

SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")

# We need the libraries, and they're not pulled in automatically
SET(CMAKE_INSTALL_DEBUG_LIBRARIES TRUE)

# Some options for the CPack system.  These should be pretty self-evident
SET(CPACK_PACKAGE_ICON "${CMAKE_CURRENT_SOURCE_DIR}\\\\pics\\\\icons\\\\bibletime.png")
SET(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\bibletime.exe")
SET(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY}")
SET(CPACK_NSIS_HELP_LINK "https:\\\\\\\\bibletime.info")
SET(CPACK_NSIS_URL_INFO_ABOUT "https:\\\\\\\\bibletime.info")
SET(CPACK_NSIS_CONTACT "bt-devel@crosswire.org")
SET(CPACK_NSIS_MODIFY_PATH OFF)
SET(CPACK_GENERATOR "NSIS")

SET(CPACK_PACKAGE_EXECUTABLES "bibletime" "BibleTime")

# This adds in the required Windows system libraries
MESSAGE(STATUS  "INSTALL Microsoft Redist ${MSVC_REDIST}" )
SET(CPACK_NSIS_EXTRA_INSTALL_COMMANDS "
    ExecWait \\\"$INSTDIR\\\\bin\\\\vcredist_x86.exe  /q\\\"
    Delete   \\\"$INSTDIR\\\\bin\\\\vcredist_x86.exe\\\"
")

INCLUDE(CPack)
