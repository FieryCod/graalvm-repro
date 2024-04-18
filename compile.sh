#!/bin/bash

rm -Rf .cpcache target classes

mkdir -p classes target

clojure -M -e "(compile 'nativetest.main)"

native-image nativetest.main -cp $(clojure -Spath):classes \
        -o native-test \
        --no-fallback \
        -J-Xmx24g \
        -H:+UnlockExperimentalVMOptions \
        -H:NumberOfThreads=16 \
        -H:ReflectionConfigurationFiles=reflectconfig.json \
        -H:+ReportExceptionStackTraces \
        --report-unsupported-elements-at-runtime \
        --initialize-at-build-time=clojure,nativetest \
        --initialize-at-run-time=java.util.UUID\$Holder

