FROM cloudfoundry/run:base

COPY java-runtime /java-runtime
COPY archive /archive

ENTRYPOINT ["sh", "-c", "java-runtime/bin/java -cp archive/BOOT-INF/classes/:archive/:archive/BOOT-INF/lib/* org.springframework.samples.petclinic.PetClinicApplication"]