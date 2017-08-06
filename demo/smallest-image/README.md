# this is a trick to run docker within docker without actually installing docker on the container

docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) -ti google/golang /bin/bash

# this works because we linked our host docker bin to the guest container

# now we can compile our code

CGO_ENABLED=0 go get -a -ldflags '-s' github.com/adriaandejonge/helloworld

# this command fetches the source code from github and build it 

# now the src and bin files are in /go

# next we copy a ready made dockerfile to our go dir

cp /go/src/github.com/adriaandejonge/helloworld/Dockerfile /go

# we start building a docker container within the container

docker build -t adejonge/helloworld .

# the resulting image does not get stored inside the container, but to our host...

# this could easily be done using multi stage build but our version of docker dnt support it yet 


# the dockerfile is simple, it contains nothing but our binary..

FROM scratch
ADD bin/helloworld /helloworld
CMD ["/helloworld"]