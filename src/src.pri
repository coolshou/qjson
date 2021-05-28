QJSON_BASE = ..
QJSON_SRCBASE = $$PWD/

TEMPLATE = lib
QT      -= gui
TARGET   = qjson
DESTDIR  = $$QJSON_BASE/lib
CONFIG += create_prl

VERSION = 0.9.0

windows: {
  DEFINES += QJSON_MAKEDLL
}

macx: CONFIG += lib_bundle

QJSON_CPP = $$QJSON_SRCBASE
INCLUDEPATH += $$QJSON_CPP

PRIVATE_HEADERS += \
  $$PWD/json_parser.hh \
  $$PWD/json_scanner.h \
  $$PWD/location.hh \
  $$PWD/parser_p.h  \
  $$PWD/position.hh \
  $$PWD/qjson_debug.h  \
  $$PWD/stack.hh

PUBLIC_HEADERS += \
  $$PWD/parser.h \
  $$PWD/parserrunnable.h \
  $$PWD/qobjecthelper.h \
  $$PWD/serializer.h \
  $$PWD/serializerrunnable.h \
  $$PWD/qjson_export.h

HEADERS += $$PRIVATE_HEADERS $$PUBLIC_HEADERS

SOURCES += \
  $$PWD/json_parser.cc \
  $$PWD/json_scanner.cpp \
  $$PWD/parser.cpp \
  $$PWD/parserrunnable.cpp \
  $$PWD/qobjecthelper.cpp \
  $$PWD/serializer.cpp \
  $$PWD/serializerrunnable.cpp

symbian: {
  DEFINES += QJSON_MAKEDLL
  #export public header to \epocroot\epoc32\include to be able to use them
  headers.files = $$PUBLIC_HEADERS
  headers.path = $$PWD
  for(header, headers.files) {
    {BLD_INF_RULES.prj_exports += "$$header"}
  }

  TARGET.EPOCALLOWDLLDATA = 1
  # uid for the dll
  #TARGET.UID3=
  TARGET.CAPABILITY = ReadDeviceData WriteDeviceData

  # do not freeze api-> no libs produced. Comment when freezing!
  # run "abld freeze winscw" to create def files
  symbian:MMP_RULES += "EXPORTUNFROZEN"

  # add dll to the sis
  QjsonDeployment.sources = $${TARGET}.dll
  QjsonDeployment.path = /sys/bin

  DEPLOYMENT += QjsonDeployment
}
