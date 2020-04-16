Download Petclinic code:

```
$ mkdir -p petclinic
$ curl -L https://github.com/spring-projects/spring-petclinic/archive/master.tar.gz | tar xz -C petclinic --strip-components 1
$ (cd petclinic; ./mvnw package)
```

Check we are using Java 14:

```
$ java -version
openjdk version "14" 2020-03-17
OpenJDK Runtime Environment AdoptOpenJDK (build 14+36)
OpenJDK 64-Bit Server VM AdoptOpenJDK (build 14+36, mixed mode, sharing)
```

List the module dependencies:

```
$ mkdir -p archive && (cd archive; jar -xf ../petclinic/target/*.jar)
$ jdeps --ignore-missing-deps --multi-release=14 -cp archive/BOOT-INF/classes/ --print-module-deps archive/BOOT-INF/classes/org/springframework/samples/petclinic/PetClinicApplication.class archive/BOOT-INF/lib/\*
java.base,java.compiler,java.desktop,java.instrument,java.management.rmi,java.prefs,java.scripting,java.security.jgss,java.security.sasl,java.sql.rowset,jdk.attach,jdk.httpserver,jdk.jdi,jdk.management,jdk.net,jdk.unsupported
```

Then to make a runtime take the list of modules from the `jdeps` output and plug it into `jlink`:

```
$ jlink --no-header-files --no-man-pages --add-modules java.base,java.compiler,java.desktop,java.instrument,java.management.rmi,java.prefs,java.scripting,java.security.jgss,java.security.sasl,java.sql.rowset,jdk.attach,jdk.httpserver,jdk.jdi,jdk.management,jdk.net,jdk.unsupported --output java-runtime
$ java-runtime/bin/java -jar petclinic.jar
...
2020-04-16 15:04:53.649 INFO 21122 --- [ main] o.s.b.w.embedded.tomcat.TomcatWebServer : Tomcat started on port(s): 8080 (http) with context path ''
2020-04-16 15:04:53.651 INFO 21122 --- [ main] o.s.s.petclinic.PetClinicApplication : Started PetClinicApplication in 4.872 seconds (JVM running for 5.328)
...
```
