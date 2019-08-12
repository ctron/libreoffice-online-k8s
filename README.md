# LibreOffice Online for Kubernetes

This repository hosts a few deployment scripts which allow you to deploy
LibreOffice Online on Kubernetes/OpenShift.

## Personal playground

It is just a personal repository, finding out what is necessary to get
started with LibreOffice Online in a Kubernetes environment. If it works
for you as well, cool. If not, maybe fix the issue an create a PR.

As I have an OpenShift cluster, I am keen on using OpenShift features, like
ImageStreams, triggers and Routes. Of course this should also work
without those features, but I didn't test it.

## Installation

Apply the `deploy` folder to your cluster in a new namespace:

    oc new-project libreoffice
    oc apply -f deploy/

This will setup a new deployment and expose a service + route.

## Now what?

The following sections assume that `https://your.cluster` is your cluster
DNS name, and that `https://apps.your.cluster` is your apps prefix.

The LibreOffice endpoint will be available at https://libreoffice-libreoffice.apps.your.cluster/
but it will simply show `OK` as the web page.

You can open the web editor using the URL https://libreoffice-libreoffice.apps.your.cluster/loleaflet/dist/loleaflet.html. This will however only show an error "Wrong or missing WOPISrc parameter, ..."
as this editor is intended to be embedded into a WOPI host.

You can also open the Admin Web UI on https://libreoffice-libreoffice.apps.your.cluster/loleaflet/dist/admin/admin.html The admin UI is secured with the username/password from the secret.

## Some details

The original container image from LibreOffice expects to be run as priviliged
container, having additional capabilities to do things like seccomp. However,
at least on OpenShift, this is not needed as this is all done by the container runtime
itself. So all the fancy process forking, filtering, jails is more in the way than doing
good. Ideally it would also be better to not fork processes in the container,
but to fork new pods instead. But as noted earlier, this was just a pet project,
playing around and checkout out what is possible.

So one thing I had to do, was to drop the enhanced capabilities and fix a few issues
which were caused by the fact that this is not running in Docker, but on a Kubernetes
environment. But you can see the `Dockerfile` in this repository.