from unittest import TestCase, mock
from tempfile import NamedTemporaryFile
import os
from ..files import absolute_path_or_data_dir, download_file_if_not_exists, read_file

class FilesTestCase(TestCase):
  @mock.patch.dict(os.environ, {'USER': 'testuser'})
  def test_absolute_path_or_data_dir(self):
    """
    This test also tests get_data_dir indirectly
    """

    result = absolute_path_or_data_dir('my_file.txt')

    self.assertEqual(result, f'/home/testuser/work/data/my_file.txt')


  @mock.patch.dict(os.environ, {'USER': 'testuser', 'DATA_DIR': '/tmp/data'})
  def test_absolute_path_or_data_dir_with_env_var_override(self):
    """
    This test also tests get_data_dir indirectly
    """

    result = absolute_path_or_data_dir('my_file.txt')

    self.assertEqual(result, f'/tmp/data/my_file.txt')


  def test_download_file_if_not_exists(self):
      """
      Tests that if the file exists already, it will not be overriden.
      """

      with NamedTemporaryFile() as tf:
        result = download_file_if_not_exists('http://fake-url', tf.name)
        self.assertEqual(result, tf.name)


  def test_read_file_that_does_not_exist(self):
    with self.assertRaises(Exception) as context:
        read_file('definitely-does-not-exist.txt')

    self.assertTrue('does not exist' in str(context.exception))


  def test_read_file_that_exists(self):
      with NamedTemporaryFile() as tf:
        result = read_file(tf.name)
