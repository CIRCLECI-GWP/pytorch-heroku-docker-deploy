import requests


def download_image(url, filename):
    response = requests.get(url)
    if response.status_code == 200:
        with open(filename, "wb") as f:
            f.write(response.content)
        return filename
    else:
        raise Exception(f"Unable to download image from {url}")


def get_bytes_from_image(image_path):
    return open(image_path, "rb").read()
