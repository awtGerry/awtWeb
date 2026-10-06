"""Build the site with Zola and check the rendered output.

Run:  python3 -m unittest discover -s tests
Uses `zola` from PATH (e.g. inside `nix develop`); set ZOLA to override.

English lives at the root, Spanish under /es/. Tests read post titles and
slugs from the built blog pages, so editing content doesn't break them.
"""

import json
import os
import re
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PAGE_BG = "#0d1117"
BASE_URL = "https://awtgerry.com"
HOMES = {"en": "index.html", "es": "es/index.html"}
BLOGS = {"en": "blog/index.html", "es": "es/blog/index.html"}
SITE = None
SCREENSHOTS = ("pos", "planificador", "school_roster")
LIVE_SITES = {
    "projects/monarch/index.html": "https://monarchwellness.mx",
    "es/projects/monarch/index.html": "https://monarchwellness.mx",
    "projects/arenzano/index.html": "https://arenzanobeachwear.com/",
    "es/projects/arenzano/index.html": "https://arenzanobeachwear.com/",
}


def setUpModule():
    global SITE
    zola = os.environ.get("ZOLA") or shutil.which("zola")
    if not zola:
        raise RuntimeError("zola not found: run inside `nix develop` or set ZOLA")
    SITE = Path(tempfile.mkdtemp(prefix="awtweb-site-"))
    build = subprocess.run(
        [zola, "build", "--output-dir", str(SITE), "--force"],
        cwd=ROOT,
        capture_output=True,
        text=True,
    )
    if build.returncode != 0:
        raise RuntimeError(f"zola build failed:\n{build.stderr}")


def tearDownModule():
    if SITE:
        shutil.rmtree(SITE, ignore_errors=True)


def read(path):
    return (SITE / path).read_text(encoding="utf-8")


def luminance(hex_color):
    h = hex_color.lstrip("#")
    if len(h) == 3:
        h = "".join(c * 2 for c in h)
    channels = [int(h[i : i + 2], 16) / 255 for i in (0, 2, 4)]
    linear = [c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4 for c in channels]
    return 0.2126 * linear[0] + 0.7152 * linear[1] + 0.0722 * linear[2]


def contrast(a, b):
    hi, lo = sorted([luminance(a), luminance(b)], reverse=True)
    return (hi + 0.05) / (lo + 0.05)


def project_row(html, slug):
    rows = re.split(r"class=[\"']?project-item", html)
    for row in rows[1:]:
        if f"/projects/{slug}/" in row:
            return row
    raise AssertionError(f"no project row for {slug}")


def local(href):
    """Map a built link to the file it serves, e.g. https://awtgerry.com/es/cv/ -> es/cv/index.html."""
    if href.startswith(BASE_URL):
        href = href[len(BASE_URL) :] or "/"
    if not href.startswith("/"):
        raise AssertionError(f"not a site link: {href}")
    target = SITE / href.lstrip("/")
    return target / "index.html" if href.endswith("/") or target.is_dir() else target


def rel(path):
    return path.relative_to(SITE).as_posix()


def in_spanish(path):
    return path.startswith("es/")


def title(html):
    return re.search(r"<title>(.*?)</title>", html, re.S).group(1).strip()


def heading(html):
    return re.sub(r"<[^>]+>", "", re.search(r"<h1>(.*?)</h1>", html, re.S).group(1)).strip()


def attr(attrs, name):
    """An attribute's value, quoted or not (minified HTML drops the quotes)."""
    m = re.search(rf"(?<![\w-]){name}=(?:\"([^\"]*)\"|'([^']*)'|([^\s>]+))", attrs)
    return m and next(g for g in m.groups() if g is not None)


def anchors(html):
    """(href, class, text) for every <a> in the html."""
    return [
        (attr(attrs, "href"), attr(attrs, "class"), text.strip())
        for attrs, text in re.findall(r"<a\s([^>]*)>(.*?)</a>", html, re.S)
    ]


def nav(html):
    return html[html.index("<nav") : html.index("</nav>")]


def main(html):
    return html[html.index("<main") :]


def lang_switch(html):
    return next(h for h, cls, _ in anchors(nav(html)) if cls and "lang-switch" in cls.split())


def built_pages():
    for page in sorted(SITE.rglob("*.html")):
        yield rel(page), page.read_text(encoding="utf-8")


def blog_posts(lang):
    """Built paths of the posts listed on a language's blog page."""
    return [rel(local(h)) for h, cls, _ in anchors(main(read(BLOGS[lang]))) if cls == "blog-title"]


def any_post():
    posts = blog_posts("en") + blog_posts("es")
    if not posts:
        raise AssertionError("the site has no blog posts in either language")
    return posts[0]


class SiteTest(unittest.TestCase):
    def assertCss(self, pattern, message):
        self.assertTrue(re.search(pattern, read("style.css")), message)


class Readability(SiteTest):
    def test_text_colors_clear_aa_on_page_background(self):
        css = read("style.css")
        colors = set(re.findall(r"(?<![\w-])color:\s*(#[0-9a-fA-F]{6}|#[0-9a-fA-F]{3})\b", css))
        failing = {c: round(contrast(c, PAGE_BG), 2) for c in colors if contrast(c, PAGE_BG) < 4.5}
        self.assertEqual(failing, {}, "text colors below 4.5:1 on the page background")

    def test_project_body_is_spaced_from_metadata(self):
        css = read("style.css")
        rule = re.search(r"\.project-body\{([^}]*)\}", css)
        self.assertIsNotNone(rule)
        margin = re.search(r"margin-top:\s*(\d+)px", rule.group(1))
        self.assertIsNotNone(margin, ".project-body has no margin-top")
        self.assertGreaterEqual(int(margin.group(1)), 24)


class ProjectMetadata(SiteTest):
    def test_languages_render_as_plain_text(self):
        html = read("projects/index.html")
        self.assertIn("Rust · Vue · TypeScript", project_row(html, "planificador"))
        self.assertNotRegex(html, r"tag-(lang|domain|status)")

    def test_production_status_is_implied(self):
        en = read("projects/index.html")
        es = read("es/projects/index.html")
        self.assertNotIn("Production", project_row(en, "planificador"))
        self.assertNotIn("Producción", project_row(es, "planificador"))
        self.assertIn("Archived", project_row(en, "engine"))
        self.assertIn("Archivado", project_row(es, "engine"))

    def test_detail_page_uses_the_same_metadata(self):
        html = read("projects/monarch/index.html")
        self.assertIn("Astro · Svelte · TypeScript · Tailwind", html)
        self.assertNotRegex(html, r"tag-(lang|domain|status)")
        self.assertNotIn("Production", html.split("project-body")[0])


def project_page(lang, slug):
    # Zola slugifies file names: school_roster.md is served at /projects/school-roster/
    return f"{'es/' if lang == 'es' else ''}projects/{slug.replace('_', '-')}/index.html"


class ProjectScreenshots(SiteTest):
    def images(self, path):
        return re.findall(r"<img\s([^>]*)>", main(read(path)))

    def test_featured_projects_show_a_screenshot(self):
        for lang in ("en", "es"):
            for slug in SCREENSHOTS:
                path = project_page(lang, slug)
                shots = self.images(path)
                self.assertEqual(len(shots), 1, f"{path} should show exactly one screenshot")
                src = attr(shots[0], "src")
                self.assertTrue(local(src).is_file(), f"{path}: {src} was not built")
                self.assertTrue((attr(shots[0], "alt") or "").strip(), f"{path}: screenshot has no alt text")
                self.assertTrue(attr(shots[0], "width") and attr(shots[0], "height"), f"{path}: size not declared")

    def test_alt_text_is_in_the_page_language(self):
        for slug in SCREENSHOTS:
            en = attr(self.images(project_page("en", slug))[0], "alt")
            es = attr(self.images(project_page("es", slug))[0], "alt")
            self.assertNotEqual(en, es, f"{slug}: both languages share the same alt text")

    def test_projects_without_a_picture_show_none(self):
        for slug in ("monarch", "arenzano", "sales_sim", "engine"):
            for lang in ("en", "es"):
                self.assertEqual(self.images(project_page(lang, slug)), [], f"{lang}/{slug}")

    def test_screenshots_are_light_enough_for_the_web(self):
        for slug in SCREENSHOTS:
            src = attr(self.images(project_page("en", slug))[0], "src")
            image = local(src)
            self.assertEqual(image.suffix, ".webp", rel(image))
            self.assertLess(image.stat().st_size, 400_000, f"{rel(image)} is over 400 KB")

    def test_screenshots_fit_narrow_screens(self):
        self.assertCss(r"\.project-shot\{[^}]*max-width:\s*100%", ".project-shot can overflow a phone screen")

    def test_listings_stay_text_only(self):
        for path in ("projects/index.html", "es/projects/index.html", "index.html", "es/index.html"):
            self.assertNotIn("<img", main(read(path)), path)


class ProjectPages(SiteTest):
    def test_no_project_has_a_development_process_section(self):
        for lang in ("en", "es"):
            for slug in (*SCREENSHOTS, "monarch", "arenzano", "sales_sim", "engine"):
                path = project_page(lang, slug)
                html = main(read(path))
                self.assertNotRegex(html, r"(?i)development process|proceso de desarrollo", path)
                self.assertNotRegex(html, r"(?i)generative AI|IA generativa|AI-assisted|asistencia de IA", path)


class SchoolRoster(SiteTest):
    def test_is_no_longer_open_source(self):
        for path in (project_page("en", "school_roster"), project_page("es", "school_roster")):
            html = read(path)
            self.assertNotIn("github.com/School-Roster", html, path)
            self.assertNotRegex(html, r"(?i)open source|código abierto", path)
            self.assertIn("Privado" if in_spanish(path) else "Private", html.split("project-body")[0], path)

    def test_announces_v2_as_coming_soon(self):
        self.assertRegex(main(read(project_page("en", "school_roster"))), r"(?i)v2\.0.*coming soon")
        self.assertRegex(main(read(project_page("es", "school_roster"))), r"(?i)v2\.0.*próximamente")

    def test_cv_does_not_call_it_open_source(self):
        for path in ("cv/index.html", "es/cv/index.html"):
            section = re.search(r"School Roster.*?(?=Sales Simulator|Simulador de Ventas)", read(path), re.S).group(0)
            self.assertNotRegex(section, r"(?i)open source|código abierto", path)


class Fluidity(SiteTest):
    def test_scrollbar_gutter_is_reserved(self):
        self.assertCss(r"html\{[^}]*scrollbar-gutter:\s*stable", "html does not reserve the scrollbar gutter")

    def test_page_transitions_respect_reduced_motion(self):
        self.assertCss(
            r"@media\s*\(prefers-reduced-motion:\s*no-preference\)\s*\{\s*@view-transition\s*\{\s*navigation:\s*auto",
            "no cross-page view transition gated on reduced motion",
        )

    def test_nav_stays_put_during_transitions(self):
        self.assertCss(r"\.site-nav\{[^}]*view-transition-name:\s*site-nav", ".site-nav has no view-transition-name")

    def test_every_page_prefetches_on_hover(self):
        for path, html in built_pages():
            script = re.search(r"<script type=[\"']?speculationrules[\"']?>(.*?)</script>", html, re.S)
            self.assertIsNotNone(script, f"{path} has no speculation rules")
            rules = json.loads(script.group(1))
            self.assertEqual(rules["prefetch"][0]["eagerness"], "moderate")


class Links(SiteTest):
    def test_linkedin_points_at_the_profile(self):
        html = read("index.html")
        self.assertIn("https://www.linkedin.com/in/awtgerry", html)
        self.assertNotIn("linkedin.com/in/https", html)

    def test_cv_link_opens_the_cv_page(self):
        for home, cv in (("index.html", "cv/index.html"), ("es/index.html", "es/cv/index.html")):
            href = next(h for h, _, text in anchors(nav(read(home))) if text == "CV")
            page = local(href)
            self.assertEqual(page, SITE / cv, f"{home}: CV goes to {href}")
            self.assertEqual(title(page.read_text(encoding="utf-8")), "CV · awtgerry")

    def test_cv_pdf_is_served(self):
        pdf = SITE / "cv.pdf"
        self.assertTrue(pdf.is_file(), "cv.pdf was not built")
        self.assertEqual(pdf.read_bytes()[:5], b"%PDF-", "cv.pdf is not a PDF")

    def test_cv_pages_offer_the_pdf_download(self):
        for path, label in (("cv/index.html", "Download PDF"), ("es/cv/index.html", "Descargar PDF")):
            links = [(h, text) for h, _, text in anchors(main(read(path))) if h.endswith("cv.pdf")]
            self.assertEqual(len(links), 1, f"{path} should link the PDF once")
            href, text = links[0]
            self.assertEqual(local(href), SITE / "cv.pdf", f"{path}: {href}")
            self.assertIn(label, text, path)

    def test_nav_marks_the_current_section(self):
        cases = {
            "index.html": [],
            "es/index.html": [],
            "projects/index.html": ["Projects"],
            "projects/monarch/index.html": ["Projects"],
            "es/projects/index.html": ["Proyectos"],
            "blog/index.html": ["Blog"],
            any_post(): ["Blog"],
            "cv/index.html": ["CV"],
            "es/cv/index.html": ["CV"],
        }
        for path, expected in cases.items():
            active = [text for _, cls, text in anchors(nav(read(path))) if cls and "active" in cls.split()]
            self.assertEqual(active, expected, path)

    def test_live_site_link_shows_without_a_public_repo(self):
        for path, url in LIVE_SITES.items():
            hrefs = [h for h, _, _ in anchors(read(path))]
            self.assertIn(url, hrefs, path)

    def test_live_sites_are_not_called_demos(self):
        for path, url in LIVE_SITES.items():
            label = next(text for h, _, text in anchors(main(read(path))) if h == url)
            expected = "Visitar sitio" if in_spanish(path) else "Visit site"
            self.assertIn(expected, label, path)
            self.assertNotRegex(main(read(path)), r"(?i)\bdemo\b", f"{path} still talks about a demo")

    def test_repo_link_names_its_host(self):
        def label(path, href):
            return next(text for h, _, text in anchors(read(path)) if h == href)

        self.assertIn("GitHub", label("projects/engine/index.html", "https://github.com/awtGerry/engine"))
        self.assertNotIn("GitHub", label("projects/embedded-iot/index.html", "https://gitea.com/awtgerry/embedded-iot"))

    def test_feeds_carry_that_languages_posts(self):
        for lang in ("en", "es"):
            feed_path = SITE / ("es/" if lang == "es" else "") / "blog" / "rss.xml"
            for path in (HOMES[lang], BLOGS[lang]):
                feeds = re.findall(r"href=[\"']?([^\"'\s>]+\.xml)", read(path))
                self.assertEqual({local(h) for h in feeds}, {feed_path}, path)
            self.assertTrue(feed_path.exists(), f"{rel(feed_path)} was not built")
            feed = feed_path.read_text(encoding="utf-8")
            for post in blog_posts(lang):
                self.assertIn(heading(read(post)), feed, f"{rel(feed_path)} is missing {post}")
            self.assertNotIn("/projects/", feed, f"{rel(feed_path)} lists projects")

    def test_titles_name_the_page(self):
        cases = {
            "index.html": "awtgerry",
            "es/index.html": "awtgerry",
            "projects/index.html": "Projects · awtgerry",
            "es/projects/index.html": "Proyectos · awtgerry",
            "projects/monarch/index.html": "Monarch Beauty Lab · awtgerry",
        }
        for path, expected in cases.items():
            self.assertEqual(title(read(path)), expected, path)
        post = read(any_post())
        self.assertEqual(title(post), f"{heading(post)} · awtgerry")

    def test_404_offers_a_way_back(self):
        html = read("404.html")
        self.assertIn("site-nav", html)
        hrefs = [h for h, _, _ in anchors(main(html))]
        self.assertTrue(any(local(h) == SITE / "index.html" for h in hrefs), "404 has no link home")

    def test_posts_without_a_description_leave_no_empty_excerpt(self):
        for path in (*HOMES.values(), *BLOGS.values()):
            self.assertNotRegex(read(path), r"class=[\"']?blog-excerpt[\"']?>\s*(<|$)", path)

    def test_internal_links_resolve(self):
        for path, html in built_pages():
            for href, _, _ in anchors(html):
                if href.startswith(("mailto:", "http://", "https://")) and not href.startswith(BASE_URL):
                    continue
                self.assertTrue(local(href).exists(), f"{path}: {href} is a dead link")


class Languages(SiteTest):
    def test_every_page_declares_its_language(self):
        for path, html in built_pages():
            expected = "es" if in_spanish(path) else "en"
            self.assertRegex(html, rf"<html lang=[\"']?{expected}\b", path)

    def test_nav_stays_in_the_page_language(self):
        for path, html in built_pages():
            links = anchors(nav(html))
            self.assertIn("Proyectos" if in_spanish(path) else "Projects", [text for _, _, text in links], path)
            for href, cls, _ in links:
                if cls and "lang-switch" in cls.split():
                    continue
                self.assertEqual(in_spanish(rel(local(href))), in_spanish(path), f"{path}: nav link {href} changes language")

    def test_language_switch_opens_the_translation(self):
        cases = {
            "index.html": "es/index.html",
            "es/index.html": "index.html",
            "projects/index.html": "es/projects/index.html",
            "projects/monarch/index.html": "es/projects/monarch/index.html",
            "es/projects/monarch/index.html": "projects/monarch/index.html",
            "blog/index.html": "es/blog/index.html",
            "es/cv/index.html": "cv/index.html",
        }
        for path, expected in cases.items():
            self.assertEqual(local(lang_switch(read(path))), SITE / expected, path)

    def test_language_switch_always_lands_in_the_other_language(self):
        for path, html in built_pages():
            target = local(lang_switch(html))
            self.assertTrue(target.exists(), f"{path}: switch goes to missing {rel(target)}")
            self.assertNotEqual(in_spanish(rel(target)), in_spanish(path), f"{path}: switch stays in the same language")

    def test_spanish_dates_are_in_spanish(self):
        english_month = r"\b(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\b"
        stamps = 0
        for path, html in built_pages():
            if not in_spanish(path):
                continue
            for stamp in re.findall(r"<time[^>]*>(.*?)</time>", html, re.S):
                stamps += 1
                self.assertNotRegex(stamp, english_month, path)
        if blog_posts("es"):
            self.assertGreater(stamps, 0, "Spanish posts exist but no Spanish page shows a date")

    def test_spanish_home_shows_spanish_work(self):
        projects = [h for h, cls, _ in anchors(read("es/index.html")) if cls == "project-name"]
        self.assertEqual(len(projects), 3)
        for href in projects:
            self.assertTrue(in_spanish(rel(local(href))), href)

    def test_home_shows_writing_only_when_there_are_posts(self):
        for lang, home in HOMES.items():
            shows_writing = "blog-preview" in read(home)
            self.assertEqual(shows_writing, bool(blog_posts(lang)), home)

    def test_empty_blog_points_to_the_other_language(self):
        for lang, blog in BLOGS.items():
            if blog_posts(lang):
                continue
            other = BLOGS["es" if lang == "en" else "en"]
            targets = [local(h) for h, _, _ in anchors(main(read(blog))) if h.startswith(BASE_URL)]
            self.assertIn(SITE / other, targets, f"{blog} has no posts and no way to the other language's")


if __name__ == "__main__":
    unittest.main()
