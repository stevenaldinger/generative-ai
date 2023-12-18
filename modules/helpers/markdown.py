import re

# TODO: do this safer by only checking the first and last lines
# otherwise there's an edge case with the code itself containing
# the triple ticks
def strip_markdown(text):
    """
    Strips markdown code blocks from a string.

    :param text: the text to strip
    :type text: str
    :return: the stripped text
    :rtype: str
    """

    stripped_results = re.sub(r'```.*\n', '', text)
    stripped_results = re.sub(r'```', '', stripped_results)
    return stripped_results
