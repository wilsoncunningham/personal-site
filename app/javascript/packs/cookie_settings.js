document.addEventListener('DOMContentLoaded', () => {
  const statusEl = document.getElementById('current-status');
  const grantBtn = document.getElementById('grant-consent');
  const withdrawBtn = document.getElementById('withdraw-consent');

  // Use localStorage to track consent: 'granted' or 'withdrawn'
  function getConsent() {
    return localStorage.getItem('cookie_consent') || 'unknown';
  }
  function setConsent(value) {
    localStorage.setItem('cookie_consent', value);
  }
  function updateStatus() {
    const state = getConsent();
    statusEl.textContent =
      state === 'granted'
        ? 'Analytics cookies are currently ENABLED.'
        : state === 'withdrawn'
          ? 'Analytics cookies are currently DISABLED.'
          : 'You have not set a preference yet.';
  }

  grantBtn.addEventListener('click', () => {
    setConsent('granted');
    // Optionally reload or re-init GA here
    if (window.gtag) {
      gtag('consent', 'update', { 'analytics_storage': 'granted' });
    }
    updateStatus();
    alert('Analytics consent granted.');
  });

  withdrawBtn.addEventListener('click', () => {
    setConsent('withdrawn');
    // Remove GA cookies
    document.cookie.split(';').forEach(cookie => {
      const name = cookie.split('=')[0].trim();
      if (name.startsWith('_ga')) {
        document.cookie = name + '=; Max-Age=0; path=/;';
      }
    });
    if (window.gtag) {
      gtag('consent', 'update', { 'analytics_storage': 'denied' });
    }
    updateStatus();
    alert('Analytics consent withdrawn.');
  });

  updateStatus();
});
