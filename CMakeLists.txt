cmake_minimum_required(VERSION 3.21)

project(Soothe LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.11 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(Soothe
    src/main.cpp
)

# Suppress warnings for new QT changes in 6.5 and 6.8
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

qt_add_qml_module(
    Soothe
    URI SootheModule  # Must be different than executable name
    QML_FILES
        src/Main.qml
)

target_link_libraries(
    Soothe
    PRIVATE Qt6::Quick
)

