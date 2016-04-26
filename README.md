# Event-Driven Architecture Demo

## 1: About this project

The following project demonstrates how a fairly common application can be
separated into several smaller and independent (micro) services and applications,
improving scalability, and overall system resiliency.

We achieve the necessary inter-service communication using a message queue
provided by RabbitMQ.

We're (kind-of) refactoring Kuri's "e-commerce" sample application, but this time we'll
start from the ground up implementing several applications:

* The "Users" service: Provide the users list, OAuth flows, tokens, & etc.
* The "Wallets" service: It may not actually be considered as a part of the demo,
as we just needed a dummy payment method of some sort.
* The "Products" service: which provides a list of things that can be bought.
* The "Purchases" service: which stores all the items purchased by the users.
* The "Analytics" service: Stores all system events permanently so it can be used
for later analysis without impacting on the other databases.
* The "Web Front-End" service: Stores a web application that provides the UI that
integrates all the services into a user experience.

Be aware that, although we're implementing all of these as Ruby-On-Rails applications,
is expected that some of them actually migrate into other technologies.

## 2: Development Walkthroughs

I've provided several walkthroughs with some exercises and activities that
illustrate the development process of this demo:

* [01: Event-Driven Architecture 101: Messages, Producers and Consumers](dev-walkthroughs/DEMO-01.md)


## 3: Awesome references
* [REST vs Messaging for Microservices](http://www.slideshare.net/ewolff/rest-vs-messaging-for-microservices)
* [From Obvious to Ingenius: Incrementally Scaling Web Apps on PostgreSQL](http://www.slideshare.net/kigster/from-obvious-to-ingenius-incrementally-scaling-web-apps-on-postgresql)
