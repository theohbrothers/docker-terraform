FROM alpine:edge
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache terraform=1.0.6-r1

CMD [ "terraform" ]
