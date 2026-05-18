class BDMSUI {
  init() {
    this.setupMenu();
    this.setupSidebarDrawer();
    this.setupLinkStates();
    this.setupCounters();
    this.setupFormValidation();
    this.setupPasswordStrength();
    this.setupPasswordToggle();
    this.setupSubmitLoading();
  }

  setupMenu() {
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    if (!hamburger || !navLinks) return;

    hamburger.addEventListener('click', () => {
      const isOpen = navLinks.classList.toggle('open');
      hamburger.classList.toggle('open', isOpen);
      hamburger.setAttribute('aria-expanded', String(isOpen));
    });

    navLinks.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        if (window.innerWidth <= 768) {
          navLinks.classList.remove('open');
          hamburger.classList.remove('open');
          hamburger.setAttribute('aria-expanded', 'false');
        }
      });
    });

    window.addEventListener('resize', () => {
      if (window.innerWidth > 768) {
        navLinks.classList.remove('open');
        hamburger.classList.remove('open');
        hamburger.setAttribute('aria-expanded', 'false');
      }
    });
  }

setupSidebarDrawer() {
    const navbar = document.querySelector('.navbar');
    const sidebar = document.querySelector('.sidebar');
    if (!navbar || !sidebar) return;

    const navLinks = navbar.querySelector('.nav-links') || navbar;
    let toggle = navLinks.querySelector('.sidebar-toggle');
    if (toggle) toggle.remove();

    // Create or find the sidebar toggle button
    toggle = document.createElement('button');
    toggle.type = 'button';
    toggle.className = 'sidebar-toggle';
    toggle.setAttribute('aria-label', 'Toggle sidebar');
    toggle.innerHTML = '<i class="fa-solid fa-bars-staggered"></i>';
    toggle.style.display = 'none'; // Hidden by default, shown on mobile
    navLinks.insertBefore(toggle, navLinks.firstChild);

    let overlay = document.querySelector('.sidebar-overlay');
    if (!overlay) {
      overlay = document.createElement('div');
      overlay.className = 'sidebar-overlay';
      document.body.appendChild(overlay);
    }

    const openSidebar = () => { 
      sidebar.classList.add('open'); 
      overlay.classList.add('active'); 
      document.body.style.overflow = 'hidden';
    };
    const closeSidebar = () => { 
      sidebar.classList.remove('open'); 
      overlay.classList.remove('active'); 
      document.body.style.overflow = '';
    };

    toggle.addEventListener('click', () => { sidebar.classList.contains('open') ? closeSidebar() : openSidebar(); });
    overlay.addEventListener('click', closeSidebar);

    // Show toggle button on mobile and handle resize
    const handleResize = () => {
      if (window.innerWidth <= 900) {
        toggle.style.display = 'flex';
      } else {
        toggle.style.display = 'none';
        closeSidebar();
      }
    };
    
    window.addEventListener('resize', handleResize);
    handleResize(); // Initial check
  }

setupLinkStates() {
    const currentPath = window.location.pathname.replace(/\/$/, '');
    // First, remove any stale active classes from all navigation links to prevent "sticky" highlighting
    document.querySelectorAll('.nav-links a, .sidebar-link').forEach(link => {
      link.classList.remove('active', 'nav-active');
    });
    // Then highlight the current page link
    document.querySelectorAll('.nav-links a, .sidebar-link').forEach(link => {
      const href = link.getAttribute('href');
      if (!href || href.startsWith('javascript:')) return;
      try {
        const url = new URL(href, window.location.origin);
        const linkPath = url.pathname.replace(/\/$/, '');
        if (linkPath === currentPath || (currentPath === '' && linkPath === '')) {
          link.classList.add('active', 'nav-active');
        }
      } catch (_error) {}
    });
  }

  setupCounters() {
    const counters = document.querySelectorAll('[data-target]');
    if (!counters.length) return;
    const observer = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) return;
        const el = entry.target;
        const target = Number(el.dataset.target || '0');
        const suffix = el.dataset.suffix || '';
        const duration = 900;
        const start = performance.now();
        const tick = now => {
          const progress = Math.min((now - start) / duration, 1);
          const value = Math.floor(target * (1 - Math.pow(1 - progress, 3)));
          el.textContent = `${value.toLocaleString()}${suffix}`;
          if (progress < 1) requestAnimationFrame(tick);
        };
        requestAnimationFrame(tick);
        observer.unobserve(el);
      });
    }, { threshold: 0.35 });
    counters.forEach(counter => observer.observe(counter));
  }

  setupFormValidation() {
    const showError = (input, msg) => {
      const group = input.closest('.form-group') || input.parentElement;
      let hint = group.querySelector('.form-hint');
      if (!hint) { hint = document.createElement('div'); hint.className = 'form-hint'; group.appendChild(hint); }
      hint.textContent = msg; hint.classList.add('error');
      input.classList.add('is-invalid'); input.classList.remove('is-valid');
    };
    const clearError = (input) => {
      const group = input.closest('.form-group') || input.parentElement;
      const hint = group.querySelector('.form-hint');
      if (hint) { hint.textContent = ''; hint.classList.remove('error'); }
      input.classList.remove('is-invalid'); input.classList.add('is-valid');
    };
    const clearAll = (form) => {
      form.querySelectorAll('.form-control').forEach(input => {
        input.classList.remove('is-invalid', 'is-valid');
        const group = input.closest('.form-group') || input.parentElement;
        const hint = group.querySelector('.form-hint');
        if (hint) { hint.textContent = ''; hint.classList.remove('error'); }
      });
    };

    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
      registerForm.addEventListener('submit', (e) => {
        clearAll(registerForm); let valid = true;
        const fullName = registerForm.querySelector('[name="fullName"]');
        const email = registerForm.querySelector('[name="email"]');
        const phone = registerForm.querySelector('[name="phone"]');
        const dob = registerForm.querySelector('[name="dob"]');
        const bloodType = registerForm.querySelector('[name="bloodType"]');
        const password = registerForm.querySelector('[name="password"]');
        const confirmPassword = registerForm.querySelector('[name="confirmPassword"]');

        if (fullName && fullName.value.trim().length < 2) { showError(fullName, 'Full name must be at least 2 characters.'); valid = false; } else if (fullName) clearError(fullName);
        const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email && !emailRe.test(email.value.trim())) { showError(email, 'Please enter a valid email address.'); valid = false; } else if (email) clearError(email);
        const phoneRe = /^\d{10}$/;
        if (phone && !phoneRe.test(phone.value.trim())) { showError(phone, 'Phone must be exactly 10 digits.'); valid = false; } else if (phone) clearError(phone);
        if (dob && dob.value) { const age = new Date().getFullYear() - new Date(dob.value).getFullYear(); if (age < 18) { showError(dob, 'You must be at least 18 years old.'); valid = false; } else clearError(dob); }
        if (bloodType && !bloodType.value) { showError(bloodType, 'Please select a blood type.'); valid = false; } else if (bloodType) clearError(bloodType);
        if (password && password.value.length < 8) { showError(password, 'Password must be at least 8 characters.'); valid = false; } else if (password) clearError(password);
        if (confirmPassword && confirmPassword.value !== (password ? password.value : '')) { showError(confirmPassword, 'Passwords do not match.'); valid = false; } else if (confirmPassword) clearError(confirmPassword);

        if (!valid) e.preventDefault();
      });
    }

    const loginForm = document.querySelector('form[action$="/login"]');
    if (loginForm) {
      loginForm.addEventListener('submit', (e) => {
        clearAll(loginForm); let valid = true;
        const email = loginForm.querySelector('[name="email"]');
        const password = loginForm.querySelector('[name="password"]');
        const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email && !emailRe.test(email.value.trim())) { showError(email, 'Please enter a valid email address.'); valid = false; } else if (email) clearError(email);
        if (password && !password.value.trim()) { showError(password, 'Password is required.'); valid = false; } else if (password) clearError(password);
        if (!valid) e.preventDefault();
      });
    }

    const requestForm = document.getElementById('requestForm');
    if (requestForm) {
      requestForm.addEventListener('submit', (e) => {
        clearAll(requestForm); let valid = true;
        const fields = ['patientName', 'hospitalName', 'bloodTypeNeeded', 'unitsRequired', 'urgencyLevel', 'reason'];
        fields.forEach(name => {
          const input = requestForm.querySelector(`[name="${name}"]`);
          if (input && !input.value.trim()) { showError(input, 'This field is required.'); valid = false; }
          else if (input) clearError(input);
        });
        const units = requestForm.querySelector('[name="unitsRequired"]');
        if (units && Number(units.value) <= 0) { showError(units, 'Units must be greater than 0.'); valid = false; }
        if (!valid) e.preventDefault();
      });
    }
  }

  setupPasswordStrength() {
    const password = document.querySelector('#registerForm input[name="password"]');
    if (!password) return;

    const bar = document.createElement('div');
    bar.className = 'pw-strength-bar';
    const fill = document.createElement('div');
    fill.className = 'pw-strength-fill';
    bar.appendChild(fill);
    const label = document.createElement('div');
    label.className = 'pw-strength-label';
    label.style.marginTop = '0.25rem';

    const group = password.closest('.form-group');
    group.appendChild(bar);
    group.appendChild(label);

    const score = (val) => {
      let s = 0;
      if (val.length >= 8) s++;
      if (/[A-Z]/.test(val)) s++;
      if (/\d/.test(val)) s++;
      if (/[^A-Za-z0-9]/.test(val)) s++;
      return s;
    };

    password.addEventListener('input', () => {
      const s = score(password.value);
      const levels = ['weak', 'fair', 'good', 'strong'];
      fill.className = 'pw-strength-fill';
      label.className = 'pw-strength-label';
      if (password.value.length > 0) {
        fill.classList.add(levels[Math.min(s, 3)]);
        label.classList.add(levels[Math.min(s, 3)]);
        const texts = ['Weak', 'Fair', 'Good', 'Strong'];
        label.textContent = texts[Math.min(s, 3)];
      } else {
        label.textContent = '';
      }
    });
  }

  setupPasswordToggle() {
    document.querySelectorAll('input[type="password"]').forEach(input => {
      const wrap = document.createElement('div');
      wrap.className = 'input-wrap';
      input.parentElement.insertBefore(wrap, input);
      wrap.appendChild(input);

      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'input-action';
      btn.setAttribute('data-pw-toggle', '');
      btn.setAttribute('aria-label', 'Toggle password visibility');
      btn.innerHTML = '<i class="fa-solid fa-eye"></i>';
      wrap.appendChild(btn);

      btn.addEventListener('click', () => {
        const isHidden = input.type === 'password';
        input.type = isHidden ? 'text' : 'password';
        btn.innerHTML = isHidden ? '<i class="fa-solid fa-eye-slash"></i>' : '<i class="fa-solid fa-eye"></i>';
      });
    });
  }

  setupSubmitLoading() {
    document.querySelectorAll('form').forEach(form => {
      form.addEventListener('submit', (e) => {
        const btn = form.querySelector('button[type="submit"], input[type="submit"]');
        if (!btn) return;
        if (form.querySelector('.is-invalid')) {
          e.preventDefault();
          return;
        }
        btn.classList.add('loading');
        btn.disabled = true;
      });
    });
  }
}

/* Global Toast API */
window.bdmsToast = {
  _ensureContainer() {
    let container = document.getElementById('toastContainer');
    if (!container) {
      container = document.createElement('div');
      container.id = 'toastContainer';
      container.className = 'toast-container';
      document.body.appendChild(container);
    }
    return container;
  },
  _icon(type) {
    const map = { success: 'fa-circle-check', error: 'fa-circle-xmark', info: 'fa-circle-info', warning: 'fa-triangle-exclamation' };
    return map[type] || map.info;
  },
  _bg(type) {
    const map = { success: 'toast-success', error: 'toast-error', info: 'toast-info', warning: 'toast-warning' };
    return map[type] || map.info;
  },
  show(message, type = 'info', title = '') {
    const container = this._ensureContainer();
    const toast = document.createElement('div');
    toast.className = `toast ${this._bg(type)}`;
    toast.innerHTML = `
      <div class="toast-icon"><i class="fa-solid ${this._icon(type)}"></i></div>
      <div class="toast-body">
        ${title ? `<div class="toast-title">${title}</div>` : ''}
        <div class="toast-msg">${message}</div>
      <button class="toast-close" aria-label="Close notification"><i class="fa-solid fa-xmark"></i></button>
    `;
    container.appendChild(toast);
    const remove = () => { toast.style.animation = 'toastOut 0.3s ease forwards'; setTimeout(() => toast.remove(), 300); };
    toast.querySelector('.toast-close').addEventListener('click', remove);
    setTimeout(remove, 4000);
  },
  success(msg, title) { this.show(msg, 'success', title || 'Success'); },
  error(msg, title) { this.show(msg, 'error', title || 'Error'); },
  info(msg, title) { this.show(msg, 'info', title || 'Info'); },
  warning(msg, title) { this.show(msg, 'warning', title || 'Warning'); }
};

document.addEventListener('DOMContentLoaded', () => {
  const ui = new BDMSUI();
  ui.init();
});
