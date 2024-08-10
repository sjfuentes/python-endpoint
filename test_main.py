import unittest
from main import app

class MainTestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()

    def test_devops_post(self):
        response = self.app.post('/DevOps', json={'data': 'example'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json['message'], 'Success')

    def test_devops_get(self):
        response = self.app.get('/DevOps')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json['message'], 'Success')

    def test_devops_put(self):
        response = self.app.put('/DevOps', json={'data': 'example'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json['message'], 'Success')

    def test_devops_delete(self):
        response = self.app.delete('/DevOps')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json['message'], 'Success')

    def test_devops_patch(self):
        response = self.app.patch('/DevOps', json={'data': 'example'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json['message'], 'Success')

if __name__ == '__main__':
    unittest.main()