"""Offline checks for filtering, database discovery and read-only behavior."""
import io
import json
from contextlib import redirect_stdout
import sqlite3
import tempfile
import unittest
from pathlib import Path
from codex_usage import find_database, read_sessions, format_tokens, main


class UsageTests(unittest.TestCase):
    def test_human_units(self):
        for value, expected in [(None, 'unknown'), (999, '999'),
                                (1000, '1.00 Thousand'), (1250000, '1.25 Million'),
                                (2500000000, '2.50 Billion'), (10**12, '1.00 Trillion')]:
            self.assertEqual(format_tokens(value, True), expected)
        self.assertEqual(format_tokens(1250000), '1,250,000')

    def test_total_ignores_display_limit_and_preserves_json_integers(self):
        with tempfile.TemporaryDirectory() as tmp:
            db = Path(tmp) / 'state_5.sqlite'
            with sqlite3.connect(db) as conn:
                conn.execute('CREATE TABLE threads (id TEXT, updated_at INTEGER, tokens_used INTEGER, cwd TEXT)')
                conn.executemany('INSERT INTO threads VALUES (?, ?, ?, ?)',
                                 [('a', 10, 1250000, '/p'), ('b', 20, 2500000, '/p'),
                                  ('c', 30, None, '/p'), ('d', 40, 999, '/other')])
            for cwd, total, count, unknown in [('/p', 3750000, 3, 1), ('/missing', 0, 0, 0)]:
                output = io.StringIO()
                with redirect_stdout(output):
                    result = main(['--db', str(db), '--cwd', cwd, '--limit', '1', '-h', '--json'])
                self.assertEqual(result, 0)
                data = json.loads(output.getvalue())
                self.assertEqual(data['total_tokens'], total)
                self.assertEqual(data['matched_count'], count)
                self.assertEqual(data['unknown_count'], unknown)
                self.assertEqual(data['count'], min(1, count))

    def test_discovery_uses_numeric_version(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            for name in ('state_9.sqlite', 'state_10.sqlite', 'state_old.sqlite'):
                (root / name).touch()
            self.assertEqual(find_database(root).name, 'state_10.sqlite')

    def test_read_filter_limit_and_unchanged_database(self):
        with tempfile.TemporaryDirectory() as tmp:
            db = Path(tmp) / 'state_5.sqlite'
            with sqlite3.connect(db) as conn:
                conn.execute('CREATE TABLE threads (id TEXT, updated_at INTEGER, tokens_used INTEGER, cwd TEXT)')
                conn.executemany('INSERT INTO threads VALUES (?, ?, ?, ?)',
                                 [('a', 10, 100, '/project'), ('b', 20, 200, '/project/sub'),
                                  ('c', 30, 0, '/project')])
            before = db.read_bytes()
            self.assertEqual([r['id'] for r in read_sessions(db, 1)], ['c'])
            self.assertEqual([r['id'] for r in read_sessions(db, 0, '/project')], ['c', 'a'])
            self.assertEqual(read_sessions(db, 0, session='b')[0]['tokens_used'], 200)
            self.assertEqual(read_sessions(db, 0, cwd="' OR 1=1 --"), [])
            self.assertEqual(db.read_bytes(), before)

    def test_missing_database_is_not_created(self):
        with tempfile.TemporaryDirectory() as tmp:
            db = Path(tmp) / 'missing.sqlite'
            with self.assertRaises(sqlite3.OperationalError):
                read_sessions(db)
            self.assertFalse(db.exists())

    def test_unknown_schema_fails_clearly(self):
        with tempfile.TemporaryDirectory() as tmp:
            db = Path(tmp) / 'unknown.sqlite'
            sqlite3.connect(db).close()
            with self.assertRaisesRegex(ValueError, 'Unsupported'):
                read_sessions(db)


if __name__ == '__main__':
    unittest.main()
