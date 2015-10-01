import unittest
import os
from pyrabbit.api import Client


class MqSmokeTest(unittest.TestCase):
    def setUp(self):
        self.cl = Client("mq:15672",
                         os.environ.get("MQ_ENV_RABBITMQ_DEFAULT_USER"),
                         os.environ.get("MQ_ENV_RABBITMQ_DEFAULT_PASS"))
        self.assertTrue(self.cl.is_alive())

    #TODO: Unskip once component that creates sfm_change available.
    @unittest.skip("Skipped until component available.")
    def test_exchange(self):
        exchanges = self.cl.get_exchanges()
        for exchange in exchanges:
            if exchange["name"] == "sfm_exchange":
                break
        else:
            self.assertTrue(False, "Exchange not found.")

    #TODO: Unskip once flickr_harvester available.
    @unittest.skip("Skipped until flickr_harvester available.")
    def test_queues(self):
        queues = self.cl.get_exchanges()
        queues_names = {queue["name"] for queue in queues}
        #Add additional queue names as new components are added.
        self.assertTrue(queues_names.issuperset(set(["flickr_harvester",])))