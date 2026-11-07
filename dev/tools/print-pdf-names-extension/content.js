(() => {
  'use strict';
  let session = null;

  function normalizedTitle(title) {
    const now = new Date();
    let date = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;
    let stem = title.normalize('NFC').trim().replace(/\.pdf$/iu, '');
    let firstDate = null;
    let match;
    while ((match = /^(\d{4}-\d{2}-\d{2})-/u.exec(stem))) {
      const parsed = new Date(`${match[1]}T00:00:00Z`);
      if (!Number.isFinite(parsed.getTime()) || parsed.toISOString().slice(0, 10) !== match[1]) break;
      firstDate ??= match[1];
      stem = stem.slice(match[0].length);
    }
    date = firstDate ?? date;
    stem = stem.replace(/[^\p{L}\p{Nd}.-]+/gu, '-')
      .replace(/[.-]{2,}/gu, '-').replace(/^[.-]+|[.-]+$/gu, '') || 'page';
    const chars = Array.from(stem);
    const encoder = new TextEncoder();
    while (encoder.encode(`${date}-${chars.join('')}.pdf`).length > 180) chars.pop();
    return `${date}-${chars.join('').replace(/[.-]+$/u, '') || 'page'}`;
  }

  function prepare() {
    if (session !== null) return;
    const original = document.title;
    const suggested = normalizedTitle(original);
    session = { original, suggested };
    document.title = suggested;
  }

  function restore() {
    if (session === null) return;
    // Do not overwrite a newer title set by the website during printing.
    if (document.title === session.suggested) document.title = session.original;
    session = null;
  }

  // Set the title before the native shortcut starts print preview. Do not
  // preventDefault, replace window.print, or open another print dialog.
  window.addEventListener('keydown', (event) => {
    if (event.key.toLowerCase() === 'p' && (event.ctrlKey || event.metaKey) &&
        !event.altKey && !event.shiftKey && !event.defaultPrevented) prepare();
  }, true);
  // Fallback for native print entry points and repeated print preview events.
  window.addEventListener('beforeprint', prepare);
  window.addEventListener('afterprint', restore);
  window.addEventListener('pagehide', restore);
})();
