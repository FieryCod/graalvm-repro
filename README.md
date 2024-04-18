# GraalVM Reproduction

## How to reproduce

1. Install Clojure ([see here](https://clojure.org/guides/install_clojure)).
2. Make sure the latest GraalVM Java Oracle and native image is on your path.
3. Then run `./compile.sh`. (from time to time the command has to be run few times to be able to reproduce the problem)

## Details

```text
java --version
java 22 2024-03-19
Java(TM) SE Runtime Environment Oracle GraalVM 22+36.1 (build 22+36-jvmci-b02)
Java HotSpot(TM) 64-Bit Server VM Oracle GraalVM 22+36.1 (build 22+36-jvmci-b02, mixed mode, sharing)

native-image --version
native-image 22 2024-03-19
GraalVM Runtime Environment Oracle GraalVM 22+36.1 (build 22+36-jvmci-b02)
Substrate VM Oracle GraalVM 22+36.1 (build 22+36, serial gc, compressed references)
```

## Error message

```text
❯ ./compile.sh
nativetest.main
========================================================================================================================
GraalVM Native Image: Generating 'native-test' (executable)...
========================================================================================================================
[1/8] Initializing...                                                                                    (4.5s @ 0.12GB)
 Java version: 22+36, vendor version: Oracle GraalVM 22+36.1
 Graal compiler: optimization level: 2, target machine: armv8-a, PGO: off
 C compiler: cc (apple, arm64, 15.0.0)
 Garbage collector: Serial GC (max heap size: 80% of RAM)
 1 user-specific feature(s):
 - com.oracle.svm.thirdparty.gson.GsonFeature
------------------------------------------------------------------------------------------------------------------------
 2 experimental option(s) unlocked:
 - '-H:NumberOfThreads' (alternative API option(s): --parallelism=16; origin(s): command line)
 - '-H:ReflectionConfigurationFiles': Use a reflect-config.json in your META-INF/native-image/<groupID>/<artifactID> directory instead. (origin(s): command line)
------------------------------------------------------------------------------------------------------------------------
Build resources:
 - 21.33GB of memory (133.3% of 16.00GB system memory, set via '-Xmx24g')
 - 16 thread(s) (160.0% of 10 available processor(s), set via '--parallelism=16')
[2/8] Performing analysis...  []                                                                         (0.3s @ 0.11GB)
      431 reachable types   (25.0% of    1,722 total)
      121 reachable fields  ( 9.4% of    1,289 total)
      776 reachable methods (11.4% of    6,784 total)
      111 types,     0 fields, and   103 methods registered for reflection

Error: Class initialization of clojure.lang.Compiler failed. Use the option

    '--initialize-at-run-time=clojure.lang.Compiler'

 to explicitly request initialization of this class at run time.
com.oracle.svm.core.util.UserError$UserException: Class initialization of clojure.lang.Compiler failed. Use the option

    '--initialize-at-run-time=clojure.lang.Compiler'

 to explicitly request initialization of this class at run time.
        at org.graalvm.nativeimage.builder/com.oracle.svm.core.util.UserError.abort(UserError.java:97)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.classinitialization.ClassInitializationSupport.ensureClassInitialized(ClassInitializationSupport.java:195)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.classinitialization.AllowAllHostedUsagesClassInitializationSupport.computeInitKindAndMaybeInitializeClass(AllowAllHostedUsagesClassInitializationSupport.java:182)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.classinitialization.AllowAllHostedUsagesClassInitializationSupport.computeInitKindAndMaybeInitializeClass(AllowAllHostedUsagesClassInitializationSupport.java:120)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.classinitialization.ClassInitializationSupport.maybeInitializeAtBuildTime(ClassInitializationSupport.java:161)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.classinitialization.ClassInitializationSupport.maybeInitializeAtBuildTime(ClassInitializationSupport.java:150)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.SVMHost.isInitialized(SVMHost.java:319)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.meta.AnalysisType.isInitialized(AnalysisType.java:952)
        at jdk.graal.compiler/jdk.graal.compiler.java.BytecodeParser.maybeEagerlyInitialize(BytecodeParser.java:4475)
        at jdk.graal.compiler/jdk.graal.compiler.java.BytecodeParser.genInvokeStatic(BytecodeParser.java:1708)
        at jdk.graal.compiler/jdk.graal.compiler.java.BytecodeParser.genInvokeStatic(BytecodeParser.java:1701)
        at jdk.graal.compiler/jdk.graal.compiler.java.BytecodeParser.processBytecode(BytecodeParser.java:5468)
        at jdk.graal.compiler/jdk.graal.compiler.java.BytecodeParser.iterateBytecodesForBlock(BytecodeParser.java:3473)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.phases.SharedGraphBuilderPhase$SharedBytecodeParser.iterateBytecodesForBlock(SharedGraphBuilderPhase.java:790)
        at jdk.graal.compiler/jdk.graal.compiler.java.BytecodeParser.handleBytecodeBlock(BytecodeParser.java:3433)
        at jdk.graal.compiler/jdk.graal.compiler.java.BytecodeParser.processBlock(BytecodeParser.java:3275)
        at jdk.graal.compiler/jdk.graal.compiler.java.BytecodeParser.build(BytecodeParser.java:1136)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.phases.SharedGraphBuilderPhase$SharedBytecodeParser.build(SharedGraphBuilderPhase.java:202)
        at jdk.graal.compiler/jdk.graal.compiler.java.BytecodeParser.buildRootMethod(BytecodeParser.java:1028)
        at jdk.graal.compiler/jdk.graal.compiler.java.GraphBuilderPhase$Instance.run(GraphBuilderPhase.java:102)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.phases.SharedGraphBuilderPhase.run(SharedGraphBuilderPhase.java:154)
        at jdk.graal.compiler/jdk.graal.compiler.phases.Phase.run(Phase.java:49)
        at jdk.graal.compiler/jdk.graal.compiler.phases.BasePhase.apply(BasePhase.java:435)
        at jdk.graal.compiler/jdk.graal.compiler.phases.Phase.apply(Phase.java:42)
        at jdk.graal.compiler/jdk.graal.compiler.phases.Phase.apply(Phase.java:38)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.flow.AnalysisParsedGraph.parseBytecode(AnalysisParsedGraph.java:144)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.meta.AnalysisMethod.parseGraph(AnalysisMethod.java:888)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.meta.AnalysisMethod.ensureGraphParsedHelper(AnalysisMethod.java:853)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.meta.AnalysisMethod.ensureGraphParsed(AnalysisMethod.java:836)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.phases.InlineBeforeAnalysisGraphDecoder.lookupEncodedGraph(InlineBeforeAnalysisGraphDecoder.java:198)
        at jdk.graal.compiler/jdk.graal.compiler.replacements.PEGraphDecoder.doInline(PEGraphDecoder.java:1215)
        at jdk.graal.compiler/jdk.graal.compiler.replacements.PEGraphDecoder.tryInline(PEGraphDecoder.java:1198)
        at jdk.graal.compiler/jdk.graal.compiler.replacements.PEGraphDecoder.trySimplifyInvoke(PEGraphDecoder.java:1053)
        at jdk.graal.compiler/jdk.graal.compiler.replacements.PEGraphDecoder.handleInvokeWithCallTarget(PEGraphDecoder.java:1005)
        at jdk.graal.compiler/jdk.graal.compiler.replacements.PEGraphDecoder.handleInvoke(PEGraphDecoder.java:991)
        at jdk.graal.compiler/jdk.graal.compiler.nodes.GraphDecoder.processNextNode(GraphDecoder.java:930)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.phases.InlineBeforeAnalysisGraphDecoder.processNextNode(InlineBeforeAnalysisGraphDecoder.java:377)
        at jdk.graal.compiler/jdk.graal.compiler.nodes.GraphDecoder.decode(GraphDecoder.java:658)
        at jdk.graal.compiler/jdk.graal.compiler.replacements.PEGraphDecoder.decode(PEGraphDecoder.java:895)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.phases.InlineBeforeAnalysis.decodeGraph(InlineBeforeAnalysis.java:73)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.flow.MethodTypeFlowBuilder.parse(MethodTypeFlowBuilder.java:198)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.flow.MethodTypeFlowBuilder.apply(MethodTypeFlowBuilder.java:608)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.flow.MethodTypeFlow.createFlowsGraph(MethodTypeFlow.java:167)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.flow.MethodTypeFlow.ensureFlowsGraphCreated(MethodTypeFlow.java:152)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.flow.MethodTypeFlow.getOrCreateMethodFlowsGraphInfo(MethodTypeFlow.java:110)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.typestate.DefaultStaticInvokeTypeFlow.lambda$update$0(DefaultStaticInvokeTypeFlow.java:75)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.util.LightImmutableCollection.forEach(LightImmutableCollection.java:90)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.typestate.DefaultStaticInvokeTypeFlow.update(DefaultStaticInvokeTypeFlow.java:74)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.PointsToAnalysis$1.run(PointsToAnalysis.java:538)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.util.CompletionExecutor.executeCommand(CompletionExecutor.java:169)
        at org.graalvm.nativeimage.pointsto/com.oracle.graal.pointsto.util.CompletionExecutor.lambda$executeService$0(CompletionExecutor.java:154)
        at java.base/java.util.concurrent.ForkJoinTask$RunnableExecuteAction.compute(ForkJoinTask.java:1726)
        at java.base/java.util.concurrent.ForkJoinTask$RunnableExecuteAction.compute(ForkJoinTask.java:1717)
        at java.base/java.util.concurrent.ForkJoinTask$InterruptibleTask.exec(ForkJoinTask.java:1641)
        at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:507)
        at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1491)
        at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:2073)
        at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:2035)
        at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:187)
Caused by: java.lang.ExceptionInInitializerError
        at clojure.lang.Compiler.<clinit>(Compiler.java:48)
        at java.base/jdk.internal.misc.Unsafe.ensureClassInitialized0(Native Method)
        at java.base/jdk.internal.misc.Unsafe.ensureClassInitialized(Unsafe.java:1160)
        at org.graalvm.nativeimage.builder/com.oracle.svm.hosted.classinitialization.ClassInitializationSupport.ensureClassInitialized(ClassInitializationSupport.java:177)
        ... 57 more
Caused by: java.lang.NullPointerException: Cannot invoke "clojure.lang.Var.isBound()" because "clojure.lang.Compiler.LOADER" is null
        at clojure.lang.RT.baseLoader(RT.java:2177)
        at clojure.lang.RT.load(RT.java:432)
        at clojure.lang.RT.load(RT.java:424)
        at clojure.lang.RT.<clinit>(RT.java:338)
        ... 61 more
------------------------------------------------------------------------------------------------------------------------
                        0.2s (3.1% of total time) in 15 GCs | Peak RSS: 0.47GB | CPU load: 2.20
========================================================================================================================
Failed generating 'native-test' after 5.0s.
```
