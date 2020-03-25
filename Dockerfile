# https://lists.openshift.redhat.com/openshift-archives/users/2017-July/msg00026.html

FROM alpine:3.5

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Setup during docker build time
COPY build.sh /usr/src/app
RUN chmod +x /usr/src/app/build.sh && /usr/src/app/build.sh

# Command to run when running image
COPY run.sh /usr/src/app
RUN chmod +x /usr/src/app/run.sh

# Running as root will now fail due with a permissions error, so default to some
# other UID
USER 1000

CMD /usr/src/app/run.sh
