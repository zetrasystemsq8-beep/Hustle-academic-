/// The JavaScript instrumentation injected into the live preview when
/// DevTools mode is active. It never runs in the normal Preview screen,
/// the split-view editor preview, or a published site — only inside
/// [DevToolsScreen] — since it adds real overhead (a MutationObserver,
/// fetch/XHR wrapping) that a student's actual site shouldn't pay for.
///
/// Everything here observes and reports; it never alters what the
/// student's HTML/CSS/JS actually does, and it never generates or
/// suggests code — only facts about what's currently running.
class DevToolsInstrumentation {
  DevToolsInstrumentation._();

  static const String script = '''
(function () {
  if (window.__weblabDevToolsInstalled) return;
  window.__weblabDevToolsInstalled = true;

  var nextId = 1;
  function assignIds(root) {
    var walker = document.createTreeWalker(root, NodeFilter.SHOW_ELEMENT, null, false);
    var node = root.nodeType === 1 ? root : walker.nextNode();
    while (node) {
      if (!node.getAttribute('data-weblab-id')) {
        node.setAttribute('data-weblab-id', 'wl' + (nextId++));
      }
      node = walker.nextNode();
    }
  }

  function serialize(node, depth, budget) {
    if (!node || depth > 8 || budget.count > 500) return null;
    budget.count++;

    var attrs = {};
    for (var i = 0; i < node.attributes.length; i++) {
      var a = node.attributes[i];
      if (a.name !== 'data-weblab-id') attrs[a.name] = a.value;
    }

    var directText = '';
    for (var j = 0; j < node.childNodes.length; j++) {
      var child = node.childNodes[j];
      if (child.nodeType === 3) directText += child.textContent;
    }
    directText = directText.trim().slice ? directText.trim().substring(0, 80) : directText.substring(0, 80);

    var children = [];
    for (var k = 0; k < node.children.length; k++) {
      var serialized = serialize(node.children[k], depth + 1, budget);
      if (serialized) children.push(serialized);
    }

    return {
      weblabId: node.getAttribute('data-weblab-id'),
      tag: node.tagName.toLowerCase(),
      attrs: attrs,
      text: directText,
      children: children
    };
  }

  function postToFlutter(payload) {
    try {
      if (window.WebLabDevTools) {
        window.WebLabDevTools.postMessage(JSON.stringify(payload));
      }
    } catch (e) {}
  }

  function sendDomSnapshot() {
    assignIds(document.body);
    var tree = serialize(document.body, 0, { count: 0 });
    postToFlutter({ type: 'dom_snapshot', tree: tree });
  }

  window.__weblabGetComputedStyle = function (weblabId) {
    var el = document.querySelector('[data-weblab-id="' + weblabId + '"]');
    if (!el) return JSON.stringify({});
    var cs = window.getComputedStyle(el);
    var props = ['display', 'position', 'color', 'background-color', 'width', 'height',
      'margin', 'padding', 'font-size', 'font-family', 'font-weight', 'border',
      'border-radius', 'flex-direction', 'justify-content', 'align-items',
      'text-align', 'opacity', 'z-index', 'overflow'];
    var result = {};
    for (var i = 0; i < props.length; i++) {
      result[props[i]] = cs.getPropertyValue(props[i]);
    }
    return JSON.stringify(result);
  };

  function sendStorageSnapshot() {
    var local = {};
    for (var i = 0; i < localStorage.length; i++) {
      var k = localStorage.key(i);
      local[k] = localStorage.getItem(k);
    }
    var session = {};
    for (var j = 0; j < sessionStorage.length; j++) {
      var sk = sessionStorage.key(j);
      session[sk] = sessionStorage.getItem(sk);
    }
    postToFlutter({ type: 'storage_snapshot', local: local, session: session, cookies: document.cookie });
  }
  window.__weblabRefreshStorage = sendStorageSnapshot;

  var originalFetch = window.fetch;
  if (originalFetch) {
    window.fetch = function (input, init) {
      var start = Date.now();
      var url = typeof input === 'string' ? input : (input && input.url) || '';
      var method = (init && init.method) || 'GET';
      return originalFetch.apply(this, arguments).then(function (response) {
        postToFlutter({
          type: 'network_request', requestType: 'fetch', method: method, url: url,
          status: response.status, durationMs: Date.now() - start, failed: !response.ok
        });
        return response;
      }).catch(function (err) {
        postToFlutter({
          type: 'network_request', requestType: 'fetch', method: method, url: url,
          status: null, durationMs: Date.now() - start, failed: true
        });
        throw err;
      });
    };
  }

  var OriginalXHR = window.XMLHttpRequest;
  if (OriginalXHR) {
    window.XMLHttpRequest = function () {
      var xhr = new OriginalXHR();
      var method = 'GET', url = '', start;
      var originalOpen = xhr.open;
      xhr.open = function (m, u) {
        method = m; url = u; start = Date.now();
        return originalOpen.apply(xhr, arguments);
      };
      xhr.addEventListener('loadend', function () {
        postToFlutter({
          type: 'network_request', requestType: 'xhr', method: method, url: url,
          status: xhr.status, durationMs: Date.now() - (start || Date.now()), failed: xhr.status >= 400 || xhr.status === 0
        });
      });
      return xhr;
    };
  }

  var debounceTimer = null;
  var observer = new MutationObserver(function () {
    if (debounceTimer) clearTimeout(debounceTimer);
    debounceTimer = setTimeout(sendDomSnapshot, 300);
  });

  function start() {
    sendDomSnapshot();
    sendStorageSnapshot();
    observer.observe(document.body, { childList: true, subtree: true, attributes: true, characterData: true });
    window.addEventListener('storage', sendStorageSnapshot);
  }

  if (document.readyState === 'complete' || document.readyState === 'interactive') {
    start();
  } else {
    document.addEventListener('DOMContentLoaded', start);
  }
})();
''';
}
