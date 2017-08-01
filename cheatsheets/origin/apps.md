 # login
 oc login
 oc new-project test
 oc new-app openshift/deployment-example
 oc status

# app mgt

oc status -v
oc logs -f bc/ruby-ex
oc project <name>
# use a label so you can delete them all at once
 oc delete all -l name=<name>


oc new-app openshift/deployment-example -l name=<name>

# builder image should be compatible with STI (source to image)
# this image builder is deprecated
oc new-app openshift/nodejs-010-centos7~https://github.com/openshift/nodejs-ex.git -l name=<name>
# this is a new builder 120 MB
oc new-app centos/nodejs-4-centos7~https://github.com/openshift/nodejs-ex.git -l name=<name>

# or rhel image (only works if you are running on rhel)
oc new-app rhscl/nodejs-4-rhel7~https://github.com/openshift/nodejs-ex.git -l name=<name>

oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-ex.git
oc new-app centos/ruby-22-centos7~https://github.com/codiechanel/ruby-ex.git