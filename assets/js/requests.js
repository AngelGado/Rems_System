/* Dashboard API client for shared shop records and revision polling. */

const isStaff = admin.dataset.role === 'staff';
let shopRevision = null;
let saleReceiptIds = new Set();
let transactionDetails = {};
let statusLoading = false;

// Sends a dashboard action with its CSRF token and exposes server conflict or permission messages.
async function shopRequest(action, fields = {}) {
    const body = new FormData();
    body.set('action', action);
    body.set('csrf', admin.dataset.csrf);
    for (const [key, value] of Object.entries(fields)) body.set(key, value);
    const response = await fetch(location.pathname, { method: 'POST', body });
    const data = await response.json();
    if (!response.ok) throw new Error(data.message || 'Shop records are temporarily unavailable.');
    return data;
}

// Updates the Staff Booking tab’s badge with the pending appointment count.
function updateBookingCount(count) {
    const badge = retail('#booking-nav-count');
    if (!badge) return;
    badge.hidden = !count;
    badge.textContent = count || '';
    badge.setAttribute('aria-label', count + ' pending appointment requests');
}

// Applies a current shop snapshot and broadcasts the update so views share the same revision.
function acceptShop(data) {
    if (shopRevision !== null && data.revision < shopRevision) return;
    shopRevision = data.revision;
    admin.dataset.pausedModules = JSON.stringify(data.pausedModules ?? []);
    updateBookingCount(data.pendingBookings);
    saleReceiptIds = new Set(data.saleReceiptIds ?? []);
    transactionDetails = data.transactionDetails ?? {};
    if (data.shop) {
        products = data.shop.products;
        records = data.shop.records;
        document.dispatchEvent(new Event('rems:shop-updated'));
    }
}

// Loads shared state and lets the administrator create the initial snapshot when no shop exists yet.
async function initializeShop() {
    try {
        const current = await shopRequest('shop_read');
        acceptShop(current);
        if (!current.shop) {
            if (isStaff) throw new Error('Ask your admin to open the dashboard to initialize the shop records.');
            await saveSharedShop(products, records);
        }
    } catch (error) {
        retail('#shop-load-error').textContent = error.message;
    }
    showSection('Dashboard');
}

// Saves administrator changes using the last known revision so stale clients cannot overwrite newer records.
async function saveSharedShop(nextProducts, nextRecords) {
    if (isStaff) throw new Error('This action is reserved for administrators.');
    if (shopRevision === null) throw new Error('Refresh the page before changing shop records.');
    acceptShop(await shopRequest('shop_save', {
        revision: shopRevision, shop: JSON.stringify({ products: nextProducts, records: nextRecords })
    }));
}

// Saves a staff-managed pet or customer record and applies the latest shared snapshot.
async function saveStaffRecord(type, payload) {
    acceptShop(await shopRequest('staff_record_save', { type, payload: JSON.stringify(payload) }));
}

// Polls revisions and booking counts, refreshing the current view only when shared data has changed.
async function checkRequestStatus() {
    if (document.hidden || statusLoading) return;
    statusLoading = true;
    try {
        const summary = await shopRequest('shop_status');
        updateBookingCount(summary.pendingBookings);
        if (shopRevision !== null && summary.revision > shopRevision && !document.querySelector('dialog[open]')) {
            const update = await shopRequest('shop_read');
            if (document.querySelector('dialog[open]')) return;
            const previousModules = admin.dataset.pausedModules;
            acceptShop(update);
            if (previousModules !== admin.dataset.pausedModules) {
                showSection(admin.dataset.page);
                return;
            }
            refreshDashboard();
            const page = admin.dataset.page;
            if (page === 'Inventory') renderProducts();
            else if (page === 'Customers') renderCustomers();
            else if (page === 'Point of Sale') { renderCategories(); refreshSale(); }
            else if (['Pets', 'Booking', scheduleName, 'Reports', staffName].includes(page)) renderOperation();
        }
    } catch {
        // The next poll retries a temporary connection failure.
    } finally {
        statusLoading = false;
    }
}

// Poll the lightweight status endpoint to refresh stock and bookings as other users save changes.
window.setInterval(checkRequestStatus, 5000);
document.addEventListener('visibilitychange', checkRequestStatus);
