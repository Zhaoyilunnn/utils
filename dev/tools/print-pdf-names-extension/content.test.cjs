const { test } = require('node:test');
const assert = require('node:assert/strict');
const { readFileSync } = require('node:fs');
const { runInNewContext } = require('node:vm');
const source = readFileSync(`${__dirname}/content.js`, 'utf8');
function page(title) {
  const listeners = new Map();
  const document = { title };
  const RealDate = Date;
  class FixedDate extends RealDate {
    constructor(...args) { super(...(args.length ? args : [2026, 10, 7, 12])); }
  }
  runInNewContext(source, { document, Date: FixedDate, TextEncoder,
    window: { addEventListener(name, fn) { listeners.set(name, fn); } } });
  return { document, emit: (name, event) => listeners.get(name)(event) };
}
for (const [input, expected] of [
  ['My_Page: Title', '2026-11-07-My-Page-Title'],
  ['量子计算（终稿）', '2026-11-07-量子计算-终稿'],
  ['2025-02-28-report', '2025-02-28-report'],
  ['2025-02-28-2026-01-01-report', '2025-02-28-report'],
  ['report.pdf', '2026-11-07-report'],
  ['', '2026-11-07-page'],
  ['2026-02-30-report', '2026-11-07-2026-02-30-report'],
]) {
  test(`Ctrl+P: ${input}`, () => {
    const p = page(input);
    p.emit('keydown', { key: 'p', ctrlKey: true });
    assert.equal(p.document.title, expected);
    p.emit('beforeprint');
    assert.equal(p.document.title, expected);
    p.emit('afterprint');
    assert.equal(p.document.title, input);
    p.emit('beforeprint'); p.emit('afterprint');
    assert.equal(p.document.title, input);
  });
}
test('Unrelated shortcuts do not change title', () => {
  const p = page('Original');
  for (const event of [{ key: 'p' }, { key: 'p', ctrlKey: true, shiftKey: true },
    { key: 'p', ctrlKey: true, defaultPrevented: true }, { key: 'x', ctrlKey: true }]) p.emit('keydown', event);
  assert.equal(p.document.title, 'Original');
});
test('Native beforeprint fallback, cancel/close restoration, no clobber of website update', () => {
  const p = page('Original');
  p.emit('beforeprint');
  assert.equal(p.document.title, '2026-11-07-Original');
  p.document.title = 'Updated by website';
  p.emit('afterprint');
  assert.equal(p.document.title, 'Updated by website');
  p.emit('beforeprint'); p.emit('pagehide');
  assert.equal(p.document.title, 'Updated by website');
});
test('Long Unicode titles fit filename limit', () => {
  const p = page('量子'.repeat(300));
  p.emit('beforeprint');
  assert.ok(new TextEncoder().encode(p.document.title + '.pdf').length <= 180);
});
