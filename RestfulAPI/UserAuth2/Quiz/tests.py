class URLTests(TestCase):
    def test_testLogin(self):
        response = self.client.get('/view/running/')
        self.assertEqual(response.status_code, 404)
