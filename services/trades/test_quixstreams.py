# Create an Application instance with Kafka configs
from quixstreams import Application


app = Application(
    broker_address='localhost:31092', consumer_group='example'
)

# Define a topic "my_topic" with JSON serialization
topic = app.topic(name='my_topic', value_serializer='json')



# Create a Producer instance
with app.get_producer() as producer:
    while True:
        # 1. Get event from source
        event = {"id": "1", "text": "Lorem ipsum dolor sit amet"}
        # 2. Serialize an event using the defined Topic 
        message = topic.serialize(key=event["id"], value=event)
        # 3. Produce a message into the Kafka topic
        producer.produce(
            topic=topic.name, value=message.value, key=message.key
        )
        # 4. Sleet for 1 sec
        import time
        time.sleep(1)