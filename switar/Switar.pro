QT += core gui widgets

CONFIG += c++20 thread console
CONFIG -= app_bundle

TARGET = switar
TEMPLATE = app

INCLUDEPATH += modules

SOURCES += main.cpp \
           modules/sources/clickablelabel.cpp \
           modules/sources/kineticscrollarea.cpp \
           modules/sources/switar.cpp

HEADERS += modules/headers/clickablelabel.h \
           modules/headers/kineticscrollarea.h \
           modules/headers/switar.h
