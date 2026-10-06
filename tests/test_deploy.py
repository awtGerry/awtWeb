"""Check that the Cloudflare Worker serves the Zola build on the site's domain.

Run:  python3 -m unittest discover -s tests
Reads config.toml and wrangler.toml only; no build needed.
"""

import tomllib
import unittest
from pathlib import Path
from urllib.parse import urlparse

ROOT = Path(__file__).resolve().parent.parent


def load(name):
    with open(ROOT / name, "rb") as f:
        return tomllib.load(f)


class Worker(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.zola = load("config.toml")
        cls.worker = load("wrangler.toml")

    def test_serves_the_zola_build(self):
        output = ROOT / self.zola.get("output_dir", "public")
        assets = ROOT / self.worker["assets"]["directory"]
        self.assertEqual(assets.resolve(), output.resolve())

    def test_unknown_paths_get_the_404_page(self):
        self.assertEqual(self.worker["assets"].get("not_found_handling"), "404-page")

    def test_answers_on_the_base_url_domain(self):
        host = urlparse(self.zola["base_url"]).hostname
        domains = [r["pattern"] for r in self.worker.get("routes", []) if r.get("custom_domain")]
        self.assertEqual(domains, [host])

    def test_is_not_also_served_on_workers_dev(self):
        self.assertIs(self.worker.get("workers_dev"), False, "the site would be duplicated on *.workers.dev")


if __name__ == "__main__":
    unittest.main()
