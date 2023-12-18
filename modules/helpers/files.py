import os
import requests

def absolute_path_or_data_dir(path):
    """
    Returns the absolute path for the given path, prepending the data directory
    if it's a relative path.

    Parameters
    ----------
    path : str
        The path to the file or directory.

    Returns
    -------
    str
        The absolute path to the file or directory.
    """

    # if not an absolute path, append it to the data directory
    if not path.startswith('/'):
        data_dir = get_data_dir()
        path = f'{data_dir}/{path}'

    return path


def download_file(url, path):
    """
    NOTE: Consider using the download_file_if_not_exists function instead so you
    can effectively cache the result.

    Downloads a file from a URL and saves it to the specified path within the
    data directory or absolute path if given. Returns the path to the downloaded
    file or prints the error and returns None if an error occurs.

    Parameters
    ----------
    url : str
        The URL of the file to download.
    path : str
        The path to save the file to within the data directory.

    Returns
    -------
    str
        The path to the downloaded file or None if an error occurs.
    """

    # if not an absolute path, append it to the data directory
    if not path.startswith('/'):
        data_dir = get_data_dir()
        path = f'{data_dir}/{path}'

    # I went crazy with error handling out of curiosity but we'll probably
    # want to handle retries differently depending on the exception eventually
    try:
        response = requests.get(url, timeout=1, verify=True)
        response.raise_for_status()
        with open(path, 'wb') as file:
            file.write(response.content)
        return path
    except requests.exceptions.HTTPError as errh:
        print('HTTP Error', errh)
        print(errh.args[0])
        return None
    except requests.exceptions.ReadTimeout as errrt:
        print('Timeout Error', errrt)
        return None
    except requests.exceptions.ConnectionError as conerr:
        print('Connection Error', conerr)
        return None
    except requests.exceptions.RequestException as errex:
        print('Request exception', errex)
        return None
    except Exception as e:
        print('Unknown exception', e)
        return None


def download_file_if_not_exists(url, path):
    """
    If no file already exists at the specified path, downloads a file from a URL
    and saves it to the specified path within the data directory. Returns the path
    to the file or prints the error and returns None if an error occurs.

    Parameters
    ----------
    url : str
        The URL of the file to download.
    path : str
        The path to save the file to within the data directory.

    Returns
    -------
    str
        The path to the downloaded file or None if an error occurs.
    """

    # if not an absolute path, append it to the data directory
    path = absolute_path_or_data_dir(path)

    if not os.path.exists(path):
        return download_file(url, path)

    return path

def file_exists(path, sub_dir = None):
    """
    Checks whether a file exists at the specified path. If an absolute path
    is not passed in and sub_dir is specified, the sub directory path will be
    appended to the data directory path before looking for the file.

    Parameters
    ----------
    path : str
        The path to the file to check.
    sub_dir : str, optional
        The subdirectory to check within the data directory (default is None).

    Returns
    -------
    bool
        Whether the file exists.
    """

    # if not an absolute path, append it to the data directory
    if not path.startswith('/'):
        data_dir = get_data_dir()

        path = f'{data_dir}/{path}' if sub_dir is None else f'{data_dir}/{sub_dir}/{path}'

    return os.path.exists(path)


def get_data_dir():
    """
    Gets the absolute path to the data directory, assuming the docker environment
    is in use (or that you're on Linux). You can override the default by setting
    the DATA_DIR environment variable.

    Returns
    -------
    str
        The absolute path to the data directory.
    """

    # if the DATA_DIR environment variable is set, return that
    if 'DATA_DIR' in os.environ:
        return os.environ['DATA_DIR']

    # otherwise point to the data volume mounted in the docker-compose.yml
    username = os.getenv('USER')
    data_dir = f'/home/{username}/work/data'

    return data_dir


def make_dir_if_not_exists(path):
    """
    Makes a directory if it doesn't already exist. This accepts a relative path
    from the data directory or a full path. If a path with a period is passed in,
    it's assumed the period indicates a file extension and everything before the
    final slash will be taken as the dir.

    Parameters
    ----------
    path : str
        The path to the directory to create, or file to create a parent directory for.

    Returns
    -------
    str
        The path to the directory that was created or already existed.

    Raises
    ------
    Exception
        If the path doesn't exist and can't be created.
    """

    # if the path contains a period, assume it's a file and get
    # the directory from everything before the final slash
    if '.' in path:
        path = path[:path.rfind('/')]

    # if not an absolute path, append it to the data directory
    path = absolute_path_or_data_dir(path)

    if not os.path.exists(path):
        # BUG: this check always returns false even though it can write fine
        #
        # check for write access before trying to make a dir
        # if os.access(path, os.W_OK):
        #     os.makedirs(path)
        # else:
        #     raise Exception(f'Cannot write to {path}')
        os.makedirs(path)

    return path


def read_file(path, as_array = False, strip = False):
    """
    Reads the contents of a file and returns it as a string, or an array of strings.

    Parameters
    ----------
    path : str
        The path to the file to read.
    as_array : bool, optional
        Whether to return the file contents as an array of lines (default is False).
    strip : bool, optional
        Whether to strip whitespace and newlines from text (default is False). This
        can be useful if you're reading in a file that has empty lines between
        paragraphs and you want to remove them. Only applies if as_array is True.

    Returns
    -------
    str
        The contents of the file.

    Raises
    ------
    Exception
        If the file doesn't exist.
    """

    if not os.path.exists(path):
        raise Exception(f'File {path} does not exist')

    with open(path, 'r') as file:
        if as_array:
            text = file.readlines() if not strip else [line.strip() for line in file.readlines()]
        else:
            text = file.read()

    return text
