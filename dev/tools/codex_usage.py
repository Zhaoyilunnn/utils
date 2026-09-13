#!/usr/bin/env python3
"""Read recorded per-session Codex token counters without modifying the database."""
import argparse
from contextlib import closing
from datetime import datetime
import json
import os
from pathlib import Path
import re
import sqlite3
import sys


def find_database(home):
    candidates = []
    for path in home.glob('state_*.sqlite'):
        match = re.fullmatch(r'state_(\d+)\.sqlite', path.name)
        if match and path.is_file():
            candidates.append((int(match[1]), path))
    if not candidates:
        raise ValueError(f'No state_*.sqlite database found in {home}')
    return max(candidates)[1]


def read_sessions(database, limit=20, cwd=None, session=None):
    with closing(sqlite3.connect(database.resolve().as_uri() + '?mode=ro', uri=True)) as conn:
        conn.execute('PRAGMA query_only = ON')
        columns = {row[1] for row in conn.execute('PRAGMA table_info(threads)')}
        required = {'id', 'updated_at', 'tokens_used', 'cwd'}
        if not required <= columns:
            raise ValueError('Unsupported Codex database schema; missing: ' +
                             ', '.join(sorted(required - columns)))
        filters, values = [], []
        if cwd is not None:
            filters.append('cwd = ?')
            values.append(cwd)
        if session is not None:
            filters.append('id = ?')
            values.append(session)
        sql = 'SELECT id, updated_at, tokens_used, cwd FROM threads'
        if filters:
            sql += ' WHERE ' + ' AND '.join(filters)
        sql += ' ORDER BY updated_at DESC, id'
        if limit:
            sql += ' LIMIT ?'
            values.append(limit)
        return [dict(zip(('id', 'updated_at', 'tokens_used', 'cwd'), row))
                for row in conn.execute(sql, values)]


def nonnegative(value):
    number = int(value)
    if number < 0:
        raise argparse.ArgumentTypeError('must be zero or greater')
    return number


def format_tokens(value, human=False):
    if value is None:
        return 'unknown'
    if human:
        for scale, unit in ((10**12, 'Trillion'), (10**9, 'Billion'),
                            (10**6, 'Million'), (10**3, 'Thousand')):
            if abs(value) >= scale:
                return f'{value / scale:.2f} {unit}'
    return f'{value:,}'


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, add_help=False)
    parser.add_argument('--help', action='help', help='Show this help message and exit')
    parser.add_argument('-h', '--human-readable', action='store_true',
                        help='Display decimal Thousand, Million, Billion and Trillion units')
    parser.add_argument('--codex-home', type=Path,
                        default=Path(os.environ.get('CODEX_HOME', '~/.codex')).expanduser(),
                        help='Codex data directory (default: CODEX_HOME or ~/.codex)')
    parser.add_argument('--db', type=Path, help='Explicit state SQLite database')
    parser.add_argument('--limit', type=nonnegative, default=20,
                        help='Number of sessions, newest first; 0 means all (default: 20)')
    parser.add_argument('--cwd', help='Exact recorded project directory (not a prefix match)')
    parser.add_argument('--session', help='Exact session ID')
    parser.add_argument('--json', action='store_true', help='Print structured JSON')
    args = parser.parse_args(argv)
    try:
        database = args.db.expanduser() if args.db else find_database(args.codex_home.expanduser())
        all_rows = read_sessions(database, 0, args.cwd, args.session)
        rows = all_rows[:args.limit] if args.limit else all_rows
        total = sum(row['tokens_used'] for row in all_rows if row['tokens_used'] is not None)
        unknown = sum(row['tokens_used'] is None for row in all_rows)
        note = ('Local recorded session counters, including archived sessions when present. '
                'Total sums recorded counters and may overlap across forked sessions. '
                'Not daily usage or an account billing total. Zero may mean unrecorded usage. '
                'Updated time is session activity time, not token consumption time.')
        if args.json:
            print(json.dumps({'database': str(database.resolve()), 'note': note,
                              'count': len(rows), 'matched_count': len(all_rows),
                              'total_tokens': total, 'unknown_count': unknown,
                              'sessions': rows}, ensure_ascii=False, indent=2))
        else:
            print('Last updated (local)       Recorded tokens  Session ID                            Project')
            for row in rows:
                when = datetime.fromtimestamp(row['updated_at']).astimezone().strftime('%Y-%m-%d %H:%M:%S%z')
                tokens = format_tokens(row['tokens_used'], args.human_readable)
                # Escape control characters from paths to keep terminal output safe.
                project = json.dumps(row['cwd'], ensure_ascii=False)
                print(f"{when}  {tokens:>15}  {row['id']}  {project}")
            print(f'\nTotal tokens: {format_tokens(total, args.human_readable)} '
                  f'(all {len(all_rows)} matching sessions; {unknown} unknown)')
            print(f'{len(rows)} session(s) shown. {note}')
        return 0
    except (OSError, sqlite3.Error, ValueError, OverflowError) as exc:
        print(f'codex-usage: {exc}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    sys.exit(main())
