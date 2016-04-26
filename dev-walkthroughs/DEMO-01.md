# 01: Event-Driven Architecture 101: Messages, Producers and Consumers

## Introduction: RabbitMQ & Rails applications


On the other end, we have the following:

```ruby
# wallets/app/consumers/test_consumer.rb
class TestConsumer
  include Hutch::Consumer
  consume "test.echo"

  def process(message)
    logger.info "Received Echo Test: #{message[:echo]}"
  end
end
```

## Messages != ActiveJob
While the same message mechanics apply to ActiveJob tasks, in this demo project
each message does not necessarily imply that a task needs to be run.

## Example 1: Producing Messages (or how to shout stuff into the air...)

* On a browser, keep open the RabbitMQ management console at
http://development.local:15672, so you can monitor any message activity.
* Using plis, start a rails console in a users-web service container:
`plis run users-web rails c`:

```ruby
# Create a connection to the message system:
Hutch.connect

# Shout something into the "test.echo" topic:
Hutch.publish "test.echo", echo: "Hello!"

# Repeat the last command up to your heart's content!
```

"If a tree falls in a forest and no one is around to hear it, does it make a sound?"

So you've been shouting "Hello!" into the air... but besides of the message
monitor, no one else is listening to you, so that's pretty useless. We'll fire
up another app to listen to this lonely fella:

## Example 2: Consuming Messages (or listening to what a lonely app wants...)

Let's start the "wallets-subscriber" service using plis, and follow the logs:

```bash
plis start wallets-subscriber && plis logs wallets-subscriber
```

On the terminal window opened on the previous example, keep shouting stuff, and
observe how the messages shouted are now being displayed in our "wallets-subscriber"
service logs, confirming the fact that the messages are being listened to.

* Note: Sometimes docker-compose (the stuff behind plis) will stop following the
logs and complain about a timeout. This happens a lot to your truly, and annoying
as it is, just repeat the `plis logs wallets-subscriber` command.

## Example 3: Pausing a consumer (or how to go, pee, and be back without being noticed...)

Now let's stop the "wallets-subscriber" service using plis on a 3rd terminal window:

```bash
plis stop wallets-subscriber
```

Also, go to the second window, and clear the screen (On Mac, type CMD+K).

Go back to the first terminal window - the one we use to shout stuff - and shout
two or more messages... No one is listening - again - but this time, the messages
were saved in the queue created by our "wallets-subscriber" service... Do you
want to see them again? Start the "wallets-subscriber" service again:

```bash
plis start wallets-subscriber
```

Finally, go back to the second terminal window - the one with the subscriber
logs - and see how the messages you shouted while the consumer was offline were
received and displayed when the consumer got back online!

## Example 4: Scaling consumers (or bringing more people to the party...)
On the last 2 examples we saw how a consumer app creates a new queue into which
messages are saved prior to their consumption, and how that helps us whenever
the listener application suddenly goes offline...

Now let's see what happens when the opposite occurs - Let's scale our listener
app to 4 instances using the third terminal window:

```bash
plis scale wallets-subscriber=4
```

Wait a little while so that the extra 3 instances come back online, then shout
some more messages at the first terminal window... then go back into the second
terminal window, and be amazed by the rainbow of colors being displayed courtesy
of the 4 instances receiving one of the shouted messages.

## (Your) Final Thoughts:
Now you can see the main idea behind Event-Driven Architectures.

I hope these examples illustrated the improvements that EDA's bring to:
* Scalability: Need more power to process those messages? Bring up more listeners!
* Resiliency: Need to take offline some module/app to fix it or update/upgrade it?
No problem! Messages will be saved into the queue, ready to be delivered when the
app gets back online!
* Updateability: Updating one app dependency doesn't depend on other apps being
updated for the same dependency. Plus, no other app needs to be taken down while
updating.
* Upgradeability and Replaceability: Let's say we have an improved wallets system...
we don't need to do something extra to other apps! plus we can have both the old
and the new system running at the same time, in case there are other stuff not
yet ready to migrate to the new system.
* Any other bilities :P
