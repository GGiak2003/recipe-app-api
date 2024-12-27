"""
Sample tests
"""
from django.test import SimpleTestCase
from app import calc


class CalcTest(SimpleTestCase):
    """ Test the calc module. """

    def test_add_numbers(self):
        """" Test adding numbers toghether. """
        res = calc.add(5, 6)

        self.assertEqual(res, 11)

    def test_subract_numbers(self):
        """ Test subracting numbers. """

        res = calc.subtract(15, 10)

        self.assertEqual(res, 5)
