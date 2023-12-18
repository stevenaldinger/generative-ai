import random
import string

def generate_uuid(length: int = 8) -> str:
    """
    Generates a uuid of a specified length (default=8).

    :param length: the length of the uuid to generate
    :type length: int
    :return: the uuid
    :rtype: str
    """

    return "".join(random.choices(string.ascii_lowercase + string.digits, k=length))
